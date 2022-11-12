# frozen_string_literal: true

require_relative '../lib/node'
require_relative '../lib/tree'

RSpec.describe Node do
  let(:node_first) { Node.new(0) }
  let(:node_second) { Node.new(1) }

  xit 'initialize as a node containing value' do
    expect(node_first.to_s).to eq(' ( 0 ) ')
  end

  xit 'could compare value with other node' do
    expect(node_first < node_second).to be(true)
  end
end

RSpec.describe Tree do
  let(:tree) { Tree.new }

  xit 'has no root if tree is not build' do
    expect(tree.root).to be(nil)
  end

  xit 'has root after tree is build' do
    tree.build_tree([1, 7, 4, 23, 8, 9, 4, 3, 5, 7, 9, 67, 6345, 324])
    !expect(tree.root).nil?
  end
end

# driver_script
tree = Tree.new(Array.new(15) { rand(1..100) })
tree.build_tree

puts tree.balanced?
p tree.level_order
p tree.inorder
p tree.preorder
p tree.postorder
3.times { tree.insert(rand(150..200)) }
puts tree.balanced?
tree.rebalance
puts tree.balanced?
p tree.level_order
p tree.inorder
p tree.preorder
p tree.postorder
