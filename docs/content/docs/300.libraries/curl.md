---
title: 📂 curl
cascade:
  type: docs
url: /docs/libraries/curl
---

## ⚡ curl::download

This function is a wrapper around curl to save a request result in a file.
It allows you to check the http status code and return 1 if it is not acceptable.
It invokes curl with the following options (do not repeat them): -sSL -w "%{response_code}" -o ${2}.

Inputs:

- `$1`: **url** _as string_:

  The url to download

- `$@`: **curl arguments** _as any_:

  options for curl

- `${output}` _as string_:

  (optional) the file in which to save the output of curl.
  Set to an empty string to create a temporary file instead.

  (defaults to "")

- `${failOnError}` _as bool_:

  (optional) true/false to indicate if the function should fail in case the execution fails

  (defaults to false)

- `${acceptableCodes}` _as string_:

  (optional) list of http status codes that are acceptable, comma separated

  (defaults to 200,201,202,204,301,304,308)

Returns:

- `${REPLY_CODE}`:
  - 0 if the http status code is acceptable
  - 1 otherwise
- `${REPLY}`: the path to the file where the content was saved
- `${REPLY2}`: the content of curl stderr
- `${REPLY3}`: the http status code

Example usage:

```bash
curl::download https://example.com --- output=/filePath
curl::download https://example2.com -H "header: value" --- failOnError=true acceptableCodes=200,201 output=/filePath
echo "The curl command ended with exit code ⌜${REPLY_CODE}⌝, the http return code was ⌜${REPLY2}⌝: ${REPLY}"
```

## ⚡ curl::request

This function is a wrapper around curl to save the content of a request in a variable.
It allows you to check the http status code and return 1 if it is not acceptable.
It invokes curl with the following options (do not repeat them): -sSL -w "%{response_code}" -o "tempfile".

Inputs:

- `$1`: **url** _as string_:

  The url to request

- `$@`: **curl arguments** _as any_:

  options for curl

- `${failOnError}` _as bool_:

  (optional) true/false to indicate if the function should fail in case the execution fails

  (defaults to false)

- `${acceptableCodes}` _as string_:

  (optional) list of http status codes that are acceptable, comma separated

  (defaults to 200,201,202,204,301,304,308)

Returns:

- `${REPLY_CODE}`:
  - 0 if the http status code is acceptable
  - 1 otherwise
- `${REPLY}`: the content of the request
- `${REPLY2}`: the content of curl stderr
- `${REPLY3}`: the http status code

Example usage:

```bash
curl::request https://example.com
curl::request https://example.com -X POST -H 'Authorization: token' --- failOnError=true
echo "The curl command ended with exit code ⌜${REPLY_CODE}⌝, the http return code was ⌜${REPLY2}⌝: ${REPLY}"
```

> [!IMPORTANT]
> Documentation generated for the version 0.34.68 (2025-09-17).
