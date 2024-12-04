---
title: 📂 curl
cascade:
  type: docs
url: /docs/libraries/curl
---

## curl::toFile

This function is a wrapper around curl.
It allows you to check the http status code and return 1 if it is not acceptable.
It io::invokes curl with the following options (do not repeat them): -sSL -w "%{response_code}" -o ${2}.

- $1: **fail** _as bool_:
      true/false to indicate if the function should fail in case the execution fails
- $2: **acceptable codes** _as string_:
      list of http status codes that are acceptable, comma separated
      (defaults to 200,201,202,204,301,304,308 if left empty)
- $3: **path** _as string_:
      the file in which to save the output of curl
- $@: **curl arguments** _as any_:
      options for curl

Returns:

- $?:
  - 0 if the http status code is acceptable
  - 1 otherwise
- `RETURNED_VALUE`: the content of stderr
- `RETURNED_VALUE2`: the http status code

```bash
curl::toFile "true" "200,201" "/filePath" "https://example.com" || core::fail "The curl command failed."
```


## curl::toVar

This function is a wrapper around curl.
It allows you to check the http status code and return 1 if it is not acceptable.
It io::invokes curl with the following options (do not repeat them): -sSL -w "%{response_code}" -o "tempfile".

- $1: **fail** _as bool_:
      true/false to indicate if the function should fail in case the execution fails
- $2: **acceptable codes** _as string_:
      list of http status codes that are acceptable, comma separated
      (defaults to 200,201,202,204,301,304,308 if left empty)
- $@: **curl arguments** _as any_:
      options for curl

Returns:

- $?:
  - 0 if the http status code is acceptable
  - 1 otherwise
- `RETURNED_VALUE`: the content of the request
- `RETURNED_VALUE2`: the content of stderr
- `RETURNED_VALUE3`: the http status code

```bash
curl::toVar false 200,201 https://example.com || core::fail "The curl command failed."
```




> Documentation generated for the version 0.27.285 (2024-12-05).
