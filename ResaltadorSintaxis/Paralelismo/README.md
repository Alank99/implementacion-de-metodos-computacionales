# Integrative Activity 5.3:
## Parallel syntax highlighter 

### Alan Anthony Hernandez Perez | A01783347
### Mario Ignacio Frias Piña  |  A01782559

## Context
In this syntax highlighter analyzes the C language, which was identified with 8 distinguishable tokens:

First of it is inverted, in this are all the words that are reserved, example of it would be auto, double, int, struct, etc..

Function in this one is composed with the first character is composed of char, after that there can be elements of char and numerical, but at the end it must be with a parenthesis.

Ids are our variables that is composed as a function, but this can or not have parentheses to declare it as a list.

The library is identified by the greater-than and less-than signs, where what is inside can be any element.

The operations are the following characters: Arithmetic operators, relational operators, shift operators, logical operators, bitwise operators, conditional operators, assignment operators, and miscellaneous operators.

The string is composed of any element, but must always start and end with single or double quotes.

While the integers are composed by numbers with sign, exponential, decimal, etc.. 

Finally, there are the comments that must start with, after that you can do whatever you want.

While the other tokens found in the code are elements that can be semicolons, spaces or parentheses in the function, it was considered to leave it without a specific color but taking into account its token.

## Documentation
The code works through three main functions, the first function "concur_token_file" accepts the list of input and output files in duplicate. In this same one the tasks or threads are created for each one of the elements of the list, with the function of map and that in turn the elements are already destructured of the duples and are sent to the function of "token_file" and since each taks finishes its independent task and each taks or thread will wait for its result to finish, allowing that each file is executed in parallel and independent of the other files. This will also depend on the cores of the computer running the program.


While "token_file", processes the incoming file as a string, using the piping elixir function, each function will send the result of each line to the next line of code. Then the file is sent to a function to split the string into lines separated by new lines, whatever is obtained from the lines of the string is applied a map to each line with the function "get_token" which in turn calls its anonymous function.

This function will start with the dynamic programming algorithm by the fact of using recursion with tail, during the execution of the anonymous function each call will analyze each element of the string line, with a condition in which the argument of each condition will evaluate regular expressions that are expressed in the code.

If the token is found, it is stored with the html tags and saved in the list, furthermore the found element with its corresponding token is removed from the string line element so that it is not parsed again.

When the replacement of string lines with html elements is finished, each string line is reassembled into a single string, which in turn is written to a new file using the "File.write" function, which must be used in an html file to see how each line of code is highlighted using CSS.

We believe that the ethical implications of developing this type of technology are the security and privacy of those who use the syntax highlighter, in which it can function normally, which in turn the program is designed so that the programmer can design an anonymous function in this to run with the rest of the functions is executed in parallel, making it possible to be able to obtain sensitive information, violating the privacy and security of potential users.
. 

So we as programmers have the implication and responsibility to provide programs of this style that are safe and do not have malware, to avoid the sale of sensitive data.

In addition to this, we are aware of the possible limitations in terms of the hardware of each computer, because being implemented this type of parallelism and concurrency tools requires more requirements to be used, such as increased energy consumption and overheating of the computer to really use all its capabilities. This can lead to premature computer failure and increased electricity bills.

## Execution times
![Prueba_secuencial](./Pruebas%20secuencial.png)
***Sequential execution***

![Prueba_secuencial](./Pruebas%20secuencial.png)
***Parallel execution***

**Speedup**

For the realization of the speed up a modification is made to the parallel syntax highlighting so that it was sequential and to be able to accept a list, in the same way that with the parallelism but the difference is that in this one it must go finishing file by file, that is to say it is sequential, it is also worth mentioning that it has the same algorithmic complexity that will be mentioned later, that is its complexity.

The purpose of having a sequential version is to be able to see if the version that uses parallelism really improves the performance and optimization of the program.

As for the speedup, the average of 5 execution times was taken, with the same files and also that each file has the same number of elements and size, being copies of the same ones.

The average of the sequential version is 1.194988 seconds.

The average of the parallel version is 0.346007 seconds.

Therefore it would give us that the speedup is equal to 3.453 that for its indexes that it has would indicate us that the parallel version is we improve the performance of the program.

Here we can see the difference when using parallelism, which optimizes the performance of the program, since each element of the initial list will start executing independently and it does not depend on having to finish one file to start with another, as is the case with sequential.

## Algorithm complexity
As for the complexity of the algorithm, there we analyze the 4 functions mentioned, in the first of “concur_token_file” the complexity depends on the number of elements that possesses the list that is receiving from the function, we are using the map that will apply the second function to each element of the list.

Your second “token_file” function will depend on the number of lines to be read from the input file, in this case we would have our (m). Continuing with the case of the third function, it depends on the length of each line of the string that is analyzed with regular expressions, obtaining a (k) as complexity in this part of the function.

Finally would be the function "get_token", which depends on the number of expressions that are analyzed, in the worst case we will have to search in all possible cases, which would be a complexity of (j).

Putting these three together, we end up with the following complexity of the algorithm = O(n*(m*k+j)).

## how to use it

To use it is from the git bash terminal, go to the syntax highlighting folder, in this folder enter the following line of code to load the file.
``` 
iex syntax_highlightingPa.exs 
``` 
To run the function is as follows
``` 
iex> Highlighting.concur_token_file"(" "[" { "{"file_in.c "," file_out.html "}" } "]" ")" 
``` 
