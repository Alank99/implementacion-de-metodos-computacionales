# Functions to work with text files
# Also using regular expressions
#
# Gilberto Echeverria
# 2023-05-02

defmodule Resaltador do

  @doc """
  Change a letter character for another separated 'offset' positions in the alphabet
  Keep case the same as the original
  """
  def shift_chars(char, offset) do
    cond do
      # Lowercase letters
      97 <= char and char <= 122 -> Integer.mod(char - 97 + offset, 26) + 97
      # Uppercase letters
      65 <= char and char <= 90 -> Integer.mod(char - 65 + offset, 26) + 65
      # Any other character
      true -> char
    end
  end

  @doc """
  Change all the characters of a line using the previous function
  """
  def shift_line(line, offset) do
    ## Using nested function calls
    # Using a lambda function to be called by map
    #to_string(Enum.map(to_charlist(line), fn char -> shift_chars(char, offset) end))
    # Using a capture function to be called by map
    #to_string(Enum.map(to_charlist(line), &shift_chars(&1, offset)))

    ## Using temporary variables to avoid nesting
    #temp1 = to_charlist(line)
    #temp2 = Enum.map(temp1, &shift_chars(&1, offset))
    #to_string(temp2)

    ## Using pipes to make the code cleaner
    # The previous result in the pipeline is used as the first argument for the next function
    line
    #|> IO.inspect(label: "step1")
    |> to_charlist()
    #|> IO.inspect(label: "step2")
    |> Enum.map(&shift_chars(&1, offset))
    #|> IO.inspect(label: "step3")
    |> to_string()

  end

  @doc """
  Function to perform Ceasar Cipher on a text file
  """
  def caesar(in_filename, out_filename, offset) do
    data = in_filename
           # Read the file, line by line
           |> File.stream!()
           # Call a function with each line read
           |> Enum.map(&shift_line(&1, offset))
           #|> IO.inspect()
           |> Enum.join("")

    # Store the results in a new file
    File.write(out_filename, data)
  end

  @reserved ~r/^auto|^double|^int|^struct|^break|^else|^long|^switch|^case|^enum|^register|^typedef|^char|^extern|^return|^union|^const|^float|^short|^unsigned|^continue|^for|^signed|^void|^default|^goto|^sizeof|^volatile|^do|^if|^static|^while|^\#include/
  @function ~r/^[a-zA-Z_][a-zA-Z0-9_]*\(/
  @ids ~r/^[a-zA-Z_][a-zA-Z0-9_]*(\[\])?/
  @string ~r/^\".*\"|^\'.*\'|^\<.*\>/
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
      #Palabras reservadas
      Regex.match?(@whitespace, in_string) ->
        new_string = Regex.replace(@whitespace, in_string, "", global: false)
        current = Regex.run(@whitespace, in_string)
        token(new_string, [current | list])
      Regex.match?(@reserved, in_string) ->
        new_string = Regex.replace(@reserved, in_string, "", global: false)
        current = Regex.run(@reserved, in_string)
        token(new_string, [Enum.join(["<span class='res'>", current,"</span>"]) | list])
      Regex.match?(@function, in_string) ->
        new_string = Regex.replace(@function, in_string, "", global: false)
        current = Regex.run(@function, in_string)
        token(new_string, [Enum.join(["<span class='fun'>", current,"</span>"]) | list])
      Regex.match?(@string, in_string) ->
        new_string = Regex.replace(@string, in_string, "", global: false)
        current = Regex.run(@string, in_string)
        token(new_string, [Enum.join(["<span class='str'>", current,"</span>"]) | list])
      Regex.match?(@ids, in_string) ->
        new_string = Regex.replace(@ids, in_string, "", global: false)
        current = Regex.run(@ids, in_string)
        token(new_string, [Enum.join(["<span class='ids'>", current,"</span>"]) | list])
      Regex.match?(@op, in_string) ->
        new_string = Regex.replace(@op, in_string, "", global: false)
        current = Regex.run(@op, in_string)
        token(new_string, [Enum.join(["<span class='ops'>", current,"</span>"]) | list])
      Regex.match?(@integer, in_string) ->
        new_string = Regex.replace(@integer, in_string, "", global: false)
        current = Regex.run(@integer, in_string)
        token(new_string, [Enum.join(["<span class='int'>", current,"</span>"]) | list])
      Regex.match?(@anyother, in_string) ->
        new_string = Regex.replace(@anyother, in_string, "", global: false)
        current = Regex.run(@anyother, in_string)
        token(new_string, [current | list])
      true ->
        Enum.reverse(list)
    end
  end

end
