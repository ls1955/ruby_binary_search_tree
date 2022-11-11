# frozen_string_literal: true

require 'node'

# binary search tree
class Tree
  attr_accessor :values, :root

  def sanitize(values)
    @values = values.uniq.sort!
  end

  def build_tree(values)
    return nil if values.empty?

    sanitize(values)

    helper = ->(array, left = 0, right = array.length - 1) do
      return nil if left > right

      mid = (left + right) / 2
      Node.new(
        array[mid],
        helper.call(array, left, mid - 1),
        helper.call(array, mid + 1, right)
      )
    end

    @root = helper.call(values)
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

      result = (value < result.value) ? result.left : result.right
    end

    result
  end

  def level_order(node = @root)
    return nil if node.nil?
    return @values unless block_given?

    queue = [node]
    result = []

    until queue.empty?
      curr_node = queue.shift
      result.push(yield(curr_node))
      queue.push(curr_node.left) unless curr_node.left.nil?
      queue.push(curr_node.right) unless curr_node.right.nil?
    end

    result
  end

  def inorder
    result = []

    dfs = ->(node = @root) do
      dfs.call(node.left) unless node.left.nil?
      result << (block_given?) ? yield(node) : node
      dfs.call(node.right) unless node.right.nil?
    end

    dfs
    result
  end

  def preorder
    result = []

    dfs = ->(node = @root) do
      result << (block_given?) ? yield(node) : node
      dfs.call(node.left) unless node.left.nil?
      dfs.call(node.right) unless node.right.nil?
    end

    dfs
    result
  end

  def postorder
    result = []

    dfs = ->(node = @root) do
      dfs.call(node.left) unless node.left.nil?
      dfs.call(node.right) unless node.right.nil?
      result << (block_given?) ? yield(node) : node
    end

    dfs
    result
  end

  def height(node)
    node = find(node.val)

    return 'No such node in the tree' if node.nil?

    find_height = ->(node) do
      return -1 if node.nil?

      left_height = find_height(node.left)
      right_height = find_height(node.right)

      [left_height, right_height].max + 1
    end

    find_height(node)
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

    (right_height - left_height).abs <= 1
  end

  def rebalance
    build_tree(inorder)
  end

  def pretty_print(node = @root, prefix = '', is_left = true)
    pretty_print(node.right, "#{prefix}#{is_left ? '│   ' : '    '}", false) if node.right
    puts "#{prefix}#{is_left ? '└── ' : '┌── '}#{node.data}"
    pretty_print(node.left, "#{prefix}#{is_left ? '    ' : '│   '}", true) if node.left
  end
end
