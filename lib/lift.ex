defmodule Lift do
  @moduledoc """
  The `Lift` lib provides functions for working with multi-level nested lists.
  It offers a clean, intuitive interface to transform or access data at specific
  levels of nesting while preserving the overall structure of the data.

  This module is particularly useful when you need to:
    * Map functions over deeply nested lists at a specific level
    * Transform data within nested structures without flattening
    * Handle complex nested data structures while maintaining their shape

  ## Core Functions

    * `l2map/2` - Maps a function over 2-level nested lists
    * `l3map/2` - Maps a function over 3-level nested lists
    * `l4map/2` - Maps a function over 4-level nested lists
    * `l5map/2` - Maps a function over 5-level nested lists
    * `lmap/3` - The general version which maps a function over elements at any specified nesting level

    ## Examples

    A simple transformation at the second level:

        iex> numbers = [[1, 2], [3, 4]]
        iex> Lift.l2map(numbers, fn x -> x * 2 end)
        [[2, 4], [6, 8]]

    ## Name Origin

    The name "Lift" comes from functional programming concepts, specifically the idea of
    "lifting" when work with functors. In functional programming, when we compose
    functors (like nested lists), we "lift" our function to work at different levels of
    the structure. This is similar to Haskell's `fmap . fmap` composition, which lifts
    a function to work with nested functors.

  """

  @doc """
  Maps a function over a nested list at the specified level of nesting.
  Takes a nested list as the first argument, followed by the nesting level
  and a mapping function.

  ## Parameters
    * `list` - A nested list to transform
    * `level` - The level of nesting at which to apply the function
    * `fun` - The function to apply at the specified nesting level

  ## Examples

      iex> Lift.lmap([[1, 2], [3, 4], [5, 6]], 2, fn i -> i * 10 end)
      [[10, 20], [30, 40], [50, 60]]

      iex> Lift.lmap([[["a", "b"], ["c", "d"]], [["e", "f"], ["g", "h"]], [["i", "j"], ["k", "l"]]], 3, &String.upcase/1)
      [[["A", "B"], ["C", "D"]], [["E", "F"], ["G", "H"]], [["I", "J"], ["K", "L"]]]

  """
  def lmap(nested_list, level, func) do
    level_accessors = List.duplicate(Access.all(), level)
    update_in(nested_list, level_accessors, func)
  end

  @doc """
  Maps a function over a 2-level nested list.
  Takes a nested list as the first argument, followed by a mapping function.
  This is equivalent to calling `lmap(list, 2, fun)`.

  ## Examples
     iex> numbers = [[1, 2], [3, 4], [5, 6]]
     iex> Lift.l2map(numbers, fn x -> x * 2 end)
     [[2, 4], [6, 8], [10, 12]]

     iex> strings = [["a", "b"], ["c", "d"]]
     iex> Lift.l2map(strings, &String.upcase/1)
     [["A", "B"], ["C", "D"]]
  """
  def l2map(list, fun), do: lmap(list, 2, fun)

  @doc """
  Maps a function over a 3-level nested list.
  Takes a nested list as the first argument, followed by a mapping function.
  This is equivalent to calling `lmap(list, 3, fun)`.

  ## Examples
     iex> numbers = [[[1, 2], [3, 4]], [[5, 6], [7, 8]]]
     iex> Lift.l3map(numbers, fn x -> x + 1 end)
     [[[2, 3], [4, 5]], [[6, 7], [8, 9]]]

     iex> strings = [[["hello", "world"], ["foo"]], [["bar"], ["baz", "qux"]]]
     iex> Lift.l3map(strings, &String.capitalize/1)
     [[["Hello", "World"], ["Foo"]], [["Bar"], ["Baz", "Qux"]]]
  """
  def l3map(list, fun), do: lmap(list, 3, fun)

  @doc """
  Maps a function over a 4-level nested list.
  Takes a nested list as the first argument, followed by a mapping function.
  This is equivalent to calling `lmap(list, 4, fun)`.

  ## Examples
     iex> numbers = [[[[1, 2], [3]], [[4, 5]]], [[[6]], [[7, 8], [9]]]]
     iex> Lift.l4map(numbers, fn x -> x * 2 end)
     [[[[2, 4], [6]], [[8, 10]]], [[[12]], [[14, 16], [18]]]]

     iex> strings = [[[[{"a", 1}]]], [[[{"b", 2}]]]]
     iex> Lift.l4map(strings, fn {str, num} -> {String.upcase(str), num} end)
     [[[[{"A", 1}]]], [[[{"B", 2}]]]]
  """
  def l4map(list, fun), do: lmap(list, 4, fun)

  @doc """
  Maps a function over a 5-level nested list.
  Takes a nested list as the first argument, followed by a mapping function.
  This is equivalent to calling `lmap(list, 5, fun)`.

  ## Examples
     iex> numbers = [[[[[1]], [[2]]], [[[3]]]], [[[[4]]], [[[5]], [[6]]]]]
     iex> Lift.l5map(numbers, fn x -> x + 10 end)
     [[[[[11]], [[12]]], [[[13]]]], [[[[14]]], [[[15]], [[16]]]]]

     iex> data = [[[[[%{x: 1}]], [[%{x: 2}]]]], [[[[%{x: 3}]]]]]
     iex> Lift.l5map(data, fn map -> Map.update!(map, :x, & &1 * 2) end)
     [[[[[%{x: 2}]], [[%{x: 4}]]]], [[[[%{x: 6}]]]]]
  """
  def l5map(list, fun), do: lmap(list, 5, fun)
end
