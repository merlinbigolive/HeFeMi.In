-- HeFeMi booking backend: Supabase PostgreSQL starter schema
-- Apply in Supabase SQL Editor after creating a project.
-- Booking creation must happen through a server-side function/RPC, not from a browser-only check.
create table if not exists public.hefemi_bookings (
  id uuid primary key default gen_random_uuid(),
  guest_name text not null,
  gender text not null check (gender in ('Male','Female')),
  phone text not null,
  hotel_name text not null,
  room_number text not null,
  locality text not null,
  booking_date date not null,
  start_minute integer not null,
  end_minute integer not null,
  amount_inr integer not null check (amount_inr in (500,900,1800)),
  status text not null default 'pending_payment'
    check (status in ('pending_payment','confirmed','cancelled','expired')),
  razorpay_order_id text,
  razorpay_payment_id text,
  created_at timestamptz not null default now(),
  check (start_minute >= 0 and end_minute > start_minute and end_minute <= 1440)
);
create index if not exists hefemi_bookings_date_status
  on public.hefemi_bookings (booking_date, status);

-- Required booking API behavior:
-- 1. Start a database transaction and acquire pg_advisory_xact_lock(hash of booking_date).
-- 2. Expire old unpaid holds.
-- 3. Reject any confirmed or unexpired pending booking whose time range overlaps
--    the requested range expanded by 40 minutes on both sides.
-- 4. Insert a short-lived pending_payment hold, then create Razorpay order server-side.
-- 5. Confirm only after verifying Razorpay signature/webhook server-side.
-- This transaction/lock is what prevents two customers from claiming the same slot
-- at the same time. Do not rely on localStorage or frontend-only checks.
