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
    @root = build_tree(level_order_rec(arr.sort), @root)
  end

  def build_tree(arr, root, int = 0)
    return root unless int < arr.length

    root = Node.new(arr[int])
    root.left = build_tree(arr, root.left, 2 * int + 1)
    root.right = build_tree(arr, root.right, 2 * int + 2)
    root
  end

  def find(value, root = @root)
    return root if root.nil? || root.value == value
    return find(value, root.right) if root.value < value
    return find(value, root.left) if root.value > value
  end

  def insert(value)
    @root = insert_rec(@root, value)
  end

  def insert_rec(node, value)
    return Node.new(value) if node.nil? || node.value.nil?

    if value < node.value
      node.left = insert_rec(node.left, value)
    elsif value > node.value
      node.right = insert_rec(node.right, value)
    end
    node
  end

  def delete(value)
    delete_rec(@root, value)
  end

  def delete_rec(root, value)
    return root if root.nil? || root.value.nil?

    if value < root.value
      root.left = delete_rec(root.left, value)
    elsif value > root.value
      root.right = delete_rec(root.right, value)
    else
      return root.right if root.left.nil?
      return root.left if root.right.nil?

      root.value = min_value(root.right)
      root.right = delete_rec(root.right, root.value)
    end
    root
  end

  def min_value(root)
    minv = root.value
    unless root.left.nil?
      minv = root.left.value
      root.left
    end
    minv
  end

  def level_order(root = @root)
    return if root.nil?

    arr = []
    que = []
    que.push(root)
    until que.empty?
      current = que[-1]
      arr.push(current.value)
      que.unshift(current.left) unless current.left.nil?
      que.unshift(current.right) unless current.right.nil?
      que.pop
    end
    arr
  end

  def level_order_rec(arr = [], que = [], root = @root)
    return arr if root.nil?

    que.push(root)
    current = que[-1]
    arr.push(current.value)
    level_order_rec(arr, que, current.left) unless current.left.nil?
    level_order_rec(arr, que, current.right) unless current.right.nil?
    que.pop
    arr
  end

  def inorder(arr = [], node = @root)
    return if node.nil?

    inorder(arr, node.left)
    arr.push(node.value)
    inorder(arr, node.right)
    arr
  end

  def preorder(arr = [], node = @root)
    return if node.nil?

    arr.push(node.value)
    preorder(arr, node.left)
    preorder(arr, node.right)
    arr
  end

  def postorder(arr = [], node = @root)
    return if node.nil?

    postorder(arr, node.left)
    postorder(arr, node.right)
    arr.push(node.value)
    arr
  end

  def height(node = @root)
    return -1 if node.nil? || node.value.nil?

    left = height(node.left)
    right = height(node.right)
    [left, right].max + 1
  end

  def depth(value, level = 0, root = @root)
    return -1 if root.nil? || root.value.nil?
    return level if root.value == value

    p = depth(value, level + 1, root.left)
    return p unless p == -1

    depth(value, level + 1, root.right)
  end

  def balanced?(node = @root)
    left = height(node.left)
    right = height(node.right)
    return true if right - left < 2 && left - right < 2

    false
  end

  def rebalance
    @root = build_tree(level_order.sort, @root)
  end

  def pretty_print(node = @root, prefix = '', is_left = true)
    pretty_print(node.right, "#{prefix}#{is_left ? '│   ' : '    '}", false) if node.right
    puts "#{prefix}#{is_left ? '└── ' : '┌── '}#{node.value}"
    pretty_print(node.left, "#{prefix}#{is_left ? '    ' : '│   '}", true) if node.left
  end
end

my_tree = Tree.new([1, 2, 3, 4, 5, 6])
my_tree.pretty_print
my_tree.insert(8)
my_tree.insert(57)
my_tree.insert(-2)
my_tree.insert(58)
my_tree.insert(59)
my_tree.insert(69)
my_tree.pretty_print
my_tree.delete(5)
my_tree.pretty_print
my_tree.find(5)
p my_tree.level_order
p my_tree.level_order_rec
p my_tree.inorder
p my_tree.preorder
p my_tree.postorder
p my_tree.height
p my_tree.depth(3)
p my_tree.balanced?
my_tree.rebalance
my_tree.pretty_print
p my_tree.balanced?
