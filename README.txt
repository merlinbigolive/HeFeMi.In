HeFeMi — Supabase account integration

Files
- index.html: updated HeFeMi website with Supabase Email + Password signup/login.

Before testing on your live website
1. Upload index.html to your HTTPS website hosting and replace the previous index.html.
2. In Supabase Dashboard, open Authentication > URL Configuration.
3. Set Site URL to your website's main HTTPS URL.
4. Add your website URL (and any preview/deployment URL you use) to Redirect URLs.
5. Keep Email provider enabled and email confirmation enabled.

What is connected
- Client signup with adult-age validation (18+), email/password and profile creation through the database trigger.
- Therapist signup with email/password and automatic pending therapist profile.
- Client and therapist email/password login, role checks, logout.
- Client dashboard reads profile, bookings and transactions subject to your existing RLS policies.
- Therapist page shows approval status.

Still not connected / limitations
- Selfie camera is preview-only. It is not uploaded to Supabase Storage and does not verify identity.
- Booking requests still open WhatsApp. They are not inserted into the bookings table by this form.
- Live slot availability and payment processing are not connected.
- Therapist approval must be managed separately in Supabase; there is no admin approval panel.
- The original HTML references hefemi-hero.mp4. That video was not included with the uploaded source file, so add it beside index.html if you have it.

Security
- The HTML contains only the Supabase project URL and publishable key. Do not put a service_role or secret key in browser code.

Validation performed here
- Inline JavaScript syntax check passed.
- Basic HTML parsing passed.
- A live signup/login test has not been performed from your hosted domain.
