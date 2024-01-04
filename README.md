# Atlas-C

## Developers
Berkay Gündüz

Gökalp Gökdoğan

## Introduction
Atlas-C is a programming language inspired by C, JavaScript, and Python. To build, just run the make command. You can test by running ./atlas-c, cat tests/test# | ./parser, or cat tests/test_error# | ./parser where # will be replaced by the number of tests (i.e., 1, 2, …). cat tests/test# | ./parser tests valid programs where cat tests/test_error# | ./parser tests invalid programs with syntax errors. tests is the folder containing test programs. Since the first version, we have improved our design. We have added operator precedence, support for writing nested else if statements by using elif keyword, n-dimensional arrays, writing integers with + or -, and support for easy array initialization using braces. As we were not clear last time, it should be clarified that all comments written inside /* */ are directly ignored by lexical analysis, no matter where it is placed in the code. Hence, we have a comment definition. Also, we have added new precedence rules in our YACC file. Precedence and associativity rules help the parser resolve ambiguities when parsing expressions. We have defined AND, OR, EQUALITY, and INEQUALITY operators as left-associative.

## BNF
```
<program> ::= <stmts>
            | 

<stmts> ::= <stmt> ;
          | <stmt> ; <stmts>

<stmt> ::= const <id> <asgn>
         | <var_decl>
         | <var_decl> <asgn>
         | <id> <asgn>
         | <if_stmt>
         | while ( <cond> ) { <stmts> }
         | out ( <out_param> )
         | var <arr> = <init_arr>
         | var <arr>
         | <arr> <asgn>
         | return <expr>
         | <func_def>
         | <func_call>

<var_decl> ::= var <id>

<asgn> ::= = <expr>

<if_stmt> ::= if ( <cond> ) { <stmts> } <else_part>

<else_part> ::= else{ <stmts> }
              | elif( <cond> ) { <stmts> } <else_part>
              | 

<cond> ::= <or_expr>

<or_expr> ::= <and_expr>
            | <or_expr> or <and_expr>

<and_expr> ::= <comp_expr>
             | <and_expr> and <comp_expr>

<comp_expr> ::= <expr>
             | <expr> <comp_op> <expr>
             | ( <expr> <comp_op> <expr> )

<expr> ::= <term>
         | <term> <op> <expr>

<term> ::= <id>
         | <int>
         | <in_function>
         | <func_call>
         | <arr>
         | ( <expr> )

<in_function> ::= <in> ( )

<arr> ::= <id> <arr_dims>

<arr_dims> ::= [ <expr> ]
             | [ <expr> ] <arr_dims>

<out_param> ::= <expr>
              | <str>
              | <expr> , <out_param>
              | <str> , <out_param>

<init_arr> ::= [ <arr_val> ]

<arr_val> ::= <expr>
            | <init_arr>
            | <expr> , <arr_val>
            | <init_arr> , <arr_val>

<func_def> ::= <id> ( <param_def> ) => { <stmts> }

<param_def> ::= 
              | <id>
              | <id> , <param_def>

<func_call> ::= <id> ( <params> )

<params> ::= 
           | <expr>
           | <expr> , <params>

<op> ::= +
       | -
       | *
       | /
       | mod
       | ^

<comp_op> ::= ==
            | !=
            | <
            | <=
            | >
            | >=

<id> ::= <letter> 
       | <letter> <id_chars>

<id_chars> ::= <id_char> 
             | <id_char> <id_chars>

<id_char> ::= <letter> 
            | <digit> 
            | _

<str> ::= "" 
        | " <char_list> "

<char_list> ::= <letter> 
              | <digit> 
              | <special> 
              | <letter> <char_list>
              | <digit> <char_list> 
              | <special> <char_list>

<int> ::= <number> | + <number> | - <number>

<number> ::= <digit> | <digit> <number>

<digit> ::= 0 | 1 | 2 | 3 | 4 | 5 | 6 | 7 | 8 | 9
 
<letter> ::= a | b | c | ... | z | A | B | C | ... | Z
```

## Language Structure:
### Nonterminals:
`<program>`: Represents the entire program and consists of a sequence of statements (`<stmts>`).

`<stmts>`: Defines a series of statements, allowing multiple statements to be separated by semicolons `;`.

`<stmt>`: Defines individual statements encompassing various structures such as variable declarations, assignments, control flow (if, while), I/O operations, function definitions, and function calls.

`<if_stmt>`: Captures the conditional branching (if, else if, else) structure.

`<cond>`: Represents conditional expressions used in if and while statements.

`<expr>`: Represents expressions involving arithmetic, logical, and functional operations.

`<arr>`: Defines arrays or array-like structures.

`<func_def>`: Represents the definition of functions within the program.

`<func_call>`: Captures the invocation of functions.

`<param_def>`: Specifies the parameters for functions in their definitions.

### Token Usage in Grammar:
*Identifiers*: (`[a-zA-Z][a-zA-Z0-9_]*`): Used for naming variables, functions, and parameters. It must start with a character and can continue with a char, a digit, or an underscore char.

*Constants*: (`[+-]?[0-9]+`): Represents integer values. It can have a sign (+/-) before.

*Strings*: (`\"[^\"]*\"`): Used for string literals. Anything between two quote marks `“...”` is considered as a string.

*Arithmetic Operators*: (`+ , - ,  * ,  ; ,  mod ,  ^`): Used in mathematical expressions.

*Comparison Operators*: (`== ,  != ,  < ,  <= ,  > ,  >=`): Used in conditional expressions.

*Logical Operators*: (`and ,  or`): Used for logical conjunction and disjunction.

*Parentheses and Brackets*: (`( ,  ) ,  { ,  } ,  [ ,  ]`): Used for grouping expressions and defining array dimensions.

*Assignment Operators*: (`= ,  =>`): Used for assignment and function definition assignments.

*Special Keywords*: (`const ,  var ,  if ,  while ,  int ,  out ,  return ,  func ,  elif ,  else`): Keywords defining constants, variables, control flow, I/O, and function-related operations.

*Delimiters*: (`; ,  ,`): Used as statement and parameter separators.

### Resolved Ambiguities and Rules:
*Precedence Rules*: The grammar specifies precedence for arithmetic, comparison, and logical operations. For instance, arithmetic ( + ,  - , etc.) has left associativity, comparison operators ( == ,  != , etc.) have left associativity, and logical operators ( and ,  or ) have left associativity.

*Control Flow Ambiguity*: Ambiguities in control flow (like multiple if-else structures) are resolved by enforcing a strict pattern: `if`  is followed by  `{ <stmts> }` , which is optionally followed by `elif` or `else` with their respective block of statements.

*Function Call and Definition Clarity*: The rules for `<func_def>` and `<func_call>` ensure clear distinction and correct usage between defining and invoking functions while considering parameters and their definitions.

## Atlas-C Language Manual
### A Simple Program
Atlas-C is a C-like programming language. It has a similar syntax with a few minor changes inspired by JavaScript and Python. It parses code like Python. So, a program starts directly from the beginning of a program file (or first given command), and continues with consecutive commands. Here is a simple traditional Hello World program:

Here you can see out() function used for outputting, strings are defined between quote marks, and each command ends with a semicolon.

### Variables and Constants
Atlas-C can only store integer-type variables. The var keyword is used to declare mutable integer variables. These variables can be assigned new values, and their contents can change throughout the execution of a program. var variables are versatile and are commonly employed when you need a variable to hold data that can change or when you want to reassign values multiple times during program execution.

Here, a variable named a is declared and assigned to 14. Later, 4 is assigned to a. A variable named b is also declared but assigned -3 later. Notice that we can use sign values for integer values.
On the other hand, the const keyword is used to declare constants. Constants are variables whose values remain fixed and cannot be changed once assigned. They are used when you want to define a value that should not be altered throughout the program's execution, often to represent fixed quantities, configuration parameters, or global significance values. Constants ensure that the value remains constant and can help prevent unintentional modifications in your code, contributing to code stability and readability.

### Comments
Anything enclosed within /* and */ is treated as a comment and is not executed by the program, regardless of where it is placed. It is a valuable tool for documenting code, providing context for readers and collaborators, and making notes about the code's functionality. Additionally, because it can span multiple lines, it is suitable for more extensive explanations or comments within the code.

### Operators
Operators play a fundamental role in code expression and evaluation. Various operators such as arithmetic operators (+, -, *, /, mod, ^), comparison operators (==, !=, <, <=, >, >=), and logical operators (and, or) are defined. Parentheses can be used for operator presence, which is the same as any other language. Variables can be assigned with operator results.

Operator
Name
Type
Function
+
Addition
Arithmetic
Adding two integers
-
Subtraction
Arithmetic
Subtracting two integers
*
Multiplication
Arithmetic
Multiplying two integers
/
Division
Arithmetic
Dividing two integers
mod
Modulus
Arithmetic
Modulus of an integer
^
Power
Arithmetic
Power of an integer
==
Equals
Comparison
True if two integers are equal
!=
Not Equals
Comparison
True if two integers are not equal
<
Less Than
Comparison
True if left-hand side integer is less than right-hand side integer
<=
Less Than or Equals
Comparison
True if left-hand side integer is less than or equal right-hand side integer
>
Greater Than
Comparison
True if left-hand side integer is greater than right-hand side integer
>=
Greater Than or Equals
Comparison
True if left-hand side integer is greater than or equal right-hand side integer
and
And
Logical
True if both sides are true, else false
or
Or
Logical
False if both sides are false, else true



Note that integers with sign values are not considered as operators! 12 -3 or 12 +3 are an invalid arithmetic operation, they should have explicit arithmetic operators like 12 - -3 or 12 + +3.

### I/O
We saw a simple output in the first chapter of this manual using out() function. This function can take unlimited parameters divided by commas as input and concatenate them to display. It can take only integer or string values, including in() function.
The function of in() is used for inputs. It can be assigned to a variable or can display a string directly if given in out() function.

### Control Flow (if/elif/else)
Control flow, involving constructs like if, elif (else if), and else is a fundamental aspect of programming that governs the execution path of a program based on conditional logic. The if statement allows a program to make decisions by evaluating a condition, and if the condition is true, a specific block of code is executed. When there are multiple conditions to be considered, elif provides additional branches of conditional logic to be explored. The else block offers a default path when none of the preceding conditions are met. This control flow structure allows developers to create dynamic and responsive software by directing the program's actions depending on specific conditions or scenarios. By using if elif else constructs, programmers can implement branching logic and make decisions crucial for a program's behavior, making it adaptable and capable of responding to various inputs and situations.

Note that if-elif-else should end with a semicolon! As said before, each command should end with a semicolon.

### Loop (while)
A loop, specifically the while loop, is a foundational programming construct that enables repeating a block of code as long as a specified condition remains true. When the while statement is encountered, the condition is evaluated, and if it's true, the code within the loop is executed. The loop then returns to reevaluate the condition, and as long as the condition remains true, the code continues to execute iteratively. while loops are valuable for automating repetitive tasks, performing operations on a sequence of data, or implementing processes that need to continue until a certain condition is met.

Note that while should end with a semicolon! As said before, each command should end with a semicolon.

### Arrays
Arrays are data structures to store a collection of integers under a single variable name. They provide a systematic way to organize and access multiple pieces of data. Arrays are characterized by their indexed structure, where each element is associated with a unique index or position within the array.

Note that array indexes should start with 0! 

### Functions
Functions, are self-contained blocks of code that perform specific tasks or operations. They are designed to encapsulate a series of instructions, making the code modular and reusable. Functions are defined with a name, a set of parameters separated with commas, and a body of code that specifies the actions to be executed. When a function is called in a program, it can take the provided input (arguments), process it, and have to return an output (result).

Note that the function should end with a semicolon! As said before, each command should end with a semicolon.
