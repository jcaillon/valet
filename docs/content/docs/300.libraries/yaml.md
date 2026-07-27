---
title: yaml
cascade:
  type: docs
url: /docs/libraries/yaml
---

## yaml::parseFile

Parses a YAML file and outputs:

- a bash associative array containing each value of the YAML accessible in flattened nested dot notation,
- a second associative array with the metadata of each node (tags of each non string values and length of arrays).

For example, if the YAML file contains:

```yaml
array:
  - true
  - 1
nested:
  key: value
```

The resulting associative arrays will have the following content:

```sh
REPLY_MAP['array[0]']="true"
REPLY_MAP['array[1]']="1"
REPLY_MAP['nested.key']="value"

REPLY_MAP2['@.length']="0"
REPLY_MAP2['array.length']=2
REPLY_MAP2["array[0]"]='!!bool'
REPLY_MAP2["array[1]"]='!!int'
```

- The values are always stored as a string in REPLY_MAP.
- Use the corresponding tag (if any) in REPLY_MAP2 to convert the value to the correct type.
- Use [[ -v REPLY_MAP2[${key}] ]] to check if a key has a tag or not (if the value is a string, there will be no tag).
- The length of each array is stored in REPLY_MAP2["${key}.length"] to allow iterating over the array items.
- The number of documents in the YAML file is stored in the associative array with the key `@.length`.
- Each key of the n > 1 document (and optionally for the first document) will be prefixed with `@[n - 1].` to indicate the document number.
- If a key contains a '.' or '[', it will be quoted in the resulting associative array.
- This parser supports most of the YAML 1.2 specification and also implements merge keys from YAML 1.1.

> /!\ This does not support the following uncommon YAML 1.2 features:
> - explicit keys (e.g. `? {myobject: key}`)
> - extraction of tag definitions (e.g. %TAG !e! tag:example.com,2000:app/)

Inputs:

- `$1`: **file path** _as string_:

  The path to the YAML file to parse.

- `${noFail}` _as bool_:

  (optional) A boolean to indicate wether or not the function should call core::fail (exit)
  in case the parsing fails. By default, if the parsing fails, the script will exit.

  (defaults to false)

- `${prefixFirstDoc}` _as bool_:

  (optional) A boolean to indicate wether or not to prefix the keys of the first document
  with "@[0]".

  (defaults to false)

- `${onKeyValueFunction}` _as string_:

  (optional) The name of a callback function to be called for each key/value parsed.
  The function will be called with the following arguments:

  - $1: the full key of the value (e.g. `@[0].nested.key`)

  The value of the corresponding key can be read using REPLY_MAP["${1}"] and
  the tag of the value can be read using REPLY_MAP2["${1}"].


  (defaults to :)

Returns:

- `${REPLY_MAP}`: an associative array containing each value of the YAML accessible in flattened nested dot notation.
- `${REPLY_MAP2}`: an associative array containing the metadata of each node (tags of each non string values and length of arrays).
- `${REPLY_CODE}`: (requires noFail=true)
    - 0 if the file was parsed successfully,
    - 1 if the file is not a valid YAML file.
- `${REPLY}`: (requires noFail=true) the errors encountered during the parsing if any.

Example usage:

```bash
yaml::parseFile "file.yaml" noFail=true
declare -p REPLY_MAP
```

## yaml::parseString

Parses a YAML string.
See @yaml::parseFile for more details.

Inputs:

- `$1`: **variable name** _as string_:

  The name of the variable containing the YAML string to parse.

- `${noFail}` _as bool_:

  (optional) A boolean to indicate wether or not the function should call core::fail (exit)
  in case the parsing fails. By default, if the parsing fails, the script will exit.

  (defaults to false)

- `${prefixFirstDoc}` _as bool_:

  (optional) A boolean to indicate wether or not to prefix the keys of the first document
  with "@[0]".

  (defaults to false)

- `${onKeyValueFunction}` _as string_:

  (optional) The name of a callback function to be called for each key/value parsed.
  The function will be called with the following arguments:

  - $1: the full key of the value (e.g. `@[0].nested.key`)

  The value of the corresponding key can be read using REPLY_MAP["${1}"] and
  the tag of the value can be read using REPLY_MAP2["${1}"].

Returns:

- `${REPLY_MAP}`: an associative array containing each value of the YAML accessible in flattened nested dot notation.
- `${REPLY_MAP2}`: an associative array containing the metadata of each node (tags of each non string values and length of arrays).
- `${REPLY_CODE}`: (requires noFail=true)
    - 0 if the file was parsed successfully,
    - 1 if the file is not a valid YAML file.
- `${REPLY}`: (requires noFail=true) the errors encountered during the parsing if any.

Example usage:

```bash
yaml::parseString "variableName" noFail=true
declare -p REPLY_MAP
```

> [!IMPORTANT]
> Documentation generated for the version 0.43.381 (2026-07-27).
