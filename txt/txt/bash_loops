[bash loops]

1. until
2. while
3. for

[until]

$ until <cmd1>; do <cmd2>; done

"execute cmd2 UNTIL cmd1 returns 0 exit status"

until cmd1 is proven correct, execute cmd2

[while]

$ while <cmd1>; do <cmd2>; done

    - "execute cmd2 as long as cmd1 returns 0 exit status"

    - while cmd1 exits with a 0, continue looping

[for]

$ for <name> [ [in [<words …>] ] ; ] do commands; done

    - "expand words & execute commands once for each item in the resultant list."
    - "name = current line of said list."

    - "if 'in words' is missing, for executes the commands once for each 
    parameter that is set (as if in $@ had been set)"

    - "return status = last cmd's exit status"

$ for (( expr1 ; expr2 ; expr3 )) ; do commands ; done


    6.5 shell arithmetic

    The shell allows arithmetic expressions to be evaluated, as one of the 
    shell expansions or by using the 

      (( compound command )) 
      "let" builtin
      -i option to the declare builtin.

    Evaluation is done in fixed-width integers with no check for overflow, 
    though division by 0 is trapped and flagged as an error. 
    The operators and their precedence, associativity, and values are the 
    same as in the C language. The following list of operators is grouped 
    into levels of equal-precedence operators. The levels are listed in 
    order of decreasing precedence.

    id++ id--            variable post-increment and post-decrement
    ++id --id            variable pre-increment and pre-decrement
    - +                  unary minus and plus
    ! ~                  logical and bitwise negation
    **                   exponentiation
    * / %                multiplication, division, remainder
    + -                  addition, subtraction
    << >>                left and right bitwise shifts
    <= >= < >            comparison
    == !=                equality and inequality
    &                    bitwise AND
    ^                    bitwise exclusive OR
    |                    bitwise OR
    &&                   logical AND
    ||                   logical OR
    expr ? expr : expr   conditional operator
    = *= 
    /= %= 
    += -= 
    <<= >>=              assignment
    &= ^= 
    |=     
    expr1 , expr2        comma 
