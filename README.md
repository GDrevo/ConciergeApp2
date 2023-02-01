<h1>ConciergeApp<h1>

<h3>A concierge application for tenants who want to book services for their flat.</h3>

This application should allow Users to schedule Appointments with Cleaners, depending on the Cleaners' Availabilities.

For now, I have implemented:
- home / about / faq pages following the design guidelines I received
- Authentication for Users and Cleaners, allowing each to have its own UI
- the possibility for Cleaners to set their Availabilities through a weekly calendar
- a simple form allowing a User to choose between different services and choose when he wants it to be done (The end of the event is set automatically following the estimated time of the appointment, itself calculated from the options selected by the user.)
- The cleaners' availabilities update accordingly, creating new availability window for the cleaner when needed
- The Cleaners Schedule displays availabilities and appointments allowing the Cleaners to handle their schedule smoothly
- a feature made with StimulusJS allowing to fetch only the available cleaners at the chosen time, and display them to the user in a list he can choose from. When a cleaner is selected, a card also displays this cleaner's info
