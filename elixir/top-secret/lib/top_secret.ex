defmodule TopSecret do
  def to_ast(string) do
    Code.string_to_quoted!(string)
  end

  def decode_secret_message_part(ast, acc) do
    with {:def, _, [{function_name, _, arguments}, _]} <- ast do
      secret =
        function_name
        |> to_string()
        |> String.slice(0..(length(arguments)))

      {ast, [secret | acc]}
    else
      _ -> {ast, acc}
    end

  end

  def decode_secret_message(string) do

  end
end
