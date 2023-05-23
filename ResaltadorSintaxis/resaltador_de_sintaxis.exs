# Functions to work with text files
# Also using regular expressions
#



defmodule Resaltador do


  @reserved ~r/^auto|^double|^int|^struct|^break|^else|^long|^switch|^case|^enum|^register|^typedef|^char|^extern|^return|^union|^const|^float|^short|^unsigned|^continue|^for|^signed|^void|^default|^goto|^sizeof|^volatile|^do|^if|^static|^while|^\#include/
  @function ~r/(^[a-zA-Z_][a-zA-Z0-9_]*)\(/
  @ids ~r/^[a-zA-Z_][a-zA-Z0-9_]*(\[\])?/
  @string ~r/^\".*\"|^\'.*\'/
  @lib ~r/^\<(.*)\>/
  @op ~r'^\+\+|^--|^\+=|^-=|^\*=|^\/=|^%=|^<<=|^>>=|^&=|^\|=|^\^=|^<<|^>>|^==|^!=|^<=|^>=|^&&|^\|\||^[+\-*/%&|^<>=!~?:]'
  @integer ~r/[+-]?\d+\.?\d?[eE]?[+-]?\d?/
  @whitespace ~r/^\s+/
  @anyother ~r/^./
  @start ["<html>\n<head>\n\t<link rel='stylesheet' href='base/StylesOfHighlighter.css'>\n</head>\n<body>\n\t<pre>\n"]
  @final "\n\t</pre>\n</body>\n</html>\n"

  @doc """
  Function that reads a file, line by line and returns all the
  """
  def token_file(in_file, out_file) do
    data = in_file
      # Read the file, line by line
      |> File.stream!()
      # Call a function with each line read
      |> Enum.map(&get_tokens(&1))
      |> Enum.join("")
    File.write(out_file, Enum.join([@start, data, @final]))

  end

  @doc """
  Function to check what tokens you have in a string
  """
  def get_tokens(in_string), do: token(in_string, [])

  defp token(in_string, list) do
    cond do
      #Espacios
      Regex.match?(@whitespace, in_string) ->
        current = List.first(Regex.run(@whitespace, in_string))
        new_string = String.replace_leading(in_string, current, "")
        token(new_string, [current | list])
      #Reservadas
      Regex.match?(@reserved, in_string) ->
        current = List.first(Regex.run(@reserved, in_string))
        new_string = String.replace_leading(in_string, current, "")
        token(new_string, [Enum.join(["<span class='res'>", current,"</span>"]) | list])
      #Funciones
      Regex.match?(@function, in_string) ->
        current = List.last(Regex.run(@function, in_string))
        new_string = String.replace_leading(in_string, current, "")
        token(new_string, [Enum.join(["<span class='fun'>", current,"</span>"]) | list])
      #Librerias
      Regex.match?(@lib, in_string) ->
          current = Regex.run(@lib, in_string)
          new_string = String.replace_leading(in_string, List.first(current), "")
          token(new_string, [Enum.join(["<span class='lib'>&lt", List.last(current),"&gt</span>"]) | list])
      #Strings
      Regex.match?(@string, in_string) ->
        current = List.first(Regex.run(@string, in_string))
        new_string = String.replace_leading(in_string, current, "")
        token(new_string, [Enum.join(["<span class='str'>", current,"</span>"]) | list])
      #Identificadores
      Regex.match?(@ids, in_string) ->
        current = List.first(Regex.run(@ids, in_string))
        new_string = String.replace_leading(in_string, current, "")
        token(new_string, [Enum.join(["<span class='ids'>", current,"</span>"]) | list])
      #Operadores
      Regex.match?(@op, in_string) ->
        current = List.first(Regex.run(@op, in_string))
        new_string = String.replace_leading(in_string, current, "")
        token(new_string, [Enum.join(["<span class='ops'>", current,"</span>"]) | list])
      #Enteros
      Regex.match?(@integer, in_string) ->
        current = List.first(Regex.run(@integer, in_string))
        new_string = String.replace_leading(in_string, current, "")
        token(new_string, [Enum.join(["<span class='int'>", current,"</span>"]) | list])
      #Los otros tokens son cualquier otro caracter
      Regex.match?(@anyother, in_string) ->
        current = List.first(Regex.run(@anyother, in_string))
        new_string = String.replace_leading(in_string, current, "")
        token(new_string, [current | list])
      true ->
        Enum.reverse(list)
    end
  end
end
