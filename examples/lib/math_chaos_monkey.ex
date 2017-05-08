defmodule MathChaosMonkey do
  defmacro swap_ops(do: {:+, context, arguments}) do
    {:-, context, arguments}
  end

  defmacro swap_ops(do: {:-, context, arguments}) do
    {:+, context, arguments}
  end

  defmacro swap_ops(do: {:/, context, arguments}) do
    {:*, context, arguments}
  end

  defmacro swap_ops(do: {:*, context, arguments}) do
    {:/, context, arguments}
  end
end

defmodule Example1 do
  alias MathChaosMonkey
  require MathChaosMonkey

  def test_chaos_monkey do
    MathChaosMonkey.swap_ops do
      1 + 2
    end
  end

  def test_chaos_monkey2 do
    MathChaosMonkey.swap_ops do
      10 / 5
    end
  end
end
