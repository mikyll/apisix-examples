# APISIX Authorization Plugins

This example shows how to replace a builtin plugin. In this case we are replacing the `jwt-auth` plugin to not require `exp` or `nbf` claims.

There are different ways to replace a builtin plugins:

- replace the original one in `/usr/local/apisix/apisix/plugins/jwt-auth.lua`;
- create a new, custom one and reference it with `apisix.extra_lua_path` in `config.yaml`

In our example we show the second option.

## Setup

Start APISIX in Docker by running the following command:

```bash
docker compose up
```

## Test Routes

### Base Route

```bash
curl -i "localhost:9080/anything"
```

### JWT Route

We have a JWT that doesn't include `exp` nor `nbf` claims in its payload:

```json
{
  "key": "joe_key",
  "sub": "1234567890",
  "name": "Joe Doe",
  "iat": 1516239022
}
```

With the following request, we can notice how it passes the JWT check:

```bash
JWT="eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJrZXkiOiJqb2Vfa2V5Iiwic3ViIjoiMTIzNDU2Nzg5MCIsIm5hbWUiOiJKb2huIERvZSIsImlhdCI6MTUxNjIzOTAyMn0.p59b0uyLfwJiflCMiKBxLZwazPLdkgZGBKDEovAcxZs"
curl localhost:9080/jwt_auth/joe/anything -H "Authorization: Bearer ${JWT}"
```

