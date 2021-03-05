## BASH

[Source](https://learnxinyminutes.com/docs/bash/)

## Parameter Expansion `$ { }`

``` bash
echo ${Variable} # => Some string
```

Parameter expansion gets a value from a variable. During expansion, you can
modify its value or parameter.

#### String Substitution

``` bash
echo ${Variable/Some/A} # => A string 
```

This will substitute the first occurrence of "Some" with "A"

#### Substrings

``` bash
Length=7
echo ${Variable:0:Length} # => Some st
```
This will return only the first 7 characters of the value

``` bash
echo ${Variable: -5} # => tring
```
This will return the last 5 characters (note the space before -5)

#### String length

``` bash
echo ${#Variable} # => 11
```

# Indirect expansion
``` bash
OtherVariable="Variable"
echo ${!OtherVariable} # => Some String
```
This will expand the value of OtherVariable

#### Default value for variable
``` bash
echo ${Foo:-"DefaultValueIfFooIsMissingOrEmpty"} # => DefaultValueIfFooIsMissingOrEmpty
```
This works for null (Foo=) and empty string (Foo="")

Zero (Foo=0) returns 0.

Note that it only returns default value and doesn't change variable value.

#### Arrays
Declare an array with 6 elements

``` bash
array0=(one two three four five six)
```

Print first element

``` bash
echo $array0 # => "one"
echo ${array0[0]} # => "one"
```

Print all elements

``` bash
echo ${array0[@]} # => "one two three four five six"
```

Print number of elements

``` bash
echo ${#array0[@]} # => "6"
```

Print number of characters in third element

``` bash
echo ${#array0[2]} # => "5"
```

Print 2 elements starting from forth

``` bash
echo ${array0[@]:3:2} # => "four five"
```

Print all elements. Each of them on new line.

``` bash
for i in "${array0[@]}"; do
    echo "$i"
done
```

## Brace Expansion { }

Used to generate arbitrary strings

``` bash
echo {1..10} # => 1 2 3 4 5 6 7 8 9 10
echo {a..z} # => a b c d e f g h i j k l m n o p q r s t u v w x y z
# This will output the range from the start value to the end value
```

## Built-in variables
There are some useful built-in variables, like

``` bash
echo "Last program's return value: $?"
echo "Script's PID: $$"
echo "Number of arguments passed to script: $#"
echo "All arguments passed to script: $@"
echo "Script's arguments separated into different variables: $1 $2..."
```

## Commands & Variables

Our current directory is available through the command `pwd`.

`pwd` stands for "print working directory".

We can also use the built-in variable `$PWD`.

Observe that the following are equivalent:

``` bash
echo "I'm in $(pwd)"    # execs `pwd` and interpolates output
echo "I'm in $PWD"      # interpolates the variable
```
## Reading Input

``` bash
echo "What's your name?"
read Name # Note that we didn't need to declare a new variable
echo Hello, $Name!
```

## Conditional

We have the usual if structure ( `man test` )


``` bash
if [ $Name != $USER ]
then
    echo "Your name isn't your username"
else
    echo "Your name is your username"
fi
```

NOTE: if `$Name` is empty, bash sees the above condition as:

``` bash
if [ != $USER ]     # invalid syntax

if [ "$Name" != $USER ]  # "safe" way to use potentially empty variables 

if [ "" != $USER ] ...  # which, when $Name is empty, is seen by bash as:
                        # works as expected
```

Conditional execution

``` bash
echo "Always executed" || echo "Only executed if first command fails"
# => Always executed
```

``` bash
echo "Always executed" && echo "Only executed if first command does NOT fail"
# => Always executed
# => Only executed if first command does NOT fail
```
To use `&&` and `||` with if statements, you need multiple pairs of square brackets:

``` bash
if [ "$Name" == "Steve" ] && [ "$Age" -eq 15 ]; then
    echo "This will run if $Name is Steve AND $Age is 15."
fi
if [ "$Name" == "Daniya" ] || [ "$Name" == "Zach" ]; then
    echo "This will run if $Name is Daniya OR Zach."
fi
```

### Conditional: REGEX
There is also the `=~` operator, which tests a string against a Regex pattern:

``` bash
Email=me@example.com
if [[ "$Email" =~ [a-z]+@[a-z]{2,}\.(com|net|org) ]]
then
    echo "Valid email!"
fi
```

 
