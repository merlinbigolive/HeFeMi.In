HeFeMi website update
======================

ZIP contents are placed directly in the ZIP root.

- index.html: responsive website, supplied hero video, Delhi-only locality selector,
  gender and hotel booking fields, all nine agreed slots and pricing.
- hefemi-hero.mp4: supplied hero background video (autoplay, muted, loop, playsinline).
- supabase-bookings-starter.sql: starter database schema and anti-double-booking
  transaction requirements for the Supabase backend.

IMPORTANT
---------
The page currently opens a pre-filled WhatsApp booking request to +91 82877 61407.
It does NOT yet guarantee live slot locking or payment confirmation. To prevent
anyone from booking an already-booked slot, deploy a server-side booking endpoint
that atomically checks date/time overlaps with the 40-minute travel buffer, creates
a temporary payment hold, and confirms only after Razorpay server-side verification.
The SQL file documents the required database structure and transaction behavior.

Service area currently listed: selected Delhi localities only:
Vasant Vihar, Defence Colony, Greater Kailash I & II, Hauz Khas, Panchsheel Park,
Shanti Niketan, Jor Bagh, Chanakyapuri, Saket and Golf Links.
These are the proposed service localities and can be edited before launch.

SLOT AVAILABILITY UI
--------------------
The booking form now shows an availability panel with Available / Not Available
visual states. When AVAILABILITY_API_URL in index.html is set to the deployed
backend endpoint, it fetches bookedSlots for the selected date and disables
booked slots. Until the endpoint is connected, the page is a design preview:
it cannot know other customers' bookings and must not be used to accept live
confirmed bookings. The backend must atomically enforce slot conflicts and the
40-minute buffer when creating a booking.
