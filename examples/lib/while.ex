defmodule Loops do
  defmacro while(expression, do: block) do
    quote do
      try do
        for _ <- Stream.cycle([:ok]) do
          if unquote(expression) do
            unquote(block)
          else
            throw :break
          end
        end
      catch
        :break -> :ok
      end
    end
  end
end

defmodule Fib do
  require Loops

  def async_fib(n) do
    spawn(fn -> fib(n) end)
  end

  def sync_fib(n) do
    pid = async_fib(n)
    Loops.while(Process.alive?(pid)) do
      IO.puts "Waiting..."
      Process.sleep(1000)
    end
    IO.puts "Done!"
  end

  defp fib(0), do: 0
  defp fib(1), do: 1
  defp fib(n), do: fib(n-1) + fib(n-2)
end
