defmodule Loops2 do
  defmacro while(expr, do: block) do
    quote do
      Loops2.run_loop(fn -> unquote(expr) end, fn -> unquote(block) end)
    end
  end

  def run_loop(expr_body, loop_body) do
    case expr_body.() do
      true ->
        loop_body.()
        run_loop(expr_body, loop_body)
      _ ->
        :ok
    end
  end
end

defmodule Bottles do
  require Loops2

  def sing(n) do
    i = 0
    Loops2.while(i < n) do
      IO.puts "#{n} bottles hanging on the wall"
      IO.puts "If one bottle crashes on the floor, there will be..."
      i = i - 1 # Won't change the binding in the condition of the loop
      Process.sleep(1000)
    end
    IO.puts "No bottles hanging on the wall"
  end
end
