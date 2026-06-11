---
title: 📂 yaml
cascade:
  type: docs
url: /docs/libraries/yaml
---

## ⚡ yaml::parseFile

Parses a YAML file and outputs a bash associative array with the content of the YAML
accessible with dot notation.

For example, if the YAML file contains:

```yaml
key: test
array:
  - item1
  - item2
nested:
  key: value
```

The resulting associative array will have the following content:

```sh
REPLY_MAP['key']="test"
REPLY_MAP['array.length']=2
REPLY_MAP['array[0]']="item1"
REPLY_MAP['array[1]']="item2"
REPLY_MAP['nested.key']="value"
```

The length of each array is stored in the associative array with the key `(array).length` to allow
iterating over the array items.

Inputs:

- `$1`: **file path** _as string_:

  The path to the YAML file to parse.

- `${noFail}` _as bool_:

  (optional) A boolean to indicate wether or not the function should call core::fail (exit)
  in case the parsing fails. By default, if the parsing fails, the script will exit.

  (defaults to false)

Returns:

- `${REPLY_MAP}`: an associative array containing the content of the YAML file in dot notation.
- `${REPLY_CODE}`: (requires noFail=true)
    - 0 if the file was parsed successfully,
    - 1 if the file is not a valid YAML file.
- `${REPLY}`: (requires noFail=true) the errors encountered during the parsing if any.

Example usage:

```bash
yaml::parseFile "file.yaml" noFail=true
declare -p REPLY_MAP
```

> /!\ this does not support all YAML features yet, working in progress...
> TODO: complete the implementation to support more YAML features, and add more tests.

> [!IMPORTANT]
> Documentation generated for the version 0.42.13 (2026-06-11).
