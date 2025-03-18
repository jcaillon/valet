---
title: 📂 curl
cascade:
  type: docs
url: /docs/libraries/curl
---

## curl::download

This function is a wrapper around curl to save a request result in a file.
It allows you to check the http status code and return 1 if it is not acceptable.
It invokes curl with the following options (do not repeat them): -sSL -w "%{response_code}" -o ${2}.

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
- ${RETURNED_VALUE}: the content of stderr
- ${RETURNED_VALUE2}: the http status code

```bash
curl::download true 200,201 "/filePath" "https://example.com"
curl::download false 200 "/filePath2" "https://example2.com" || core::fail "The curl command failed."
```

## curl::request

This function is a wrapper around curl to save the content of a request in a variable.
It allows you to check the http status code and return 1 if it is not acceptable.
It invokes curl with the following options (do not repeat them): -sSL -w "%{response_code}" -o "tempfile".

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
- ${RETURNED_VALUE}: the content of the request
- ${RETURNED_VALUE2}: the content of stderr
- ${RETURNED_VALUE3}: the http status code

```bash
curl::request true 200 https://example.com -X POST -H 'Authorization: token'
curl::request false 200,201 https://example.com || core::fail "The curl command failed."
```

> Documentation generated for the version 0.28.3846 (2025-03-18).
