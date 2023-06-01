# Integrative Activity 3.4:
## Syntax Highlighter 

### Alan Anthony Hernandez Perez | A01783347
### Mario Ignacio Frias Piña  |  A01782559

## Context
In this syntax highlighter analyzes the C language, which was identified with 8 distinguishable tokens:

First of it is inverted, in this are all the words that are reserved, example of it would be auto, double, int, struct, etc..

Function in this one is composed with the first character is composed of char, after that there can be elements of char and numerical, but at the end it must be with a parenthesis.

Ids are our variables that is composed as a function, but this can or not have parentheses to declare it as a list.

The string is composed of any element, but must always start and end with single or double quotes.

While the integers are composed by numbers with sign, exponential, decimal, etc.. 

Finally, there are the comments that must start with, after that you can do whatever you want.

While the other tokens found in the code are elements that can be semicolons, spaces or parentheses in the function, it was considered to leave it without a specific color but taking into account its token.

## Documentation
The code works through three main functions, the first function of "token_file", processes the incoming file as a string, with the help of the piping elixir  function, each function will send the result of each line to the next line of code. Then the file is sent to a function in order to separate the string into lines separated by new lines, whatever is obtained from the string lines will be applied a map to each line with the "get_token" function which in turn calls its anonymous function.

This function will start with the dynamic programming algorithm by the fact that it uses recursion with a tail, during the execution of the private function each call will analiyze each element of the line of string, with a conditional in which the argument of each condition will evaluate regular expressions that are expressed in the code.

If the token is found, it is stored with the html tags and saved in the list, in addition, the element found with its corresponding token is removed from the element of the string line so that it is not parsed again.

When the replacement of string lines by html elements is finished, each string line is reassembled into a single string, which in turn is written to a new file using the "File.write" function, which must be used in a html file to see how each line of code is highlighted using CSS.

As for the complexity of the algorithm, there we analyze the three functions mentioned, in the first the complexity depends on the number of lines to read, in this case we would have our first (n). Continuing to the case of the second function, it depends on the length of each line of the string that is analyzed with regular expressions obtaining an (m) as complexity in this part of the function.

Finally it would be the function "get_token", which will depend on the quantity of expressions being analyzed, in the worst case we will need to search through all possible cases, which would be a complexity of (k).

At the end when putting together these three we will obtain the following complexity of the algorithm = O(n*m+k).

We consider that the ethical implications of developing this type of technology are the security and privacy of those who use syntax highlighter, in which it can function normally, but it can also run in parallel which could make it possible to steal information from the user. As such we as programmers have the implication and responsibility to provide programs of this style that are safe and do not have malware, to prevent the sale of sensitive data.


## how to use it

To use it is from the git bash terminal, go to the syntax highlighting folder, in this folder enter the following line of code to load the file.
``` 
iex syntax_highlighting.exs 
``` 
To run the function is as follows
``` 
iex> Highlighting.tokenfile('<name in_file>.c','<name out_file>.html') 
``` 

