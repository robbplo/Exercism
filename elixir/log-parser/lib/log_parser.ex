defmodule LogParser do
  def valid_line?(line) do
    cond do
      line =~ ~r/^\[(DEBUG|INFO|WARNING|ERROR)\]/ -> true
      true -> false
    end
  end

  def split_line(line) do
     Regex.split(~r/<[~\-*=]*>/, line)
  end

  def remove_artifacts(line) do
    Regex.replace(~r/end-of-line\d+/i, line, "")
  end

  def tag_with_user_name(line) do
    with [_, name] <- Regex.run(~r/User\s+([\S]+)/, line) do
      "[USER] " <> name <> " " <> line
    else
      _ -> line
    end
  end
end
