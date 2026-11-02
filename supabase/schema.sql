-- Social Eyewear บัญชีร้าน: ฐานข้อมูลของแอปนี้
-- แก้อีเมลบรรทัดล่างสุดเป็นอีเมลของคุณ แล้วรันทั้งไฟล์ใน Supabase > SQL Editor (รันซ้ำได้)

create table if not exists public.app_members (
  email text primary key
);

create table if not exists public.app_docs (
  col text not null check (col in ('products','sales','ledger','events')),
  id text not null,
  data jsonb not null,
  updated_at timestamptz not null default now(),
  primary key (col, id)
);

alter table public.app_members enable row level security;
alter table public.app_docs enable row level security;

create or replace function public.is_member()
returns boolean
language sql
stable
security definer
set search_path = ''
as $$
  select exists (
    select 1 from public.app_members m
    where lower(m.email) = lower(auth.jwt() ->> 'email')
  );
$$;

revoke all on function public.is_member() from public, anon;
grant execute on function public.is_member() to authenticated;

revoke all on public.app_members from anon, authenticated;
revoke all on public.app_docs from anon;
grant select, insert, update, delete on public.app_docs to authenticated;

drop policy if exists app_docs_select on public.app_docs;
create policy app_docs_select on public.app_docs for select to authenticated using (public.is_member());
drop policy if exists app_docs_insert on public.app_docs;
create policy app_docs_insert on public.app_docs for insert to authenticated with check (public.is_member());
drop policy if exists app_docs_update on public.app_docs;
create policy app_docs_update on public.app_docs for update to authenticated using (public.is_member()) with check (public.is_member());
drop policy if exists app_docs_delete on public.app_docs;
create policy app_docs_delete on public.app_docs for delete to authenticated using (public.is_member());

-- ผู้ที่ใช้แอปได้: เพิ่มได้หลายอีเมล
insert into public.app_members (email) values ('your-email@example.com')
on conflict (email) do nothing;
