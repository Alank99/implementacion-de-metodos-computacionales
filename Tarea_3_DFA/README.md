# Arithmetic expressions

The program performs the functions of an automaton as seen below, in this the structure of our finite deterministic automaton (DFA) is created, where we also declared the states of acceptance of the automaton and how it will process the states of any given string of an arithmetical expression, these will be our expressions to analyze. The program will take a character of the string and pass it to our transition function to see if it is a state of our automaton, in case of it not being a valid state, the function will return that it is an invalid state. Otherwise our transition function will accept it and send it to the next state, once it finds an acceptance state the function will return a tuple of the string and what token it represents, adding it a list of lists that is finally returned to the user.

Valid arithmetic expressions

```mermaid
graph TD;

%% Style definitions
classDef initial fill:#282
classDef accept stroke:#f44,stroke-width:4px

%% Node shape definitions
start((start))
sign((sign))
int((int))
dot((dot))
float((float))
e((e))
e_sign((e_sign))
exp((exp))
var((var))
op((op))
spa((spa))
o_spa((o_spa))
par_open((par_open))
par_close((par_close))
first((first))
comment((comment))
div((div))


%% Node types
class start initial
class int,float,exp,var,spa,par_close,comment accept

%% The graph
start-->|digit|int;
start-->|+,-|sign;
start-->|letter,_|var;
start-->|par_op|par_open;
start-->|/|first
start-->|space|start
first-->|/|comment

div-->|/|comment
div-->|par_open|par_open
div-->|digit|int
div-->|+,-|sign
div-->|letter|var
div-->|space|o_spa

comment-->|"\n"|start

sign-->|digit|int;

int-->|digit|int;
int-->|.|dot;
int-->|e,E|e;
int-->|+,-,*,/,=|op
int-->|space|spa
int-->|par close|par_close
int-->|/|div

dot-->|digit|float;

float-->|digit|float;
float-->|e,E|e;
float-->|+,-,*,/,=|op
float-->|space|spa
float-->|/|div
float-->|par close|par_close

e-->|+,-|e_sign;
e-->|digit|exp;

e_sign-->|digit|exp;

exp-->|digit|exp;
exp-->|+,-,*,/,=|op
exp-->|/|div
exp-->|par close|par_close
exp-->|space|spa

var-->|letter,digit,_|var;
var-->|+,-,*,/,=|op
var-->|/|div
var-->|par close|par_close
var-->|space|spa

op-->|par open|par_open
op-->|+,-|sign
op-->|digit|int
op-->|letter,_|var
op-->|space|o_spa

spa-->|+,-,*,/,=|op
spa-->|/|div
spa-->|space|spa
spa-->|par close|par_close

o_spa-->|+,-|sign
o_spa-->|digit|int
o_spa-->|letter,_|var
o_spa-->|par open|par_open
o_spa-->|par close|par_close
o_spa-->|space|o_spa

par_open-->|Letter,_|var
par_open-->|par close|par_close
par_open-->|+,-|sign
par_open-->|digit|int
par_open-->|space|o_spa

par_close-->|/|div
par_close-->|+,-,*,/,=|op
par_close-->|space|spa
```


