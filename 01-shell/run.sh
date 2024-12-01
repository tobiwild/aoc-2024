#!/usr/bin/env bash

input=$1

nums() { tr -s ' ' < "$input" | cut -d ' ' -f "$1" | sort -n; }
sum() { awk '{s+=$0}END{print s}'; }

paste -d- <(nums 1) <(nums 2) |
while read -r line; do
    diff=$((line))
    diff=${diff#-}
    echo "$diff"
done |
sum

declare -A nums2_map
while read -r count num; do
    nums2_map[$num]=$count
done < <(nums 2 | uniq -c)
nums 1 |
while read -r num1; do
    echo $((num1 * nums2_map[$num1]))
done |
sum
