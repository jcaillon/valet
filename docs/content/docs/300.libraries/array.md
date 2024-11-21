---
title: 📂 array
cascade:
  type: docs
url: /docs/libraries/array
---

## array::appendIfNotPresent

Add a value to an array if it is not already present.

- $1: **array name** _as string_:
      The global variable name of the array.
- $2: **value** _as any:
      The value to add.

Returns:

- $?:
  - 0 if the value was added
  - 1 if it was already present

```bash
declare -g myArray=( "a" "b" )
array::appendIfNotPresent myArray "c"
printf '%s\n' "${myArray[@]}"
```


## array::fuzzyFilter

Allows to fuzzy match an array against a given pattern.
Returns an array containing only the lines matching the pattern.

- $1: **pattern** _as string_:
      the pattern to match
- $2: **array name** _as string_:
      the initial array name

Returns:

- `RETURNED_ARRAY`: an array containing only the lines matching the pattern
- `RETURNED_ARRAY2`: an array of the same size that contains the start index of the match
- `RETURNED_ARRAY3`: an array of the same size that contains the distance of the match

```bash
array::fuzzyFilter "pattern" "myarray"
if (( ${#RETURNED_ARRAY[@]} == 1 )); then
  singleMatch="${RETURNED_ARRAY[0]}"
fi
```

> - All characters in the pattern must be found in the same order in the matched line.
> - The function is case insensitive.
> - This function does not sort the results, it only filters them.


## array::fuzzyFilterSort

Allows to fuzzy sort an array against a given pattern.
Returns an array containing only the lines matching the pattern.
The array is sorted by (in order):

- the index of the first matched character in the line
- the distance between the characters in the line

- $1: **pattern** _as string_:
      the pattern to match
- $2: **array name** _as string_:
      the initial array name
- $3: prefix matched char _as string_:
      (optional) string to add before each matched char
      (defaults to empty string)
- $4: suffix matched char _as string_:
      (optional) string to add after each matched char
      (defaults to empty string)
- $5: max line length _as int_:
      (optional) The maximum length to keep for the matched lines,
      does not count the strings added/before after each matched char
      (defaults to 9999999)

Returns:

- `RETURNED_ARRAY`: An array containing the items sorted and filtered
- `RETURNED_ARRAY2`: An array containing the indexes of the matched items in the original array

```bash
array::fuzzyFilterSort "pattern" "myarray" && local filteredArray="${RETURNED_ARRAY}"
array::fuzzyFilterSort "pattern" "myarray" ⌜ ⌝ && local filteredArray="${RETURNED_ARRAY}"
array::fuzzyFilterSort "pattern" "myarray" ⌜ ⌝ 10 && local filteredArray="${RETURNED_ARRAY}"
```

> - All characters in the pattern must be found in the same order in the matched line.
> - The function is case insensitive.
> - This function does not sort the results, it only filters them.


## array::isInArray

Check if a value is in an array.
It uses pure bash.

- $1: **array name** _as string_:
      The global variable name of the array.
- $2: **value** _as any:
      The value to check.

Returns:

- $?: 0 if the value is in the array, 1 otherwise.

```bash
declare -g myArray=( "a" "b" )
array::isInArray myArray "b" && printf '%s\n' "b is in the array"
```


## array::makeArraysSameSize

This function makes sure that all the arrays have the same size.
It will add empty strings to the arrays that are too short.

- $@: **array names** _as string_:
      The arrays (global variable names) to make the same size.

```bash
array::makeArraysSameSize "array1" "array2" "array3"
```


## array::sort

Sorts an array using the > bash operator (lexicographic order).

- $1: **array name** _as string_:
      The global variable name of array to sort.

```bash
declare -g myArray=( "z" "a" "b" )
array::sort myArray
printf '%s\n' "${myArray[@]}"
```

> TODO: Update this basic exchange sort implementation.


## array::sortWithCriteria

Sorts an array using mulitple criteria.
Excepts multiple arrays. The first array is the one to sort.
The other arrays are used as criteria. Criteria are used in the order they are given.
Each criteria array must have the same size as the array to sort.
Each criteria array must containing integers representing the order of the elements.
We first sort using the first criteria (from smallest to biggest), then the second, etc.

- $1: **array name** _as string_:
      the name of the array to sort (it is sorted in place)
- $@: **criteria array names** _as string_:
      the names of the arrays to use as criteria

Returns:

- `RETURNED_ARRAY`: An array that contains the corresponding indexes of the sorted array in the original array

```bash
declare -g myArray=( "a" "b" "c" )
declare -g criteria1=( 3 2 2 )
declare -g criteria2=( 1 3 2 )
array::sortWithCriteria myArray criteria1 criteria2
printf '%s\n' "${myArray[@]}"
# c b a
printf '%s\n' "${RETURNED_ARRAY[@]}"
# 3 2 1
```

> TODO: Update this basic exchange sort implementation.




> Documentation generated for the version 0.21.567 (2024-11-21).
