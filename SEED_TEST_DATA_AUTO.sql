-- =========================================================
-- SEED DATA AUTOMATICO - CHEFZITO (SIN REEMPLAZAR UUIDs)
-- =========================================================
-- 1) Crea los 3 usuarios en Supabase Auth:
--    Authentication -> Users -> Add user
--    juan@chefzito.com / chef1234
--    maria@chefzito.com / maria1234
--    luis@chefzito.com / luis1234
--
-- 2) Ejecuta TODO este script en SQL Editor.

-- =========================================================
-- USUARIOS EN public.users
-- =========================================================
INSERT INTO public.users (
  id,
  username,
  email,
  full_name,
  avatar_url,
  created_at,
  updated_at
)
SELECT
  u.id,
  CASE u.email
    WHEN 'juan@chefzito.com' THEN 'chefjuan'
    WHEN 'maria@chefzito.com' THEN 'mariacocina'
    WHEN 'luis@chefzito.com' THEN 'luisgrill'
  END AS username,
  u.email,
  CASE u.email
    WHEN 'juan@chefzito.com' THEN 'Juan Chef'
    WHEN 'maria@chefzito.com' THEN 'Maria Cocina'
    WHEN 'luis@chefzito.com' THEN 'Luis Grill'
  END AS full_name,
  CASE u.email
    WHEN 'juan@chefzito.com' THEN 'assets/img/avatar1.png'
    WHEN 'maria@chefzito.com' THEN 'assets/img/avatar2.png'
    WHEN 'luis@chefzito.com' THEN 'assets/img/avatar3.png'
  END AS avatar_url,
  CASE u.email
    WHEN 'juan@chefzito.com' THEN '2026-04-01T10:00:00Z'::timestamptz
    WHEN 'maria@chefzito.com' THEN '2026-04-02T11:00:00Z'::timestamptz
    WHEN 'luis@chefzito.com' THEN '2026-04-03T12:00:00Z'::timestamptz
  END AS created_at,
  CASE u.email
    WHEN 'juan@chefzito.com' THEN '2026-04-01T10:00:00Z'::timestamptz
    WHEN 'maria@chefzito.com' THEN '2026-04-02T11:00:00Z'::timestamptz
    WHEN 'luis@chefzito.com' THEN '2026-04-03T12:00:00Z'::timestamptz
  END AS updated_at
FROM auth.users u
WHERE u.email IN ('juan@chefzito.com', 'maria@chefzito.com', 'luis@chefzito.com')
ON CONFLICT (id) DO NOTHING;

-- =========================================================
-- RECETAS
-- =========================================================
INSERT INTO public.recipes (
  author_id,
  title,
  description,
  cover_image_url,
  prep_time_min,
  difficulty,
  ai_generated,
  visibility,
  created_at,
  updated_at
)
SELECT
  u.id,
  v.title,
  v.description,
  v.cover_image_url,
  v.prep_time_min,
  v.difficulty,
  v.ai_generated,
  'public'::visibility_type,
  v.created_at,
  v.created_at
FROM (
  VALUES
    ('juan@chefzito.com', 'Pasta Alfredo', 'Pasta cremosa en 20 minutos', 'assets/img/recipe1.png', 20, 'easy'::difficulty_level, false, '2026-04-01T10:00:00Z'::timestamptz),
    ('maria@chefzito.com', 'Ensalada Mediterranea', 'Fresca y saludable', 'assets/img/recipe2.png', 15, 'easy'::difficulty_level, true, '2026-04-02T11:00:00Z'::timestamptz),
    ('luis@chefzito.com', 'Tacos de Res', 'Tacos caseros para la cena', 'assets/img/recipe3.png', 25, 'medium'::difficulty_level, false, '2026-04-03T12:00:00Z'::timestamptz)
) AS v(email, title, description, cover_image_url, prep_time_min, difficulty, ai_generated, created_at)
JOIN public.users u ON u.email = v.email
WHERE NOT EXISTS (
  SELECT 1 FROM public.recipes r WHERE r.title = v.title AND r.author_id = u.id
);

-- =========================================================
-- PASOS DE RECETAS
-- =========================================================
INSERT INTO public.recipe_steps (
  recipe_id,
  step_number,
  instruction
)
SELECT
  r.id,
  s.step_number,
  s.instruction
FROM (
  VALUES
    ('Pasta Alfredo', 1, 'Llena una olla grande con agua, agrega una cucharada de sal y lleva a hervor fuerte.'),
    ('Pasta Alfredo', 2, 'Cuando el agua hierva, agrega la pasta y cocinala al dente segun el tiempo del paquete.'),
    ('Pasta Alfredo', 3, 'Antes de colar, reserva una taza del agua de coccion para ajustar la salsa al final.'),
    ('Pasta Alfredo', 4, 'En una sarten amplia, derrite mantequilla a fuego medio sin dejar que se queme.'),
    ('Pasta Alfredo', 5, 'Anade ajo finamente picado y cocina 30 segundos hasta que suelte aroma.'),
    ('Pasta Alfredo', 6, 'Incorpora crema de leche, mezcla bien y cocina 2 minutos para que tome cuerpo.'),
    ('Pasta Alfredo', 7, 'Agrega queso parmesano rallado poco a poco, revolviendo para lograr una salsa lisa.'),
    ('Pasta Alfredo', 8, 'Sazona con sal, pimienta y una pizca de nuez moscada; ajusta textura con agua de pasta.'),
    ('Pasta Alfredo', 9, 'Pasa la pasta cocida a la sarten, mezcla durante 1 minuto y sirve caliente con mas parmesano.'),
    ('Ensalada Mediterranea', 1, 'Lava bien tomate, pepino, pimiento y hojas verdes con agua fria y escurre por completo.'),
    ('Ensalada Mediterranea', 2, 'Corta los tomates en cubos medianos y el pepino en medias lunas finas.'),
    ('Ensalada Mediterranea', 3, 'Corta cebolla morada en pluma delgada y dejala 5 minutos en agua fria para suavizar sabor.'),
    ('Ensalada Mediterranea', 4, 'Pica pimiento rojo en tiras cortas y desmenuza queso feta en trozos pequenos.'),
    ('Ensalada Mediterranea', 5, 'En un bowl grande coloca hojas verdes, tomate, pepino, cebolla y pimiento.'),
    ('Ensalada Mediterranea', 6, 'Anade aceitunas negras y mezcla suavemente para no romper los ingredientes.'),
    ('Ensalada Mediterranea', 7, 'Prepara un aderezo con aceite de oliva, jugo de limon, oregano seco, sal y pimienta.'),
    ('Ensalada Mediterranea', 8, 'Vierte el aderezo sobre la ensalada y mezcla con movimientos envolventes.'),
    ('Ensalada Mediterranea', 9, 'Termina con queso feta por encima y deja reposar 3 minutos antes de servir.'),
    ('Tacos de Res', 1, 'Corta la carne de res en tiras finas y secala con papel para que dore mejor.'),
    ('Tacos de Res', 2, 'Mezcla en un bowl ajo picado, comino, paprika, sal, pimienta y un chorrito de aceite.'),
    ('Tacos de Res', 3, 'Agrega la carne al adobo y deja reposar al menos 10 minutos para potenciar sabor.'),
    ('Tacos de Res', 4, 'Calienta una sarten grande a fuego alto y cocina la carne en tandas para evitar humedad.'),
    ('Tacos de Res', 5, 'Cuando la carne este dorada, baja a fuego medio y agrega cebolla picada y pimiento.'),
    ('Tacos de Res', 6, 'Cocina 3 minutos mas hasta que la cebolla este suave y corrige sal al gusto.'),
    ('Tacos de Res', 7, 'Calienta tortillas en comal o sarten seca, 20 segundos por lado, y mantenlas tapadas.'),
    ('Tacos de Res', 8, 'Arma cada taco con carne, cilantro, cebolla fresca y unas gotas de limon.'),
    ('Tacos de Res', 9, 'Sirve con salsa al gusto y acompana con guacamole o frijoles para una cena completa.')
) AS s(title, step_number, instruction)
JOIN public.recipes r ON r.title = s.title
WHERE NOT EXISTS (
  SELECT 1 FROM public.recipe_steps rs WHERE rs.recipe_id = r.id AND rs.step_number = s.step_number
);

-- =========================================================
-- POSTS
-- =========================================================
INSERT INTO public.posts (
  user_id,
  recipe_id,
  caption,
  likes_count,
  comments_count,
  created_at
)
SELECT
  u.id,
  r.id,
  v.caption,
  v.likes_count,
  v.comments_count,
  v.created_at
FROM (
  VALUES
    ('juan@chefzito.com', 'Pasta Alfredo', 'Mi pasta favorita para hoy', 5, 1, '2026-04-10T16:00:00Z'::timestamptz),
    ('maria@chefzito.com', 'Ensalada Mediterranea', 'Comida ligera para la tarde', 3, 1, '2026-04-11T13:30:00Z'::timestamptz),
    ('luis@chefzito.com', 'Tacos de Res', 'Mi cena de hoy', 7, 0, '2026-04-12T19:00:00Z'::timestamptz)
) AS v(email, recipe_title, caption, likes_count, comments_count, created_at)
JOIN public.users u ON u.email = v.email
JOIN public.recipes r ON r.title = v.recipe_title
WHERE NOT EXISTS (
  SELECT 1 FROM public.posts p WHERE p.caption = v.caption AND p.user_id = u.id
);

-- =========================================================
-- COMENTARIOS
-- =========================================================
INSERT INTO public.post_comments (
  post_id,
  user_id,
  comment,
  created_at
)
SELECT
  p.id,
  u.id,
  v.comment,
  v.created_at
FROM (
  VALUES
    ('Mi pasta favorita para hoy', 'maria@chefzito.com', 'Se ve deliciosa', '2026-04-10T16:40:00Z'::timestamptz),
    ('Comida ligera para la tarde', 'juan@chefzito.com', 'La voy a probar', '2026-04-11T14:10:00Z'::timestamptz)
) AS v(post_caption, email, comment, created_at)
JOIN public.posts p ON p.caption = v.post_caption
JOIN public.users u ON u.email = v.email
WHERE NOT EXISTS (
  SELECT 1 FROM public.post_comments c WHERE c.post_id = p.id AND c.user_id = u.id AND c.comment = v.comment
);

-- =========================================================
-- FOLLOWS
-- =========================================================
INSERT INTO public.user_follows (
  follower_id,
  following_id,
  created_at
)
SELECT
  f.id,
  t.id,
  v.created_at
FROM (
  VALUES
    ('juan@chefzito.com', 'maria@chefzito.com', '2026-04-10T10:00:00Z'::timestamptz),
    ('maria@chefzito.com', 'juan@chefzito.com', '2026-04-10T11:00:00Z'::timestamptz),
    ('juan@chefzito.com', 'luis@chefzito.com', '2026-04-10T12:00:00Z'::timestamptz)
) AS v(follower_email, following_email, created_at)
JOIN public.users f ON f.email = v.follower_email
JOIN public.users t ON t.email = v.following_email
ON CONFLICT DO NOTHING;

-- =========================================================
-- POST LIKES
-- =========================================================
INSERT INTO public.post_likes (
  user_id,
  post_id,
  created_at
)
SELECT
  u.id,
  p.id,
  v.created_at
FROM (
  VALUES
    ('maria@chefzito.com', 'Mi pasta favorita para hoy', '2026-04-10T16:05:00Z'::timestamptz),
    ('luis@chefzito.com', 'Mi pasta favorita para hoy', '2026-04-10T16:10:00Z'::timestamptz),
    ('juan@chefzito.com', 'Comida ligera para la tarde', '2026-04-11T13:35:00Z'::timestamptz),
    ('luis@chefzito.com', 'Mi cena de hoy', '2026-04-12T19:05:00Z'::timestamptz)
) AS v(email, post_caption, created_at)
JOIN public.users u ON u.email = v.email
JOIN public.posts p ON p.caption = v.post_caption
ON CONFLICT DO NOTHING;

-- =========================================================
-- RECIPE LIKES
-- =========================================================
INSERT INTO public.recipe_likes (
  user_id,
  recipe_id,
  created_at
)
SELECT
  u.id,
  r.id,
  v.created_at
FROM (
  VALUES
    ('maria@chefzito.com', 'Pasta Alfredo', '2026-04-10T16:05:00Z'::timestamptz),
    ('luis@chefzito.com', 'Pasta Alfredo', '2026-04-10T16:10:00Z'::timestamptz),
    ('juan@chefzito.com', 'Ensalada Mediterranea', '2026-04-11T13:35:00Z'::timestamptz),
    ('luis@chefzito.com', 'Tacos de Res', '2026-04-12T19:05:00Z'::timestamptz)
) AS v(email, recipe_title, created_at)
JOIN public.users u ON u.email = v.email
JOIN public.recipes r ON r.title = v.recipe_title
ON CONFLICT DO NOTHING;

-- =========================================================
-- SAVED RECIPES
-- =========================================================
INSERT INTO public.saved_recipes (
  user_id,
  recipe_id,
  created_at
)
SELECT
  u.id,
  r.id,
  v.created_at
FROM (
  VALUES
    ('juan@chefzito.com', 'Ensalada Mediterranea', '2026-04-10T10:00:00Z'::timestamptz),
    ('maria@chefzito.com', 'Tacos de Res', '2026-04-11T11:00:00Z'::timestamptz),
    ('luis@chefzito.com', 'Pasta Alfredo', '2026-04-12T12:00:00Z'::timestamptz)
) AS v(email, recipe_title, created_at)
JOIN public.users u ON u.email = v.email
JOIN public.recipes r ON r.title = v.recipe_title
ON CONFLICT DO NOTHING;

-- =========================================================
-- VERIFICACION
-- =========================================================
-- SELECT COUNT(*) AS total_users FROM public.users;
-- SELECT COUNT(*) AS total_recipes FROM public.recipes;
-- SELECT COUNT(*) AS total_posts FROM public.posts;
-- SELECT COUNT(*) AS total_comments FROM public.post_comments;
-- SELECT COUNT(*) AS total_follows FROM public.user_follows;
-- SELECT COUNT(*) AS total_post_likes FROM public.post_likes;
-- SELECT COUNT(*) AS total_recipe_likes FROM public.recipe_likes;
-- SELECT COUNT(*) AS total_saved FROM public.saved_recipes;
