---
title: 📂 kurl
cascade:
  type: docs
url: /docs/libraries/kurl
---

##  kurl::toFile

This function is a wrapper around curl.
It allows you to check the http status code and return 1 if it is not acceptable.
It io::invokes curl with the following options (do not repeat them): -sSL -w "%{http_code}" -o ${2}.

- $1: true/false to indicate if the function should fail in case the execution fails
- $2: a list of http status codes that are acceptable, comma separated (default to 200,201,202,204,301,304,308)
- $3: the file in which to save the output of curl
- $4+: options for curl

Returns:

- $?: 0 if the http status code is acceptable, 1 otherwise.
- `RETURNED_VALUE`: the content of stderr
- `RETURNED_VALUE2`: the http status code

```bash
kurl::toFile "true" "200,201" "/filePath" "https://example.com" || core::fail "The curl command failed."
```


## kurl::toVar

This function is a wrapper around curl.
It allows you to check the http status code and return 1 if it is not acceptable.
It io::invokes curl with the following options (do not repeat them): -sSL -w "%{http_code}" -o "tempfile".

- $1: true/false to indicate if the function should fail in case the execution fails
- $2: a list of http status codes that are acceptable, comma separated (default to 200,201,202,204,301,304,308)
- $3+: options for curl

Returns:

- $?: 0 if the http status code is acceptable, 1 otherwise.
- `RETURNED_VALUE`: the content of the request
- `RETURNED_VALUE2`: the content of stderr
- `RETURNED_VALUE3`: the http status code

```bash
kurl::toVar false 200,201 https://example.com || core::fail "The curl command failed."
```




> Documentation generated for the version 0.17.112 (2024-06-06).
