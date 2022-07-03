defmodule FileSniffer do
  @file_types_by_extension %{
    "exe" => "application/octet-stream",
    "bmp" => "image/bmp",
    "png" => "image/png",
    "jpg" => "image/jpg",
    "gif" => "image/gif"
  }
  @file_binaries_by_extension %{
    "exe" => <<0x7F, 0x45, 0x4C, 0x46>>,
    "bmp" => <<0x42, 0x4D>>,
    "png" => <<0x89, 0x50, 0x4E, 0x47, 0x0D, 0x0A, 0x1A, 0x0A>>,
    "jpg" => <<0xFF, 0xD8, 0xFF>>,
    "gif" => <<0x47, 0x49, 0x46>>
  }

  def type_from_extension(extension) do
    @file_types_by_extension[extension]
  end

  def type_from_binary(file_binary) do
    @file_binaries_by_extension
    |> Map.to_list()
    |> Enum.filter(fn {_ext, bin} -> String.starts_with?(file_binary, bin) end)
    |> hd()
    |> elem(0)
    |> type_from_extension()
  end

  def verify(file_binary, extension) do
    real_type = type_from_binary(file_binary)
    extension_type = type_from_extension(extension)

    if real_type == extension_type do
      {:ok, real_type}
    else
      {:error, "Warning, file format and file extension do not match."}
    end
  end
end
