defmodule RnaTranscription do
  @dnamapping %{
    ?G => ?C,
    ?C => ?G,
    ?T => ?A,
    ?A => ?U
  }
  @doc """
  Transcribes a character list representing DNA nucleotides to RNA

  ## Examples

  iex> RnaTranscription.to_rna('ACTG')
  'UGAC'
  """
  @spec to_rna([char]) :: [char]
  def to_rna(''), do: ''
  def to_rna(dna), do: Enum.map(dna, &@dnamapping[&1])
end
