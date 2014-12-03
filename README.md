## Test API application

# Run application

`foreman start`

# Check scenario

`curl -i "http://localhost:3000/api/v1/bonus_codes/validate?product_id=1&bonus_code=123"
curl -i "http://localhost:3000/api/v1/bonus_codes/validate?product_id=1&bonus_code=345"
curl -i "http://localhost:3000/api/v1/bonus_codes/validate?product_id=2&bonus_code=567"
curl -i "http://localhost:3000/api/v1/bonus_codes/validate?product_id=2&bonus_code=789"
curl -i "http://localhost:3000/api/v1/bonus_codes/validate?product_id=3&bonus_code=123"
curl -i "http://localhost:3000/api/v1/bonus_codes/validate?product_id=3&bonus_code=345"
curl -i "http://localhost:3000/api/v1/bonus_codes/validate?product_id=3&bonus_code=567"`

# Routing

For compatibility with application request:

*/bonus_codes/validate*

For good namespace:

*/api/v1/bonus_codes/validate*

Both are work.

# Fake API

Two simple services (TV, RTG) run on 3301, 3302 ports.

TV service respond only for validation codes: 567 - valid, all other invalid
RTG service respond for code exists and validation: 123, 345 - exists, 123 - valid, 345 - not valid.

# Testing

Coverage 100%

