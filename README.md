# Description
This project is part of [The Odin Project](https://www.theodinproject.com/lessons/ruby-binary-search-trees)'s curriculum, where a balanced [binary search tree](https://en.wikipedia.org/wiki/Binary_search_tree) is implemented.

# Structure
Node class - node that contain value, have left and right pointer, which point to its 2 children.

Tree class - the binary search tree itself

# Tree class Method
**#build_tree**

    Build a balanced bst via an array of value and return the root node
    
 **#insert**
 
    Insert a node into the tree with given value
    
 **#delete**
    
    Delete a node from the tree with given value

**#find**

    Find a node with given value
    
**#level_order**

    Travel the tree in breadth-first level order and return an array of values, or an array with values from the block given
    
**#inorder**

    Travel the tree in inorder traveral and return an array of values, or an array with values from the block given
    
**#preorder**

    Travel the tree in preorder traveral and return an array of values, or an array with values from the block given
    
**#postorder**

    Travel the tree in postorder traveral and return an array of values, or an array with values from the block given
    
**#height**

    Return the height of a given node. Height is defined as the number of edges in the longest path, from a given node to a leaf node
    
**#depth**

    Return the depth of a given node. Depth is defined as the number of edges in path from a given node to the tree's root node
    
**#balanced?**

    Check if the tree is balanced, a balanced tree is one where the difference between the height of left and right subtree of every node is not more than 1
    
**#rebalance**

    Rebalance an unbalanced tree
