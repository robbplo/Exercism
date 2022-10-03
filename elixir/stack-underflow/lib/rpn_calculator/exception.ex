defmodule RPNCalculator.Exception do
  defmodule DivisionByZeroError do
    defexception message: "division by zero occurred"
  end

  defmodule StackUnderflowError do
    defexception message: "stack underflow occurred"

    def exception(context) do
      case context do
        [] ->
          %StackUnderflowError{message: "stack underflow occurred"}

        _ ->
          %StackUnderflowError{message: "stack underflow occurred, context: " <> context}
      end
    end
  end

  def divide(numbers) when length(numbers) < 2,
    do: raise(StackUnderflowError, "when dividing")

  def divide([0, _]), do: raise(DivisionByZeroError)

  def divide(numbers) do
    Enum.at(numbers, 1) / Enum.at(numbers, 0)
  end
end
