require 'pp'

class TreeUtils

  def self.all_nodes tree
    return [] if tree.empty?
    tree.keys + tree.values.reduce([]) do |memo, tree|
      memo += all_nodes(tree)
    end
  end

  def self.path target, tree
    return [] if tree.nil? || tree.empty?
    return [target] if tree.has_key?(target)
    path = []
    tree.each do |subroot, subtree|
      subroot = subtree.empty? ? [] : [subroot]
      path = subroot + path(target, subtree)
    end
    path
  end

  def self.populate_tree tree, target, nodes
    path = path(target, tree)
    if path.empty?
      tree[target] = subtree_from(nodes)
    else
      *key, last = path
      key.reduce(tree, :[])[last] = subtree_from(nodes)
    end
    tree
  end

  def self.subtree_from nodes
    Hash[nodes.map { |node| [ node, {} ] }]
  end
end
