require 'pp'

class TreeUtils

  def self.all_nodes tree
    return [] if tree.empty?
    tree.keys + tree.values.reduce([]) do |memo, subtree|
      memo += all_nodes(subtree)
    end
  end

  def self.path target, tree
    return [target] if tree.has_key?(target)
    tree.reduce([]) do |memo, (subroot, subtree)|
      path_candidate = [subroot] + path(target, subtree)
      path_candidate.include?(target) ? memo += path_candidate : memo
    end
  end

  def self.tree_starting_at target, tree
    path(target, tree).tap(&:pop).reduce(tree, :[])
  end
end