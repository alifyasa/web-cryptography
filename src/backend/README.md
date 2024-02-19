# README

This README would normally document whatever steps are necessary to get the
application up and running.

Things you may want to cover:

* Ruby version

* System dependencies

* Configuration

* Database creation

* Database initialization

* How to run the test suite

* Services (job queues, cache servers, search engines, etc.)

* Deployment instructions

* ...

## Contoh Request

```
curl -X POST 127.0.0.1:3000/encrypt -d '{ "cipher": "VIGNERE", "data": "ABC", "key":"VIGNERE" }' -s -H "Content-Type: application/json" | jq
```