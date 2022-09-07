defmodule ProteinTranslation do
  @doc """
  Given an RNA string, return a list of proteins specified by codons, in order.
  """
  @spec of_rna(String.t()) :: {:ok, list(String.t())} | {:error, String.t()}
  def of_rna(rna) do
    # This is gross. maybe recursive?

    codons =
      rna
      |> Stream.unfold(&String.split_at(&1, 3))
      |> Enum.take_while(&(&1 != ""))
      |> Enum.map(&of_codon/1)
      |> Enum.take_while(&(elem(&1, 1) != "STOP"))

    if Enum.any?(codons, fn {atom, _message} -> atom == :error end) do
      {:error, "invalid RNA"}
    else
      {:ok, codons |> Enum.map(&elem(&1, 1))}
    end
  end

  @doc """
  Given a codon, return the corresponding protein
  """
  @spec of_codon(String.t()) :: {:ok, String.t()} | {:error, String.t()}
  def of_codon(codon) do
    protein =
      case codon do
        "UGU" -> "Cysteine"
        "UGC" -> "Cysteine"
        "UUA" -> "Leucine"
        "UUG" -> "Leucine"
        "AUG" -> "Methionine"
        "UUU" -> "Phenylalanine"
        "UUC" -> "Phenylalanine"
        "UCU" -> "Serine"
        "UCC" -> "Serine"
        "UCA" -> "Serine"
        "UCG" -> "Serine"
        "UGG" -> "Tryptophan"
        "UAU" -> "Tyrosine"
        "UAC" -> "Tyrosine"
        "UAA" -> "STOP"
        "UAG" -> "STOP"
        "UGA" -> "STOP"
        _ -> nil
      end

    if is_nil(protein), do: {:error, "invalid codon"}, else: {:ok, protein}
  end
end
