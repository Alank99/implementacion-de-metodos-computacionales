**BNF para un modulo y funcion**

&lt;modulo&gt; ::= defmodule &lt;nombre del modulo&gt; do /n/t &lt;cuerpo del modulo&gt; /n end

&lt;cuerpo del modulo&gt; ::= &lt;Funcion&gt;&lt;cuerpo del modulo&gt; | &lt;codigo&gt;&lt;cuerpo del modulo&gt; | &lt;codigo&gt; | &lt;Funcion&gt;

&lt;Funcion&gt;::= def &lt;nombre de la funcion&gt;(&lt;parametros&gt;) &lt;Cuerpo de la funcion&gt; | defp &lt;nombre de la funcion&gt;(&lt;parametros&gt;)&lt;cuerpo de la funcion&gt;

&lt;parametros&gt;::= &lt;parametro&gt; | &lt;parametro&gt;, &lt;parametros&gt; 

&lt;cuerpo de la funcion&gt;::=,do: &lt;codigo&gt;  |,do: &lt;codigo&gt; end  



