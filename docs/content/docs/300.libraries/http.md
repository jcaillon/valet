---
title: http
cascade:
  type: docs
url: /docs/libraries/http
---

## http::request

This function exists to demonstrate how to make a simple HTTP request using pure bash.
It should not be used for anything serious as it is seriously limited.
BUG: It only handles pure text responses (can't download anything else than plain text, json and such).
**Seriously, use curl instead!**

Inputs:

- `$1`: **verb** _as string_:

  The HTTP verb to use (GET, POST, PUT, DELETE, etc.).

- `$2`: **url** _as string_:

  The URL to request. Can be http or https but it will only send a request to port 80 anyway.

- `${failOnError}` _as bool_:

  (optional) If true, the function will use core::fail if the HTTP status code is not acceptable.

  (defaults to false)

- `${acceptableCodes}` _as string_:

  (optional) The list of acceptable status codes, comma separated.

  (defaults to 200,201,202,204,301,304,308)

- `${output}` _as string_:

  (optional) The file in which to save the output of the request.

  (defaults to "" which means the body will be returned in the variable `REPLY`)

- `${followRedirection}` _as bool_:

  (optional) If true, the function will follow redirections.

  (defaults to false)

- `${timeout}` _as int_:

  (optional) The timeout in seconds for the response (can be a decimal number).

  (defaults to 5)

Returns:

- `${REPLY_CODE}`:
  - 0 if the http status code is acceptable
  - 1 otherwise
- `${REPLY}`: the body of the response or the path to the file where it was saved
- `${REPLY2}`: the headers of the response
- `${REPLY3}`: the http status code

Example usage:

```bash
VALET_CONFIG_ENABLE_INSECURE_WEB_REQUESTS=true
http::request GET http://example.com failOnError=true acceptableCodes=200,201 followRedirection=true
http::request GET https://api.ip2location.io/ output=test.json
http::request GET http://httpbin.org/get
echo "Returns HTTP code was ${REPLY3}, response:"$'\n'"${REPLY2}"$'\n'"${REPLY}"
```

> [!IMPORTANT]
> Documentation generated for the version 0.45.65 (2026-10-26).
