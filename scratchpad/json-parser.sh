#!/usr/bin/env bash
# shellcheck disable=SC1090
source "$(valet --source)"
include yaml test

# log::setLevel debug silent=true

function parse() {
  # json
  local jsonLine jsonLineExtract jsonCumulatedLf="" isJsonQuoteOpen=0 jsonKeyName="" jsonPart jsonFullKey jsonLastString="" jsonLastQuoteChar="" jsonValueTag
  local -a jsonKeyPaths=() jsonArrayIndexes=() jsonOpenChars=()
  local -i jsonDepth=-1

  local IFS errorPrefix="ERROR " noFail=false
  local -i lineNumber=0
  while IFS=$'\n' read -rd $'\n' jsonLine || [[ -n ${jsonLine:-} ]]; do
    lineNumber+=1
    IFS='.'
    yaml_jsonHandleString
  done <"tests.d/lib-yaml/resources/ok-not-supported/test2.yaml"

  log::info "jsonDepth: ${jsonDepth}, jsonKeyPaths: ${jsonKeyPaths[*]@Q}, jsonArrayIndexes: ${jsonArrayIndexes[*]@Q}, jsonOpenChars: ${jsonOpenChars[*]@Q}"
}

function yaml_jsonSaveValue() {
  jsonFullKey="${jsonKeyPaths[*]:0:jsonDepth+1}"
  jsonFullKey="${yamlPrefix:-"@"}${jsonFullKey#.}"
  jsonFullKey="${jsonFullKey//'.['/'['}"

  log::warning "ADD VALUE : key: ${jsonFullKey@Q}, value: ${jsonLastString@Q}"
  REPLY_MAP["${jsonFullKey}"]="${jsonLastString}"
}

function yaml_addKey() {
  jsonArrayIndexes=("${jsonArrayIndexes[@]:0:jsonDepth}" 0)
  jsonKeyPaths=("${jsonKeyPaths[@]:0:jsonDepth}" "${jsonKeyName}")

  log::warning "ADD NEW KEY : ${jsonKeyName@Q} (${jsonKeyPaths[*]:0:jsonDepth+1})"
}

# receives jsonLine and should parse json from it
function yaml_jsonHandleString() {
  log::warning "line ${lineNumber} handle: ${jsonLine@Q}, jsonDepth: ${jsonDepth}, jsonKeyPaths: ${jsonKeyPaths[*]@Q}, jsonArrayIndexes: ${jsonArrayIndexes[*]@Q}, jsonOpenChars: ${jsonOpenChars[*]@Q}"

  # a quote has been opened on a previous line
  if ((isJsonQuoteOpen == 1)); then
    if [[ -z ${jsonLine//[\t ]/} ]]; then
      jsonCumulatedLf+=$'\n'
      return 0
    fi
    if [[ -n ${jsonCumulatedLf} ]]; then
      jsonLastString+="${jsonCumulatedLf}"
    elif [[ -n ${jsonLastString} ]]; then
      jsonLastString+=' '
    fi
    # prepend the last quote char so we can parse the line as an quoted string
    jsonLine="${jsonLastQuoteChar}${jsonLine}"
  fi

  while [[ -n ${jsonLine} ]]; do
    jsonPart="${jsonLine%%[\{\}\[\]\:\'\",#]*}"
    log::info "⌜${jsonLine:${#jsonPart}:1}⌝ -> json part: ${jsonPart@Q}"

    case "${jsonLine:${#jsonPart}}" in
    [\"\']*)
      if ((isJsonQuoteOpen == 0)); then
        if [[ -n ${jsonLastString} ]]; then
          yaml_addParsingError "unexpected token (expected one of ⌜:,{}[]⌝): ${jsonPart@Q}"
        elif [[ -n ${jsonPart//[\t ]/} ]]; then
          yaml_addParsingError "unexpected token (nothing should precede a quote): ${jsonPart@Q}"
        fi
      fi

      jsonLastQuoteChar="${jsonLine:${#jsonPart}:1}"

      # extract until next unescaped quote
      jsonLine="${jsonLine:${#jsonPart}+1}"
      if [[ ${jsonLastQuoteChar} == '"' ]]; then
        jsonLineExtract="${jsonLine//\\\"/$'\a\a'}"
      else
        jsonLineExtract="${jsonLine//\'\'/$'\a\a'}"
      fi
      jsonLineExtract="${jsonLineExtract%%"${jsonLastQuoteChar}"*}"
      jsonLine="${jsonLine:${#jsonLineExtract}}"
      jsonLastString+="${jsonLineExtract//$'\a\a'/"${jsonLastQuoteChar}"}"

      if [[ -n ${jsonLine} ]]; then
        isJsonQuoteOpen=0
        jsonLine="${jsonLine:1}"
      else
        isJsonQuoteOpen=1
        jsonCumulatedLf=""
      fi

      log::info "json last string: ${jsonLastString@Q}, jsonLine: ${jsonLine@Q}, isJsonQuoteOpen: ${isJsonQuoteOpen}"
      continue
      ;;
    ':'*)
      if ((jsonDepth < 0)); then
        yaml_addParsingError "unexpected token (expected one of ⌜{[⌝): ${jsonPart@Q}"
      fi

      # the last string is the key
      if [[ ${jsonPart} == *[^[:space:]]* ]]; then
        if [[ -n ${jsonLastString} ]]; then
          yaml_addParsingError "unexpected token (expected one of ⌜:,}]⌝): ${jsonPart@Q}"
        fi
        # trim json part
        jsonKeyName="${jsonPart%"${jsonPart##*[^[:space:]]}"}"
        jsonKeyName="${jsonKeyName#"${jsonKeyName%%[^[:space:]]*}"}"
      elif [[ -z ${jsonLastString} ]]; then
        jsonKeyName="null"
      else
        jsonKeyName="${jsonLastString}"
      fi

      yaml_addKey
      jsonLastString=""
      ;;
    ','*)
      if ((jsonDepth < 0)); then
        yaml_addParsingError "unexpected token (expected one of ⌜{[⌝): ${jsonPart@Q}"
      fi
      ;;&
    '}'*)
      log::warning "json object end"
      if [[ ${jsonOpenChars[jsonDepth]} != '{' ]]; then
        yaml_addParsingError "json object end found but last open char is not an object: ${jsonOpenChars[-1]@Q}"
      fi
      ;;&
    [\,\}\]]*)
      # take the last string
      if [[ ${jsonPart} == *[^[:space:]]* ]]; then
        if [[ -n ${jsonLastString} ]]; then
          yaml_addParsingError "unexpected token (expected one of ⌜:,}]⌝): ${jsonPart@Q}"
        fi
        # trim json part
        jsonLastString="${jsonPart%"${jsonPart##*[^[:space:]]}"}"
        jsonLastString="${jsonLastString#"${jsonLastString%%[^[:space:]]*}"}"
      fi
      ;;&
    [\,\}]*)
      # closing a key/value pair with either , or }
      if [[ -n ${jsonKeyName} ]]; then
        # we have a key, this is a value
        # FIXME: compute value tag
        if [[ -z ${jsonLastString} ]]; then
          jsonLastString="null"
          jsonValueTag="!!null"
        fi
        yaml_jsonSaveValue
      else
        # no key yet, this is the key
        jsonKeyName="${jsonLastString}"
        yaml_addKey
      fi

      jsonKeyName=""
      jsonLastString=""
      ;;&
    '}'*)
      jsonDepth=$((jsonDepth - 1))
      if ((jsonDepth <= -1)); then
        # final close
        jsonLine="${jsonLine:${#jsonPart}+1}"
        break
      fi
      ;;
    '{'*)
      log::warning "json object start"
      jsonOpenChars+=('{')
      jsonDepth+=1
      ;;
    '['*)
      log::warning "json array start"
      jsonOpenChars+=('[')
      jsonDepth+=1
      jsonKeyName="[0]"
      yaml_addKey
      ;;
    ']'*)
      log::warning "json array end"
      if [[ ${jsonOpenChars[jsonDepth]} != '[' ]]; then
        yaml_addParsingError "json array end found but last open char is not an array: ${jsonOpenChars[-1]@Q}"
      fi

      jsonDepth=$((jsonDepth - 1))
      if ((jsonDepth <= -1)); then
        # final close
        jsonLine="${jsonLine:${#jsonPart}+1}"
        break
      fi
      ;;
    '#'*)
      return 0
      ;;
    esac

    jsonLine="${jsonLine:${#jsonPart}+1}"
  done

  if [[ -n ${jsonLine} ]]; then
    yaml_addParsingError "json line not fully parsed: ${jsonLine@Q}"
  fi
}

parse

keys=("${!REPLY_MAP[@]}")
include array
array::sort keys

REPLY="REPLY_MAP=("$'\n'
for key in "${keys[@]}"; do
  REPLY+="[\"${key}\"]='${REPLY_MAP[${key}]//\'/\'\"\'\"\'}'"$'\n'
done
REPLY+=")"$'\n'

echo "${REPLY}"
