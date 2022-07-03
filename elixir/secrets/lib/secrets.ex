defmodule Secrets do
  def secret_add(secret) do
    fn num ->
      num + secret
    end
  end

  def secret_subtract(secret) do
    &(&1 - secret)
  end

  def secret_multiply(secret) do
    &(&1 * secret)
  end

  def secret_divide(secret) do
    fn num ->
      div(num, secret)
    end
  end

  def secret_and(secret) do
    &Bitwise.band(&1, secret)
  end

  def secret_xor(secret) do
    &Bitwise.bxor(&1, secret)
  end

  def secret_combine(secret_function1, secret_function2) do
    fn num ->
      secret_function1.(num)
      |> secret_function2.()
    end
  end
end
