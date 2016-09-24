defmodule HackIde.Autocomplete do

  def expand('') do
    no()
  end

  def expand(_expr) do
    no()
  end

  defp no do
    {:no, '', []}
  end
end
