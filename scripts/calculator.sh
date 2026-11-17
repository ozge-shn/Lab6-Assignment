#!/usr/bin/env bash

# Addition function
add() {
    local result=$(( $1 + $2 ))
    echo "Result: $result"
}

# Subtraction function
subtract() {
    local result=$(( $1 - $2 ))
    echo "Result: $result"
}

# Multiplication function
multiply() {
    local result=$(( $1 * $2 ))
    echo "Result: $result"
}

# Division function
divide() {
    if [ "$2" -eq 0 ]; then
        echo "Error: Division by zero is not allowed."
    else
        local result=$(( $1 / $2 ))
        echo "Result: $result"
    fi
}

# Main menu loop
while true; do
    echo "1) Add"
    echo "2) Subtract"
    echo "3) Multiply"
    echo "4) Divide"
    echo "5) Exit"

    read -r -p "Enter your choice: " choice

    case "$choice" in
        1|2|3|4)
            read -r -p "Enter first integer: " num1
            read -r -p "Enter second integer: " num2

            if ! [[ "$num1" =~ ^-?[0-9]+$ && "$num2" =~ ^-?[0-9]+$ ]]; then
                echo "Error: Please enter valid integers."
                continue
            fi

            case "$choice" in
                1) add "$num1" "$num2" ;;
                2) subtract "$num1" "$num2" ;;
                3) multiply "$num1" "$num2" ;;
                4) divide "$num1" "$num2" ;;
            esac
            ;;
        5)
            echo "Goodbye!"
            break
            ;;
        *)
            echo "Invalid choice. Please select 1-5."
            ;;
    esac

    echo
done
