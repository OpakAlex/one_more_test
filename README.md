# Setup

```bash
bin/setup

curl -H 'Content-Type: application/json' -H 'X-User-Email: steven.spielberg@gmail.com' -H 'X-User-Token: $your_newly_token' http://localhost:3000/api/v1/trailers

curl -H 'Content-Type: application/json' -H 'X-User-Email: steven.spielberg@gmail.com' -H 'X-User-Token: $your_newly_token' http://localhost:3000/api/v1/trailers/3/download?token=$trailer_token
```
