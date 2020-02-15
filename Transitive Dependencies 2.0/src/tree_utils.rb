require 'pp'

class TreeUtils

  def self.all_nodes tree
    return [] if tree.empty?
    tree.keys + tree.values.reduce([]) do |memo, tree|
      memo += all_nodes(tree)
    end
  end

  def self.path target, tree, path=[]
    return [target] if tree.has_key?(target)
    ### try to refactor with Enumerable#reduce
    tree.each do |subroot, subtree|
      subroot = subtree.empty? ? [] : [subroot]
      path = subroot + path(target, subtree, path)
    end
    return [] unless path.include?(target)
    path
  end

  def self.append tree, target, nodes
    ### simplify
    path = path(target, tree)
    subtrees = Hash[nodes.map {|node| [node, subtree(node, tree)]}]
    paths = Hash[nodes.map {|node| [node, path(node, tree)]}]

    paths.each do |node, path|
      path[0...-1].reduce(tree, :[]).delete(node)
    end

    if path.empty?
      tree[target] = subtrees
    else
      *key, last = path
      key.reduce(tree, :[])[last] = subtrees
    end

    tree
  end

  def self.create_subtree_from nodes
    Hash[nodes.map { |node| [node, {}] }]
  end

  def self.subtree node, tree
    return tree[node] if tree.has_key?(node)
    path = path(node, tree)
    return {} if path.empty?
    tree.dig(*path)
  end
end