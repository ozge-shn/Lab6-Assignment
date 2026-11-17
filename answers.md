# Lab 6 — Answers

Name: Özge Şahin
Student ID:20231701050

> For each question, write **the command(s) you used** and **the output**.
> For A1, B1, and C1, submit the corresponding script in `scripts/` and paste its full contents here.

## Part A — The calculator

**A1.** `scripts/calculator.sh` (full script):

```bash
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

```

**A2.** Addition and division in one session (inputs and outputs), plus a one-sentence explanation of integer division:

```
$ ./scripts/calculator.sh
1) Add
2) Subtract
3) Multiply
4) Divide
5) Exit
Enter your choice: 1
Enter first integer: 12
Enter second integer: 8
Result: 20

1) Add
2) Subtract
3) Multiply
4) Divide
5) Exit
Enter your choice: 4
Enter first integer: 17
Enter second integer: 5
Result: 3

1) Add
2) Subtract
3) Multiply
4) Divide
5) Exit
Enter your choice: 5
Goodbye!


```

Explanation:The second result has no decimal part because Bash uses integer arithmetic which discards the fractional part during division.

**A3.** Division by zero, invalid choice, and exit (inputs and outputs; describe any fix if needed):

```
$ ./scripts/calculator.sh
1) Add
2) Subtract
3) Multiply
4) Divide
5) Exit
Enter your choice: 4
Enter first integer: 9
Enter second integer: 0
Error: Division by zero is not allowed.

1) Add
2) Subtract
3) Multiply
4) Divide
5) Exit
Enter your choice: 9
Invalid choice. Please select 1-5.

1) Add
2) Subtract
3) Multiply
4) Divide
5) Exit
Enter your choice: 5
Goodbye!


```

Notes/fix (if needed):No fixes were needed.

## Part B — Summarize command-line numbers

**B1.** `scripts/summarize.sh` (full script):

```bash
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

```

**B2.** Run with `4 7 2 9` (command and output):

```
$ ./scripts/summarize.sh 4 7 2 9
Number of arguments: 4
Sum: 22
Even numbers: 2


```

**B3.** Run with `-3 0 8` and with no arguments (commands and outputs; describe any fix if needed):

```
$ ./scripts/summarize.sh -3 0 8
Number of arguments: 3
Sum: 5
Even numbers: 2

$ ./scripts/summarize.sh
Usage: ./scripts/summarize.sh number1 [number2 ...]


```

Notes/fix (if needed):No fixes were needed.

## Part C — The file checker (Bonus +20)

**C1.** `scripts/filecheck.sh`

```bash
#!/usr/bin/env bash

# Function to check the entered path
check_path() {
    local path="$1"

    if [ -f "$path" ]; then
        local lines
        lines=$(wc -l < "$path")
        echo "File found: $path"
        echo "Number of lines: $lines"

    elif [ -d "$path" ]; then
        echo "$path is a directory, not a regular file."

    else
        echo "Path not found: $path"
    fi
}

# Keep asking for a path
while true; do
    read -r -p "Enter a file path (or quit): " path

    if [ "$path" = "quit" ]; then
        echo "Goodbye!"
        break
    fi

    check_path "$path"
    echo
done

```

```text
$ ./scripts/filecheck.sh
Enter a file path (or quit): quit
Goodbye!


```

**C2.** Create `sample.txt` with three lines, then check it (commands, interaction, and output):

```
$ printf 'alpha\nbeta\ngamma\n' > sample.txt
$ ./scripts/filecheck.sh
Enter a file path (or quit): sample.txt
File found: sample.txt
Number of lines: 3

Enter a file path (or quit): quit
Goodbye!


```

**C3.** Check the `scripts` directory, an empty `empty.txt`, and `quit` (commands and interaction; describe any fix if needed):

```
$ > empty.txt
$ ./scripts/filecheck.sh
Enter a file path (or quit): scripts
scripts is a directory, not a regular file.

Enter a file path (or quit): empty.txt
File found: empty.txt
Number of lines: 0

Enter a file path (or quit): quit
Goodbye!


```

Notes/fix (if needed):No fixes were needed.
