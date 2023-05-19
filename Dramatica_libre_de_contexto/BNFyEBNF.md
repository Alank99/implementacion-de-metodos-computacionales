# Actividad 3.3 Practicando los lenguajes libres de contexto

### Alan Anthony Hernández Pérez A01783347

### Mario Ignacio Frías Pina A01782559

## BNF para un modulo y funcion

&lt;modulo&gt; ::= defmodule &lt;nombre del modulo&gt; do /n/t &lt;cuerpo del modulo&gt; /n end

&lt;cuerpo del modulo&gt; ::= &lt;Funcion&gt;&lt;cuerpo del modulo&gt; | &lt;Funcion&gt;

&lt;Funcion&gt;::= def &lt;nombre de la funcion&gt;(&lt;parametros&gt;) &lt;Cuerpo de la funcion&gt; | defp &lt;nombre de la funcion&gt;(&lt;parametros&gt;)&lt;cuerpo de la funcion&gt;

&lt;parametros&gt;::= &lt;parametro&gt; | &lt;parametro&gt;, &lt;parametros&gt; 

&lt;cuerpo de la funcion&gt;::=,do: &lt;codigo&gt; | do: &lt;expresiones&gt; end | when &lt;codincional&gt; , do: &lt;codigo&gt; | when &lt;codincional&gt; , do &lt;expresiones&gt; end

&lt;nombre del modulo&gt; ::=  &lt;mayuscula&gt;&lt;restos del nombre&gt;

&lt;resto del nombre&gt; ::= &lt;char&gt;&lt;restos del nombre&gt;| &lt;mayuscula&gt;&lt;resto del nombre&gt;|&lt;char&gt;|&lt;mayuscula&gt;

&lt;nombre de la funcion&gt; ::=  &lt;char&gt;&lt;nombre de la funcion&gt;|&lt;char&gt;

## EBNF para un modulo y funcion

MODULO ::= **defmodule** NOMBRE_MODULO **do** {FUNCION} **end**

FUNCION ::= (**def** | **defp**) NOMBRE_FUNCION '('[{PARAMETRO}]')' CUERPO_FUNCION

CUERPO_FUNCION ::= **,do:**  CODIGO | **do:** {EXPRESION} **end** | **when** CONDICIONAL **, do:** CODIGO | **when** CONDICIONAL **,do** {EXPRESION} **end**