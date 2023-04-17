# State diagrams

Diagrams for the Deterministic Finite Automatons (DFA) implemented in Racket

Created using [Mermaid](https://mermaid.js.org/syntax/flowchart.html)


## Arithmetic expressions

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

%% Node types
class start initial
class int,float,exp,var,spa,par_close accept

%% The graph
start-->|digit|int;
start-->|+,-|sign;
start-->|letter,_|var;
start-->|(|par_open;
sign-->|digit|int;
int-->|digit|int;
int-->|.|dot;
int-->|e,E|e;
int-->|+,-,*,/,=|op
int-->|space|spa
dot-->|digit|float;
float-->|digit|float;
float-->|e,E|e;
float-->|+,-,*,/,=|op
float-->|space|spa
e-->|+,-|e_sign;
e-->|digit|exp;
e_sign-->|digit|exp;
exp-->|digit|exp;
exp-->|+,-,*,/,=|op
exp-->|space|spa
var-->|letter,digit,_|var;
var-->|+,-,*,/,=|op
var-->|space|spa
op-->|+,-|sign
op-->|digit|int
op-->|letter,_|var
op-->|space|o_spa
spa-->|+,-,*,/,=|op
o_spa-->|+,-|sign
o_spa-->|digit|int
o_spa-->|letter,_|var

```

Drawn with the tool https://madebyevan.com/fsm/

![Arithmetic DFA](arithmetic_dfa.png)