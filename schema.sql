-- Ders Programi V6 - PostgreSQL/Supabase hazir sema
create extension if not exists pgcrypto;
create table if not exists profiles (id uuid primary key, full_name text not null, role text not null check(role in ('admin','teacher')), teacher_id uuid unique);
create table if not exists teachers (id uuid primary key default gen_random_uuid(), name text not null, active boolean not null default true);
alter table profiles add constraint profiles_teacher_fk foreign key (teacher_id) references teachers(id) on delete set null;
create table if not exists students (id uuid primary key default gen_random_uuid(), name text not null, instrument text not null, teacher_id uuid not null references teachers(id), phone text, note text, active boolean not null default true);
create table if not exists lessons (id uuid primary key default gen_random_uuid(), student_id uuid references students(id), teacher_id uuid not null references teachers(id), instrument text not null, lesson_date date not null, start_time time not null, duration_min int not null default 50, repeats_weekly boolean not null default false, status text not null default 'normal' check(status in ('normal','geldi','gelmedi','iptal','telafi')), notes text, changed boolean not null default false, updated_by uuid, updated_at timestamptz not null default now());
create table if not exists program_settings (id int primary key default 1 check(id=1), settings jsonb not null, updated_at timestamptz not null default now());
create table if not exists audit_log (id bigint generated always as identity primary key, actor_id uuid, entity_type text not null, entity_id text not null, action text not null, details jsonb, created_at timestamptz not null default now());

-- RLS: admin her seyi, ogretmen sadece kendi kayitlarini okuyabilir; ogretmen yazamaz.
alter table profiles enable row level security; alter table teachers enable row level security; alter table students enable row level security; alter table lessons enable row level security; alter table program_settings enable row level security; alter table audit_log enable row level security;
create or replace function app_role() returns text language sql stable as $$ select role from profiles where id=auth.uid() $$;
create or replace function app_teacher_id() returns uuid language sql stable as $$ select teacher_id from profiles where id=auth.uid() $$;
create policy profiles_self_or_admin on profiles for select using (id=auth.uid() or app_role()='admin');
create policy teachers_admin_all on teachers for all using (app_role()='admin') with check (app_role()='admin');
create policy teachers_self_read on teachers for select using (id=app_teacher_id());
create policy students_admin_all on students for all using (app_role()='admin') with check (app_role()='admin');
create policy students_teacher_read on students for select using (teacher_id=app_teacher_id());
create policy lessons_admin_all on lessons for all using (app_role()='admin') with check (app_role()='admin');
create policy lessons_teacher_read on lessons for select using (teacher_id=app_teacher_id());
create policy settings_read on program_settings for select using (auth.uid() is not null);
create policy settings_admin_write on program_settings for all using (app_role()='admin') with check (app_role()='admin');
create policy audit_admin_read on audit_log for select using (app_role()='admin');
