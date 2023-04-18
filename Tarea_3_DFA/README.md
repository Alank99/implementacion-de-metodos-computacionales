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
div-->|space|spa_op

comment-->|"\n"|start

sign-->|digit|int;

int-->|digit|int;
int-->|.|dot;
int-->|e,E|e;
int-->|+,-,*,=|op
int-->|space|spa
int-->|par close|par_close
int-->|/|div

dot-->|digit|float;

float-->|digit|float;
float-->|e,E|e;
float-->|+,-,*,=|op
float-->|space|spa
float-->|/|div
float-->|par close|par_close

e-->|+,-|e_sign;
e-->|digit|exp;

e_sign-->|digit|exp;

exp-->|digit|exp;
exp-->|+,-,*,=|op
exp-->|/|div
exp-->|par close|par_close
exp-->|space|spa

var-->|letter,digit,_|var;
var-->|+,-,*,=|op
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

Drawn with the tool https://madebyevan.com/fsm/

![Arithmetic DFA](arithmetic_dfa.png)
