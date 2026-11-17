#!/usr/bin/env bash

# Function to check if a number is even
is_even() {
    local number=$1

    if (( number % 2 == 0 )); then
        return 0
    else
        return 1
    fi
}

# Check if any arguments were provided
if [ "$#" -eq 0 ]; then
    echo "Usage: $0 number1 [number2 ...]"
    exit 1
fi

sum=0
even_count=0

# Loop through all arguments
for number in "$@"; do
    sum=$((sum + number))

    if is_even "$number"; then
        even_count=$((even_count + 1))
    fi
done

echo "Number of arguments: $#"
echo "Sum: $sum"
echo "Even numbers: $even_count"
