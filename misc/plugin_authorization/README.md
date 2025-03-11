# APISIX Authorization Plugins

This example shows how to setup and use most common authorization plugins.

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

### Consumer Restriction

No JWT:

```bash
JWT=""
curl localhost:9080/jwt_auth/jeff/anything -H "Authorization: Bearer ${JWT}"
```

Wrong consumer (**joe credential** for reserved **jeff route**):

```bash
JWT="eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJrZXkiOiJqb2Vfa2V5Iiwic3ViIjoiMTIzNDU2Nzg5MCIsIm5hbWUiOiJKb2huIERvZSIsImlhdCI6MTUxNjIzOTAyMiwiZXhwIjo5OTUxNjIzOTAyMn0.K-QwAwaS-Y3D9e_S9LPnU_35jWTnOBqfnIXf260Z-Aw"
curl localhost:9080/jwt_auth/jeff/anything -H "Authorization: Bearer ${JWT}"
```

Correct consumer (**joe credential** for reserved **joe route**)

```bash
JWT="eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJrZXkiOiJqb2Vfa2V5Iiwic3ViIjoiMTIzNDU2Nzg5MCIsIm5hbWUiOiJKb2huIERvZSIsImlhdCI6MTUxNjIzOTAyMiwiZXhwIjo5OTUxNjIzOTAyMn0.K-QwAwaS-Y3D9e_S9LPnU_35jWTnOBqfnIXf260Z-Aw"
curl localhost:9080/jwt_auth/joe/anything -H "Authorization: Bearer ${JWT}"
```

Wrong consumer (**jeff credential** for reserved **joe route**):

```bash
JWT="eyJhbGciOiJSUzI1NiIsInR5cCI6IkpXVCJ9.eyJrZXkiOiJqZWZmX2tleSIsInN1YiI6IjEyMzQ1Njc4OTAiLCJuYW1lIjoiSm9obiBEb2UiLCJpYXQiOjE1MTYyMzkwMjIsImV4cCI6OTk1MTYyMzkwMjJ9.IbBAyzC03XFVhs_jZHgbbgYbFjpLPVG9qiIbWpJN0QR-xC-diJliumYaCoKQlQGxSQe4kqbQu2EsO1uNK2K4O0dNF3_jPxzAVZqkCmkMpTMa_ONC6pMj4mBRE7xL1gjYTSYo_qqWxmi06Y6SA04njUTTddFshWqJNdu9QBV-6-KX4KOLf2nhhAcRe8tr4-nRjZ6InjHXfpJUwpSDc-DXob9PQx-Kp5yLYEkUoF5s5kshuWLvOZwil4dEkpNYbXilYa_7w8GY32DCXLQifD53qtdRGdxU8v7UALmueC6CbMAwrcu7soGSCympbp8gJ-hoUyAf425_F94Ugm2M7bkf4w"
curl localhost:9080/jwt_auth/joe/anything -H "Authorization: Bearer ${JWT}"
```

Correct consumer (**jeff credential** for reserved **jeff route**)

```bash
JWT="eyJhbGciOiJSUzI1NiIsInR5cCI6IkpXVCJ9.eyJrZXkiOiJqZWZmX2tleSIsInN1YiI6IjEyMzQ1Njc4OTAiLCJuYW1lIjoiSm9obiBEb2UiLCJpYXQiOjE1MTYyMzkwMjIsImV4cCI6OTk1MTYyMzkwMjJ9.IbBAyzC03XFVhs_jZHgbbgYbFjpLPVG9qiIbWpJN0QR-xC-diJliumYaCoKQlQGxSQe4kqbQu2EsO1uNK2K4O0dNF3_jPxzAVZqkCmkMpTMa_ONC6pMj4mBRE7xL1gjYTSYo_qqWxmi06Y6SA04njUTTddFshWqJNdu9QBV-6-KX4KOLf2nhhAcRe8tr4-nRjZ6InjHXfpJUwpSDc-DXob9PQx-Kp5yLYEkUoF5s5kshuWLvOZwil4dEkpNYbXilYa_7w8GY32DCXLQifD53qtdRGdxU8v7UALmueC6CbMAwrcu7soGSCympbp8gJ-hoUyAf425_F94Ugm2M7bkf4w"
curl localhost:9080/jwt_auth/jeff/anything -H "Authorization: Bearer ${JWT}"
```

