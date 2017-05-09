### Мета програмиране част 1

Валентин Михов

#HSLIDE

![Logo](assets/what-meta-means.jpg)

#HSLIDE

![Logo](assets/meta-programming-image-old.jpg)

#HSLIDE

![Logo](assets/meta-programming-image-new.jpg)

#HSLIDE

Мета програмиране е код, който пише код

#HSLIDE

### With great power comes a big hammer

![Logo](assets/gandalf-and-frodo.jpg)

#HSLIDE

### ...and it is hard to drop the hammer

![Logo](assets/the-ring.jpg)

#HSLIDE

### Създаване на еднакви функции

```elixir
html do
  head do
    title do
      text "Hello To Our HTML DSL"
    end
  end
  body do
    h1 class: "title" do
      text "Introduction to metaprogramming"
    end
  end
end
```

#HSLIDE

### Може да бъде написано с обикновенна функция, но е по-дълго и трудно за поддръжка

```elixir
tag :html do
  tag :head do
    tag :title do
      text "Hello To Our HTML DSL"
    end
  end
end
```

#HSLIDE

### Дефиниране на domain specific language (DSL)

```elixir
from o in Order,
where: o.created_at > "2017-03-03"
join: i in OrderItems, on: i.order_id == o.id
```

=>

```SQL
SELECT o.*
FROM orders o
JOIN order_items i ON i.order_id = o.id
WHERE o.created_at > '2017-03-03'
```

#HSLIDE

![Logo](assets/dsl-everywhere.jpg)

#HSLIDE

### Ecto DSL goodness

```elixir
def orders(from_date) do
  from o in Order,
  where: o.created_at > ^from_date
  join: i in OrderItems, on: i.order_id == o.id
end

def user_orders(from_date, user_id) do
  from o in orders(from_date),
  where: o.user_id == ^user_id
end
```

#HSLIDE

### Пример от реален сайт

#HSLIDE

### Въведение в Abstract Syntax Tree

* Генерира се като междинен код по време на компилация
* Имаме достъп до него и можем да го променяме чрез макроси
* Можем да генерираме програмно AST и да го вмъкваме в модули
* В elixir, AST много прилича на Lisp

#HSLIDE

### Примери

```elixir
iex> quote do: 1 + 2
{
  :+,
  [context: Elixir, import: Kernel],
  [1, 2]
}
iex> quote do: div(10, 2)
{
  :div,
  [context: Elixir, import: Kernel],
  [10, 2]
}
```


#HSLIDE

```elixir
iex> quote do: 1 + 2 * 3
{
  :+,
  [context: Elixir, import: Kernel],
  [
    1,
    {
      :*,
      [context: Elixir, import: Kernel],
      [2, 3]
    }
  ]
}
```

#HSLIDE

### Макроси

* Изпълняват се по време на *компилация*
* Приемат за аргументи AST
* Връщат AST като резултат

#HSLIDE

### Пример със заместаване на операции

#HSLIDE

### quote & unquote

* `quote` генерира AST
* `unquote` вмъква стойността на аргументите в AST-то
* `unquote` е един вид "интерполация"
* `unquote` ни е нужен за да можем да вмъкваме стойности в генерирания код

#HSLIDE

![Logo](assets/it-is-ok.gif)

#HSLIDE

```elixir
iex> value = 12
12
iex> quote do
...> 1 + 2 * value
...> end
{
  :+, _,
  [
    1,
    {
      :*, _,
      [
        2,
        {:value, [], Elixir}
      ]
    }
  ]
}
```

#HSLIDE

```elixir
iex> value = 12
12
iex> quote do
...> 1 + 2 * unquote(value)
...> end
{
  :+, _,
  [
    1,
    {
      :*, _,
      [2, 12]
    }
  ]
}
```

#HSLIDE

### Как се изпълняват макросите?

1. Компилатора изпълняава макроса по време на компилация
2. Генерираното AST съдържа ли макроси?

    2.1. ДА -> Макросите се изпълняват и отиваме на стъпка 2.

    2.2. НЕ -> Край

#HSLIDE

### Пример с дефиниране на unless

#HSLIDE

### Пример с генериране на функция

#HSLIDE

### Пример с дефиниране на while

#HSLIDE

### Пример с Bottles song

#HSLIDE

### Хигиена в макросите

* Макросите имат много добре дефиниран scope
* По подразбиране не можем да променяме scope-а извън макроса
* Можем да използваме `var!` за да променяме scope-а отвън

#HSLIDE

### Пример за хигиена

#HSLIDE

### Въпроси?

![Logo](assets/happy_cat.jpg)
