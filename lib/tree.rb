# frozen_string_literal: true

require 'node'

# binary search tree
class Tree
  attr_accessor :values, :root

  def initialize(values = [])
    @values = sanitize(values)
  end

  def sanitize(values)
    @values = values.uniq.sort!
  end

  def build_tree
    return nil if @values.empty?

    helper = ->(array, left = 0, right = array.length - 1) do
      return nil if left > right

      mid = (left + right) / 2
      Node.new(
        array[mid],
        helper.call(array, left, mid - 1),
        helper.call(array, mid + 1, right)
      )
    end

    @root = helper.call(@values)
  end

  def insert(value, node = @root)
    return Node.new(value) if node.nil?

    if(value < node.val)
      node.left = insert(value, node.left)
    else
      node.right = insert(value, node.right)
    end

    node
  end

  def delete(value, node = @root)
    return nil if node.nil?

    if value < node.left
      node.left = delete(value, node.left)
    elsif value > node.right
      node.right = delete(value, node.right)
    else
      return nil if node.left.nil? && node.right.nil?
      return node.right if node.left.nil?
      return node.right if node.right.nil?

      temp = find_min(node.right)
      node.val = temp.val
      node.right = delete(temp.val, node.right)
    end

    node
  end

  def find_min(node = @right)
    until node.left.nil?
      node = node.left
    end

    node
  end

  def find(value)
    result = @root

    until result.nil?
      return result if result.val == value

      result = result.val < value ? result.right : result.left
    end

    result
  end

  def level_order(node = @root)
    return nil if node.nil?

    queue = [node]
    result = []

    until queue.empty?
      curr_node = queue.shift
      result << curr_node.to_s
      queue.push(curr_node.left) unless curr_node.left.nil?
      queue.push(curr_node.right) unless curr_node.right.nil?
    end

    result
  end

  def inorder(node = @root, result = [])
    return if node.nil?

    inorder(node.left, result)
    if block_given?
      result << yield(node)
    else
      result << node.to_s
    end
    inorder(node.right, result)

    result
  end

  def inorder_array(node = @root, result = [])
    return if node.nil?

    inorder_array(node.left, result)
    result << node.val
    inorder_array(node.right, result)

    result
  end

  def preorder(node = @root, result = [])
    return if node.nil?

    if block_given?
      result << yield(node)
    else
      result << node.to_s
    end
    preorder(node.left, result)
    preorder(node.right, result)

    result
  end

  def postorder(node = @root, result = [])
    return if node.nil?

    postorder(node.left, result)
    postorder(node.right, result)
    if block_given?
      result << yield(node)
    else
      result << node.to_s
    end

    result
  end

  def height(node)
    node = find(node.val)

    return 'No such node in the tree' if node.nil?

    find_height(node)
  end

  def find_height(node)
    return -1 if node.nil?

    left_height = find_height(node.left)
    right_height = find_height(node.right)

    [left_height, right_height].max + 1
  end

  def depth(node)
    node = find(node.val)

    return 'No such node in the tree' if node.nil?

    dummy_root = @root
    tree_height = height(dummy_root)
    node_height = height(node)

    tree_height - node_height
  end

  def balanced?
    return true if @root.left.nil? || @root.right.nil?

    left_height = height(@root.left)
    right_height = height(@root.right)

    return true if (right_height - left_height).abs <= 1

    false
  end

  def rebalance
    @values = inorder_array
    build_tree
  end

  def pretty_print(node = @root, prefix = '', is_left = true)
    pretty_print(node.right, "#{prefix}#{is_left ? '│   ' : '    '}", false) if node.right
    puts "#{prefix}#{is_left ? '└── ' : '┌── '}#{node.data}"
    pretty_print(node.left, "#{prefix}#{is_left ? '    ' : '│   '}", true) if node.left
  end
end
