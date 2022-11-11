# frozen_string_literal: true

# A node of the binary search tree
class Node
  include Comparable
  attr_accessor :val, :left, :right

  def initialize(val, left = nil, right = nil)
    @val = val
    @left = left
    @right = right
  end

  def <=>(other)
    return nil unless other.is_a?(Node)

    @val <=> other.val
  end

  def to_s
    " ( #{@val} ) "
  end
end
