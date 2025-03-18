---
title: 📂 array
cascade:
  type: docs
url: /docs/libraries/array
---

## array::appendIfNotPresent

Add a value to an array if it is not already present.

- $1: **array name** _as string_:
      The variable name of the array.
- $2: **value variable name** _as any_:
      The variable name containing the value to add.

Returns:

- $?:
  - 0 if the value was added
  - 1 if it was already present

```bash
declare myArray=( "a" "b" )
declare myValue="b"
array::appendIfNotPresent myArray myValue
printf '%s\n' "${myArray[@]}"
```

## array::checkIfPresent

Check if a value is in an array.
It uses pure bash.

- $1: **array name** _as string_:
      The variable name of the array.
- $2: **value variable name** _as any_:
      The variable name containing the value to check.

Returns:

- $?: 0 if the value is in the array, 1 otherwise.

```bash
declare myArray=( "a" "b" )
declare myValue="b"
if array::checkIfPresent myArray myValue; then "b is in the array"; fi
```

## array::fuzzyFilterSort

Allows to fuzzy sort an array against a given searched string.
Returns an array containing only the lines matching the searched string.
The array is sorted by (in order):

- the index of the first matched character in the line
- the distance between the first and last matched characters in the line
- the original order in the list

Also returns an array containing the indexes of the matched items in the original array.

- $1: **array name** _as string_:
      The array name to fuzzy filter and sort.
- $2: **search string** _as string_:
      The variable name containing the search string to match.

Returns:

- ${RETURNED_ARRAY[@]}: An array containing the items sorted and filtered
- ${RETURNED_ARRAY2[@]}: An array containing the indexes of the matched items in the original array

```bash
array::fuzzyFilterSort MY_ARRAY SEARCH_STRING
echo "${RETURNED_ARRAY[*]}"
```

> - All characters in the searched string must be found in the same order in the matched line.
> - Use `shopt -s nocasematch` to make this function is case insensitive.
> - This function is not appropriate for large arrays (>10k elements), see `array::fuzzyFilterSortFileWithGrepAndGawk` for large arrays.

## array::makeArraysSameSize

This function makes sure that all the arrays have the same size.
It will add empty strings to the arrays that are too short.

- $@: **array names** _as string_:
      The variable names of each array to transform.

```bash
array::makeArraysSameSize "array1" "array2" "array3"
```

## array::sort

Sorts an array using the > bash operator (lexicographic order).

- $1: **array name** _as string_:
      The variable name of the array to sort  (it will be sorted in place).

```bash
declare myArray=(z f b h a j)
array::sort myArray
echo "${myArray[*]}"
```

> - This function uses a quicksort algorithm (hoarse partition).
> - The sorting is not stable (the order of equal elements is not preserved).
> - It is not appropriate for large array, use the `sort` binary for such cases.

## array::sortWithCriteria

Sorts an array using multiple criteria.
Excepts multiple arrays. The first array is the one to sort.
The other arrays are used as criteria. Criteria are used in the order they are given.
Each criteria array must have the same size as the array to sort.
Each criteria array must containing integers representing the order of the elements.
We first sort using the first criteria (from smallest to biggest), then the second, etc.

- $1: **array name** _as string_:
      The name of the array to sort (it will be sorted in place).
- $@: **criteria array names** _as string_:
      The names of the arrays to use as criteria.
      Each array must have the same size as the array to sort and contain only numbers.

Returns:

- ${RETURNED_ARRAY[@]}: An array that contains the corresponding indexes of the sorted array in the original array

```bash
declare myArray=( "a" "b" "c" )
declare criteria1=( 3 2 2 )
declare criteria2=( 1 3 2 )
array::sortWithCriteria myArray criteria1 criteria2
echo "${myArray[@]}"
# c b a
echo "${RETURNED_ARRAY[@]}"
# 3 2 1
```

> - This function uses a quicksort algorithm (hoarse partition).
> - The sorting is not stable (the order of equal elements is not preserved).
> - It is not appropriate for large array, use the `sort` binary for such cases.

> Documentation generated for the version 0.28.3846 (2025-03-18).
