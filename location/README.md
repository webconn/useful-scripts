location
========

Gets your location data (lat/lon) using your Internet connection and local GeoIP if it's possible.
You can store this data in /etc/location or somewhere else and use it for xflux, for example.

Usage
-----

```
get_location.sh output_file
```

Writes got location in format '%f %f' for latitude and longitude (two floats) got from your 
local GeoIP installation. If it's not possible to get location, file stays untouched.

Good way to use it is to setup it as NetworkManager hook or something like that (88location hook
for NetworkManager is already here)
