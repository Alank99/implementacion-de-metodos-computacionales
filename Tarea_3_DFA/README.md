# State diagrams

Diagrams for the Deterministic Finite Automatons (DFA) implemented in Racket

Created using [Mermaid](https://mermaid.js.org/syntax/flowchart.html)

## (aa)\*b[ab]\*

At least one _b_, with an even number of _a_'s before.

```mermaid
graph LR;
%% Style definitions
classDef initial fill:#282
classDef accept stroke:#f44,stroke-width:4px

%% Node shape definitions
q0((q0))
q1((q1))
q2((q2))
q3((q3))
inv((inv))

%% Node types
class q0 initial
class q1 accept

%% The graph
q0-->|a|q2;
q0-->|b|q1;
q1-->|a,b|q1;
q2-->|a|q3;
q2-->|b|inv;
q3-->|a|q2;
q3-->|b|q1;
```

## (a*(bb)+)*

Strings with an even number of _b_'s, ending with _b_'s.

```mermaid
graph LR;

%% Style definitions
classDef initial fill:#282
classDef accept stroke:#f44,stroke-width:4px

%% Node shape definitions
q0((q0))
q1((q1))
q2((q2))
q3((q3))
inv((inv))

%% Node types
class q0 initial
class q0,q2 accept

%% The graph
q0-->|a|q3;
q0-->|b|q1;
q1-->|a|inv;
q1-->|b|q2;
q2-->|a|q3;
q2-->|b|q1;
q3-->|a|q3;
q3-->|b|q1;
```

## Numbers

Different types of numbers

```mermaid
graph LR;

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

%% Node types
class start initial
class int,float,exp accept

%% The graph
start-->|digit|int;
start-->|+,-|sign;
sign-->|digit|int;
int-->|digit|int;
int-->|.|dot;
int-->|e,E|e;
dot-->|digit|float;
float-->|digit|float;
float-->|e,E|e;
e-->|+,-|e_sign;
e-->|digit|exp;
e_sign-->|digit|exp;
exp-->|digit|exp;
```

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

%% Node types
class start initial
class int,float,exp,var,spa accept

%% The graph
start-->|digit|int;
start-->|+,-|sign;
start-->|letter,_|var;
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