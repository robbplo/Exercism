defmodule TopSecret do
  def to_ast(string) do
    Code.string_to_quoted!(string)
  end

  def decode_secret_message_part({keyword, _, [{function_name, _, arguments}, _]} = ast, acc)
  when keyword in [:def, :defp] do
    if function_name == :when do
      {actual_name, _, actual_arguments} = hd(arguments)

      {ast, [extract_secret(actual_name, actual_arguments) | acc]}
    else
      {ast, [extract_secret(function_name, arguments) | acc]}
    end
  end

  def decode_secret_message_part(ast, acc), do: {ast, acc}

  def decode_secret_message(string) do
    # some helper functions to extract methods from modules
    #r

    with {:defmodule, _, module} <- to_ast(string),
         [_, module_statements] <- module,
         [do: functions] <- module_statements,
         {:__block__, _, multiple_definitions} <- functions
    do
      Enum.reduce(multiple_definitions, [], fn (ding, acc) ->
        {_, part} = decode_secret_message_part(ding, acc)
        part
      end)
      |> Enum.reverse()
      |> to_string()
    else
      single_definition ->
        {_, message} = decode_secret_message_part(single_definition, [])

        message |> to_string

    end

  end


  defp extract_secret(name, arguments) when is_list(arguments) do
    name
    |> to_charlist()
    |> Enum.take(length(arguments))
    |> to_string()


  end

  defp extract_secret(_, _), do: ""
end
