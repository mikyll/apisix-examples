# APISIX Authentication Plugins

This example shows how to setup and use most common authentication plugins.

> [!NOTE]
> Authentication plugins do **not** implement **authorization**. If a credential (e.g. username+password, API key, JWT) is valid (i.e. a Consumer for that method exists), the authentication check passes. In [JWT example](#jwt-authentication), there are 2 different consumer that can access the same route.

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

### Basic Authentication

No username/password:

```bash
curl "localhost:9080/basic_auth/anything"
```

Wrong username or password:

```bash
curl "localhost:9080/basic_auth/anything" -u "username:password"
```

Correct username and password:

```bash
curl "localhost:9080/basic_auth/anything" -u "sasha_username:sasha_password"
```

### Key Authentication

No API key:

```bash
API_KEY=""
curl "localhost:9080/key_auth/anything" -H "X-My-Api-Key: ${API_KEY}"
```

Correct API key:

```bash
API_KEY="mike_key"
curl "localhost:9080/key_auth/anything" -H "X-My-Api-Key: ${API_KEY}"
```

### JWT Authentication

No JWT:

```bash
JWT=""
curl localhost:9080/jwt_auth/anything -H "Authorization: Bearer ${JWT}"
```

Correct JWT (joe consumer):

```bash
JWT="eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJrZXkiOiJqb2Vfa2V5Iiwic3ViIjoiMTIzNDU2Nzg5MCIsIm5hbWUiOiJKb2huIERvZSIsImlhdCI6MTUxNjIzOTAyMiwiZXhwIjo5OTUxNjIzOTAyMn0.K-QwAwaS-Y3D9e_S9LPnU_35jWTnOBqfnIXf260Z-Aw"
curl localhost:9080/jwt_auth/anything -H "Authorization: Bearer ${JWT}"
```

Correct JWT (jeff consumer):

```bash
JWT="eyJhbGciOiJSUzI1NiIsInR5cCI6IkpXVCJ9.eyJrZXkiOiJqZWZmX2tleSIsInN1YiI6IjEyMzQ1Njc4OTAiLCJuYW1lIjoiSm9obiBEb2UiLCJpYXQiOjE1MTYyMzkwMjIsImV4cCI6OTk1MTYyMzkwMjJ9.IbBAyzC03XFVhs_jZHgbbgYbFjpLPVG9qiIbWpJN0QR-xC-diJliumYaCoKQlQGxSQe4kqbQu2EsO1uNK2K4O0dNF3_jPxzAVZqkCmkMpTMa_ONC6pMj4mBRE7xL1gjYTSYo_qqWxmi06Y6SA04njUTTddFshWqJNdu9QBV-6-KX4KOLf2nhhAcRe8tr4-nRjZ6InjHXfpJUwpSDc-DXob9PQx-Kp5yLYEkUoF5s5kshuWLvOZwil4dEkpNYbXilYa_7w8GY32DCXLQifD53qtdRGdxU8v7UALmueC6CbMAwrcu7soGSCympbp8gJ-hoUyAf425_F94Ugm2M7bkf4w"
curl localhost:9080/jwt_auth/anything -H "Authorization: Bearer ${JWT}"
```