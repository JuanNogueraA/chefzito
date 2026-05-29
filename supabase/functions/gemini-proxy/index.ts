// Follow this setup guide to integrate the Deno language server with your editor:
// https://deno.land/manual/getting_started/setup_your_environment
// This enables autocomplete, go to definition, etc.

// Setup type definitions for built-in Supabase Runtime APIs
import "@supabase/functions-js/edge-runtime.d.ts"

const corsHeaders = {
  "Access-Control-Allow-Origin": "*",
  "Access-Control-Allow-Headers": "authorization, x-client-info, apikey, content-type",
}

const recentRequests = new Map<string, number>()
const rateLimitWindowMs = 4000
const maxBodyBytes = 1500000
const allowedModels = new Set(["gemini-2.5-flash", "gemini-1.5-flash", "gemini-1.5-pro"])

Deno.serve(async (req) => {
  if (req.method === "OPTIONS") {
    return new Response("ok", { headers: corsHeaders })
  }

  const authHeader = req.headers.get("authorization")
  if (!authHeader) {
    return new Response(JSON.stringify({ error: "Missing Authorization header" }), {
      status: 401,
      headers: { ...corsHeaders, "Content-Type": "application/json" },
    })
  }

  const ip = req.headers.get("x-forwarded-for")?.split(",")[0]?.trim() ?? "unknown"
  const lastRequest = recentRequests.get(ip)
  const now = Date.now()
  if (lastRequest && now - lastRequest < rateLimitWindowMs) {
    return new Response(JSON.stringify({ error: "Too many requests. Try again in a few seconds." }), {
      status: 429,
      headers: { ...corsHeaders, "Content-Type": "application/json" },
    })
  }
  recentRequests.set(ip, now)

  const contentLength = Number(req.headers.get("content-length") ?? "0")
  if (contentLength > maxBodyBytes) {
    return new Response(JSON.stringify({ error: "Payload too large" }), {
      status: 413,
      headers: { ...corsHeaders, "Content-Type": "application/json" },
    })
  }

  const apiKey = Deno.env.get("GEMINI_API_KEY")
  if (!apiKey) {
    return new Response(JSON.stringify({ error: "Missing GEMINI_API_KEY secret" }), {
      status: 500,
      headers: { ...corsHeaders, "Content-Type": "application/json" },
    })
  }

  let body: {
    prompt?: string
    contents?: unknown
    model?: string
    imageBase64?: string
    mimeType?: string
    maxIngredients?: number
    mode?: string
    ingredients?: string[]
    maxSteps?: number
  }
  try {
    body = await req.json()
  } catch (error) {
    return new Response(JSON.stringify({ error: "Invalid JSON body", detail: String(error) }), {
      status: 400,
      headers: { ...corsHeaders, "Content-Type": "application/json" },
    })
  }

  const modelCandidate = body.model ?? "gemini-2.5-flash"
  const model = allowedModels.has(modelCandidate) ? modelCandidate : "gemini-2.5-flash"
  const mode = body.mode ?? (body.imageBase64 ? "ingredients" : "text")
  const maxIngredients = Math.min(Math.max(body.maxIngredients ?? 10, 3), 15)
  const maxSteps = Math.min(Math.max(body.maxSteps ?? 6, 3), 10)
  const sanitizedIngredients = Array.isArray(body.ingredients)
    ? body.ingredients.filter((item) => typeof item === "string" && item.trim().length > 0).slice(0, 12)
    : []

  if (mode === "recipe" && sanitizedIngredients.length === 0) {
    return new Response(JSON.stringify({ error: "Provide 'ingredients' for recipe mode" }), {
      status: 400,
      headers: { ...corsHeaders, "Content-Type": "application/json" },
    })
  }

  const recipePrompt =
    `Eres Chefzito AI. Genera una receta clara y casera usando SOLO estos ingredientes: ${sanitizedIngredients.join(", ")}. ` +
    `Devuelve SOLO JSON válido, sin markdown ni texto extra, con este formato: ` +
    `{` +
    `"title":"",` +
    `"description":"",` +
    `"prepTimeMin":20,` +
    `"difficulty":"easy|medium|hard",` +
    `"ingredients":[""],` +
    `"steps":[""]` +
    `}. ` +
    `Máximo ${maxSteps} pasos. Responde en español.`

  const ingredientPrompt = body.prompt ??
    `Detecta ingredientes de cocina en la imagen. Devuelve SOLO JSON válido con el formato: {"ingredients":["ingrediente"]}. Máximo ${maxIngredients} ingredientes.`

  const prompt = mode === "recipe" ? recipePrompt : ingredientPrompt
  const contents = body.contents ??
    (body.imageBase64
      ? [
          {
            role: "user",
            parts: [
              { text: prompt },
              { inlineData: { mimeType: body.mimeType ?? "image/jpeg", data: body.imageBase64 } },
            ],
          },
        ]
      : prompt
        ? [{ role: "user", parts: [{ text: prompt }] }]
        : null)

  if (!contents) {
    return new Response(JSON.stringify({ error: "Provide 'prompt' or 'contents' in body" }), {
      status: 400,
      headers: { ...corsHeaders, "Content-Type": "application/json" },
    })
  }

  if (body.imageBase64 && body.imageBase64.length > maxBodyBytes) {
    return new Response(JSON.stringify({ error: "Image payload too large" }), {
      status: 413,
      headers: { ...corsHeaders, "Content-Type": "application/json" },
    })
  }

  const url = `https://generativelanguage.googleapis.com/v1beta/models/${model}:generateContent?key=${apiKey}`

  const geminiResponse = await fetch(url, {
    method: "POST",
    headers: { "Content-Type": "application/json" },
    body: JSON.stringify({
      contents,
      generationConfig: { temperature: 0.2, maxOutputTokens: 1024 },
    }),
  })

  const responseText = await geminiResponse.text()

  return new Response(responseText, {
    status: geminiResponse.status,
    headers: { ...corsHeaders, "Content-Type": "application/json" },
  })
})

/* To invoke locally:

  1. Run `supabase start` (see: https://supabase.com/docs/reference/cli/supabase-start)
  2. Make an HTTP request:

  curl -i --location --request POST 'http://127.0.0.1:54321/functions/v1/gemini-proxy' \
    --header 'Authorization: Bearer eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpc3MiOiJzdXBhYmFzZS1kZW1vIiwicm9sZSI6ImFub24iLCJleHAiOjE5ODM4MTI5OTZ9.CRXP1A7WOeoJeXxjNni43kdQwgnWNReilDMblYTn_I0' \
    --header 'Content-Type: application/json' \
    --data '{"name":"Functions"}'

*/
