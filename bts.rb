# frozen_string_literal: true

# Node Class
class Node
  include Comparable
  attr_accessor :left, :right, :value
  def initialize(val)
    @value = val
    @left, @right = nil
  end
end

# Comparable Module
module Comparable
end

# Tree Class
class Tree
  attr_accessor :root
  def initialize(arr)
    @root = build_tree(arr, arr[0], arr[-1])
  end

  def build_tree(arr, arr_start, arr_end)
    return nil if arr_start > arr_end

    mid = (arr_start + arr_end) / 2
    root = Node.new(arr[mid])

    root.left = build_tree(arr, arr_start, mid - 1)
    root.right = build_tree(arr, mid + 1, arr_end)

    root
  end

  def search(_array, value)
    return @root if @root.nil? || @root.value == value

    return search(@root.right, value) if @root.value < value

    return search(@root.left, value) if @root.value > value
  end

  def insert(node, value)
    return Node.new(value) if node.value.nil?

    if value < node.value
      node.left = insert(node.left, value)
    elsif value > node.value
      node.right = insert(node.right, value)
    end
    node
  end

  def delete(value)
    delete_rec(@root, value)
  end

  def delete_rec(root, value)
    return root if root.value.nil?

    if value < root.value
      root.left = delete_rec(root.left, value)
    elsif value > root.value
      root.right = delete_rec(root.right, value)
    else
      if root.left.nil?
        return root.right
      elsif root.right.nil?
        return root.left
      end

      root.value = min_value(root.right)

      root.right = delete_rec(root.right, root.value)
    end
  end

  def min_value(root)
    minv = root.value
    unless root.left.nil?
      minv = root.left.value
      root = root.left
    end
    minv
  end

  def pretty_print(node = @root, prefix = '', is_left = true)
    pretty_print(node.right, "#{prefix}#{is_left ? '│   ' : '    '}", false) if node.right
    puts "#{prefix}#{is_left ? '└── ' : '┌── '}#{node.value}"
    pretty_print(node.left, "#{prefix}#{is_left ? '    ' : '│   '}", true) if node.left
  end
end

my_tree = Tree.new([1, 2, 3, 4, 5, 6])
my_tree.delete(5)
my_tree.pretty_print
