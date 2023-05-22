# Functions to work with text files
# Also using regular expressions
#
# Gilberto Echeverria
# 2023-05-02

defmodule FileIO do

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

  @doc """
  Function to extract all the emails from a file, and store them in another file
  one in each row
  """
  def get_emails(in_filename, out_filename) do

  end

end