defmodule Cond do
  defmacro unless(expr, do: block) do
    quote do
      if !unquote(expr), do: unquote(block)
    end
  end
end

defmodule TestUnless do
  require Cond

  def test1 do
    Cond.unless true do
      IO.puts "This should not be printed"
    end
    Cond.unless false do
      IO.puts "Our `unless` works!"
    end
  end

  def test2 do
    ast = quote do: Cond.unless(true, do: IO.puts("Test"))
    IO.puts "Original AST:"
    IO.inspect ast

    IO.puts "Expand once:"
    IO.inspect Macro.expand_once(ast, __ENV__)

    IO.puts "Expand twice:"
    IO.inspect ast |> Macro.expand_once(__ENV__) |> Macro.expand_once(__ENV__)

    IO.puts "Expand three times:"
    IO.inspect ast |> Macro.expand_once(__ENV__) |> Macro.expand_once(__ENV__)

    :ok
  end
end
