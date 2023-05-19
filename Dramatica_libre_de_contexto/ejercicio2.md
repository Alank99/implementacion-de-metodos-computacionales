
&lt;switch&gt; ::= switch (&lt;parametro&gt;){&lt;cuerpo del switch&gt; default:&lt;codigo&gt;} | switch (&lt;parametro&gt;){default:&lt;codigo&gt;} | switch (&lt;parametro&gt;){} | switch (&lt;parametro&gt;){&lt;cuerpo del switch&gt;}

&lt;cuerpo del switch&gt; ::= &lt;case&gt;&lt;cuerpo del switch&gt; | &lt;case&gt;

 &lt;case&gt; ::= case  &lt;enteros&gt;: &lt;codigo&gt; break; | case&lt;enteros&gt;: break; | case&lt;enteros&gt;: &lt;codigo&gt;| case&lt;enteros&gt;: || case&lt;enteros&gt;: break;


EBNF
 SWITCH::= **switch** '('PARAMETRO')'['{'(CUERPO DEL SWITCH (**default** CODIGO |**default**|${\lambda}$)|(**default** CODIGO|**default**)|${\lambda}$|)'}']   

CUERPO DEL SWITCH::= [{(CASE | CUERPO DEL SWITCH)}]

CASE::=**case** ENTEROS[(${\lambda}$ | CODIGO( ${\lambda}$ | **break';'**) |**break';'**)]
