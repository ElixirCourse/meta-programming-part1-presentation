defmodule Multiplier do
  defmacro of(value) do
    quote do
      def unquote(:"multiplier_#{value}")(expr) do
        expr * unquote(value)
      end
    end
  end
end

defmodule Math do
  require Multiplier

  Multiplier.of(5)
  Multiplier.of(2)

  def test_multipler5 do
    multiplier_5(10)
  end

  def test_multipler2 do
    multiplier_2(15)
  end
end
