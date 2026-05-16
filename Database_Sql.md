-- =========================================================
-- CHEFZITO DATABASE
-- PostgreSQL / Supabase Ready
-- =========================================================

-- =========================================================
-- EXTENSIONS
-- =========================================================

create extension if not exists "uuid-ossp";
create extension if not exists "pgcrypto";
create extension if not exists "vector";

-- =========================================================
-- ENUMS
-- =========================================================

create type difficulty_level as enum (
  'easy',
  'medium',
  'hard'
);

create type visibility_type as enum (
  'public',
  'private',
  'followers'
);

create type notification_type as enum (
  'like',
  'comment',
  'follow',
  'recipe_like',
  'mention'
);

create type message_role as enum (
  'user',
  'assistant'
);

-- =========================================================
-- USERS
-- =========================================================

create table public.users (
  id uuid primary key default auth.uid(),

  username varchar(50) unique not null,
  email varchar(255) unique not null,

  full_name varchar(120),

  avatar_url text,
  bio text,

  is_verified boolean default false,

  followers_count integer default 0,
  following_count integer default 0,

  created_at timestamptz default now(),
  updated_at timestamptz default now()
);

-- =========================================================
-- MASTER INGREDIENTS
-- =========================================================

create table public.ingredients_master (
  id uuid primary key default gen_random_uuid(),

  name varchar(120) not null unique,
  normalized_name varchar(120) not null unique,

  category varchar(80),

  image_url text,

  created_at timestamptz default now()
);

-- =========================================================
-- USER INVENTORY
-- =========================================================

create table public.user_ingredients (
  id uuid primary key default gen_random_uuid(),

  user_id uuid not null references public.users(id) on delete cascade,

  ingredient_id uuid not null references public.ingredients_master(id) on delete cascade,

  quantity numeric(10,2) not null default 0,

  unit varchar(20),

  expires_at date,

  created_at timestamptz default now()
);

-- =========================================================
-- RECIPES
-- =========================================================

create table public.recipes (
  id uuid primary key default gen_random_uuid(),

  author_id uuid not null references public.users(id) on delete cascade,

  title varchar(200) not null,

  description text,

  cover_image_url text,

  prep_time_min integer,

  servings integer default 1,

  difficulty difficulty_level default 'easy',

  visibility visibility_type default 'public',

  ai_generated boolean default false,

  likes_count integer default 0,
  saves_count integer default 0,

  embedding vector(1536),

  created_at timestamptz default now(),
  updated_at timestamptz default now()
);

-- =========================================================
-- RECIPE STEPS
-- =========================================================

create table public.recipe_steps (
  id uuid primary key default gen_random_uuid(),

  recipe_id uuid not null references public.recipes(id) on delete cascade,

  step_number integer not null,

  instruction text not null,

  image_url text,

  created_at timestamptz default now()
);

-- =========================================================
-- RECIPE INGREDIENTS
-- =========================================================

create table public.recipe_ingredients (
  id uuid primary key default gen_random_uuid(),

  recipe_id uuid not null references public.recipes(id) on delete cascade,

  ingredient_id uuid not null references public.ingredients_master(id),

  quantity numeric(10,2),

  unit varchar(20),

  optional boolean default false
);

-- =========================================================
-- TAGS
-- =========================================================

create table public.tags (
  id uuid primary key default gen_random_uuid(),

  name varchar(60) unique not null
);

create table public.recipe_tags (
  recipe_id uuid references public.recipes(id) on delete cascade,
  tag_id uuid references public.tags(id) on delete cascade,

  primary key (recipe_id, tag_id)
);

-- =========================================================
-- POSTS
-- =========================================================

create table public.posts (
  id uuid primary key default gen_random_uuid(),

  user_id uuid not null references public.users(id) on delete cascade,

  recipe_id uuid references public.recipes(id) on delete set null,

  media_url text,

  caption text,

  likes_count integer default 0,
  comments_count integer default 0,

  created_at timestamptz default now()
);

-- =========================================================
-- POST LIKES
-- =========================================================

create table public.post_likes (
  user_id uuid references public.users(id) on delete cascade,
  post_id uuid references public.posts(id) on delete cascade,

  created_at timestamptz default now(),

  primary key(user_id, post_id)
);

-- =========================================================
-- POST COMMENTS
-- =========================================================

create table public.post_comments (
  id uuid primary key default gen_random_uuid(),

  post_id uuid not null references public.posts(id) on delete cascade,

  user_id uuid not null references public.users(id) on delete cascade,

  comment text not null,

  created_at timestamptz default now()
);

-- =========================================================
-- RECIPE LIKES
-- =========================================================

create table public.recipe_likes (
  user_id uuid references public.users(id) on delete cascade,
  recipe_id uuid references public.recipes(id) on delete cascade,

  created_at timestamptz default now(),

  primary key(user_id, recipe_id)
);

-- =========================================================
-- SAVED RECIPES
-- =========================================================

create table public.saved_recipes (
  user_id uuid references public.users(id) on delete cascade,
  recipe_id uuid references public.recipes(id) on delete cascade,

  created_at timestamptz default now(),

  primary key(user_id, recipe_id)
);

-- =========================================================
-- USER FOLLOWS
-- =========================================================

create table public.user_follows (
  follower_id uuid references public.users(id) on delete cascade,
  following_id uuid references public.users(id) on delete cascade,

  created_at timestamptz default now(),

  primary key(follower_id, following_id),

  check (follower_id <> following_id)
);

-- =========================================================
-- CHAT SESSIONS
-- =========================================================

create table public.chat_sessions (
  id uuid primary key default gen_random_uuid(),

  user_id uuid not null references public.users(id) on delete cascade,

  ingredients_snapshot jsonb,

  created_at timestamptz default now()
);

-- =========================================================
-- CHAT MESSAGES
-- =========================================================

create table public.chat_messages (
  id uuid primary key default gen_random_uuid(),

  session_id uuid not null references public.chat_sessions(id) on delete cascade,

  role message_role not null,

  content text not null,

  suggested_recipe_id uuid references public.recipes(id) on delete set null,

  created_at timestamptz default now()
);

-- =========================================================
-- AI RECOMMENDATIONS
-- =========================================================

create table public.ai_recommendations (
  id uuid primary key default gen_random_uuid(),

  user_id uuid references public.users(id) on delete cascade,

  recipe_id uuid references public.recipes(id) on delete cascade,

  score numeric(5,2),

  reason text,

  created_at timestamptz default now()
);

-- =========================================================
-- NOTIFICATIONS
-- =========================================================

create table public.notifications (
  id uuid primary key default gen_random_uuid(),

  user_id uuid not null references public.users(id) on delete cascade,

  actor_id uuid references public.users(id) on delete cascade,

  type notification_type not null,

  post_id uuid references public.posts(id) on delete cascade,

  recipe_id uuid references public.recipes(id) on delete cascade,

  is_read boolean default false,

  created_at timestamptz default now()
);

-- =========================================================
-- REPORTS
-- =========================================================

create table public.reports (
  id uuid primary key default gen_random_uuid(),

  reporter_id uuid references public.users(id) on delete cascade,

  reported_post_id uuid references public.posts(id) on delete cascade,

  reason text not null,

  created_at timestamptz default now()
);

-- =========================================================
-- INDEXES
-- =========================================================

create index idx_users_username
on public.users(username);

create index idx_recipes_author
on public.recipes(author_id);

create index idx_recipe_title
on public.recipes(title);

create index idx_recipe_embedding
on public.recipes
using ivfflat (embedding vector_cosine_ops);

create index idx_posts_user
on public.posts(user_id);

create index idx_post_comments_post
on public.post_comments(post_id);

create index idx_notifications_user
on public.notifications(user_id);

create index idx_ingredients_name
on public.ingredients_master(normalized_name);

-- =========================================================
-- UPDATED_AT TRIGGER
-- =========================================================

create or replace function public.handle_updated_at()
returns trigger
language plpgsql
as $$
begin
  new.updated_at = now();
  return new;
end;
$$;

create trigger trg_users_updated_at
before update on public.users
for each row
execute function public.handle_updated_at();

create trigger trg_recipes_updated_at
before update on public.recipes
for each row
execute function public.handle_updated_at();

-- =========================================================
-- AUTO CREATE USER PROFILE
-- =========================================================

create or replace function public.handle_new_user()
returns trigger
language plpgsql
security definer
as $$
begin
  insert into public.users (
    id,
    email,
    username
  )
  values (
    new.id,
    new.email,
    split_part(new.email, '@', 1)
  );

  return new;
end;
$$;

create trigger on_auth_user_created
after insert on auth.users
for each row
execute procedure public.handle_new_user();

-- =========================================================
-- ENABLE ROW LEVEL SECURITY
-- =========================================================

alter table public.users enable row level security;
alter table public.recipes enable row level security;
alter table public.posts enable row level security;
alter table public.post_comments enable row level security;
alter table public.post_likes enable row level security;
alter table public.recipe_likes enable row level security;
alter table public.saved_recipes enable row level security;
alter table public.user_follows enable row level security;
alter table public.user_ingredients enable row level security;
alter table public.chat_sessions enable row level security;
alter table public.chat_messages enable row level security;
alter table public.notifications enable row level security;

-- =========================================================
-- USERS POLICIES
-- =========================================================

create policy "Users are viewable by everyone"
on public.users
for select
using (true);

create policy "Users can update own profile"
on public.users
for update
using (auth.uid() = id);

-- =========================================================
-- RECIPES POLICIES
-- =========================================================

create policy "Recipes are viewable by everyone"
on public.recipes
for select
using (visibility = 'public');

create policy "Users can insert own recipes"
on public.recipes
for insert
with check (auth.uid() = author_id);

create policy "Users can update own recipes"
on public.recipes
for update
using (auth.uid() = author_id);

create policy "Users can delete own recipes"
on public.recipes
for delete
using (auth.uid() = author_id);

-- =========================================================
-- POSTS POLICIES
-- =========================================================

create policy "Posts are viewable by everyone"
on public.posts
for select
using (true);

create policy "Users can create posts"
on public.posts
for insert
with check (auth.uid() = user_id);

create policy "Users can update own posts"
on public.posts
for update
using (auth.uid() = user_id);

create policy "Users can delete own posts"
on public.posts
for delete
using (auth.uid() = user_id);

-- =========================================================
-- COMMENTS POLICIES
-- =========================================================

create policy "Comments visible to everyone"
on public.post_comments
for select
using (true);

create policy "Users can create comments"
on public.post_comments
for insert
with check (auth.uid() = user_id);

create policy "Users can delete own comments"
on public.post_comments
for delete
using (auth.uid() = user_id);

-- =========================================================
-- LIKES POLICIES
-- =========================================================

create policy "Likes visible to everyone"
on public.post_likes
for select
using (true);

create policy "Users can like posts"
on public.post_likes
for insert
with check (auth.uid() = user_id);

create policy "Users can unlike own likes"
on public.post_likes
for delete
using (auth.uid() = user_id);

-- =========================================================
-- FOLLOWS POLICIES
-- =========================================================

create policy "Follows visible to everyone"
on public.user_follows
for select
using (true);

create policy "Users can follow"
on public.user_follows
for insert
with check (auth.uid() = follower_id);

create policy "Users can unfollow"
on public.user_follows
for delete
using (auth.uid() = follower_id);

-- =========================================================
-- STORAGE BUCKETS
-- =========================================================

insert into storage.buckets (id, name, public)
values
('avatars', 'avatars', true),
('recipes', 'recipes', true),
('posts', 'posts', true);

-- =========================================================
-- STORAGE POLICIES
-- =========================================================

create policy "Avatar images are public"
on storage.objects
for select
using (bucket_id = 'avatars');

create policy "Anyone can upload avatar"
on storage.objects
for insert
with check (bucket_id = 'avatars');

create policy "Recipe images public"
on storage.objects
for select
using (bucket_id = 'recipes');

create policy "Users can upload recipe images"
on storage.objects
for insert
with check (bucket_id = 'recipes');

create policy "Posts images public"
on storage.objects
for select
using (bucket_id = 'posts');

create policy "Users can upload post images"
on storage.objects
for insert
with check (bucket_id = 'posts');

-- =========================================================
-- SAMPLE TAGS
-- =========================================================

insert into public.tags(name)
values
('vegano'),
('fitness'),
('rápido'),
('postres'),
('desayuno'),
('colombiana'),
('italiana'),
('saludable'),
('económica');

-- =========================================================
-- SAMPLE INGREDIENTS
-- =========================================================

insert into public.ingredients_master(
  name,
  normalized_name,
  category
)
values
('Tomate', 'tomate', 'vegetales'),
('Cebolla', 'cebolla', 'vegetales'),
('Pollo', 'pollo', 'proteína'),
('Arroz', 'arroz', 'granos'),
('Queso', 'queso', 'lácteos'),
('Huevo', 'huevo', 'proteína');

-- =========================================================
-- FINISHED
-- =========================================================