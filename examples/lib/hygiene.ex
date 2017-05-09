defmodule Hygiene do
  defmacro hygienic do
    quote do: val = -1
  end

  defmacro unhygienic do
    quote do: var!(val) = -1
  end
end

defmodule TestHygiene do
  require Hygiene

  def test1 do
    val = 42

    Hygiene.hygienic

    IO.inspect(val)
  end

  def test2 do
    val = 42

    Hygiene.unhygienic

    IO.inspect(val)
  end
end
