# Order Desk — deploy on Render

## What's in this folder
- `index.html` — the dashboard, with two placeholders instead of real keys
- `build.sh` — swaps the placeholders for your real keys during deploy

## Steps on Render
1. Push this folder to a GitHub repo (or use Render's "Upload" option if available).
2. On Render: **New → Static Site**, connect the repo.
3. Set:
   - **Build Command:** `bash build.sh`
   - **Publish Directory:** `dist`
4. Go to the site's **Environment** tab and add two variables:
   - `SUPABASE_URL` → `https://femiwjswrnrilnkhdnnm.supabase.co`
   - `SUPABASE_ANON_KEY` → your anon/public key
5. Deploy. Render runs `build.sh`, which writes `dist/index.html` with your real
   keys baked in, and serves that.

## Note on RLS
The anon key ends up visible in the page source either way — that's normal for
a client-side dashboard. What keeps it safe is Row Level Security on the
`orders` table in Supabase, restricted to read-only for the anon role. If you
haven't run this yet, do it in the Supabase SQL editor:

```sql
alter table orders enable row level security;

create policy "Allow read for dashboard"
on orders for select
to anon
using (true);
```

## If you ever need to change keys
Update the environment variables in Render and redeploy — no code changes
needed, `index.html` never has to touch a real key directly.
