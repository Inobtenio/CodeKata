class Dependencies
	attr_accessor :tree

	def initialize
		@tree = Hash.new
	end

	def add_direct target, dependencies
		append(target, dependencies)
	end

	def dependencies_for target
		TreeUtils.all_nodes(subtree_under(target)).sort
	end

	private

	def append target, nodes
		subtrees_under_nodes = find_subtrees_under(nodes)
		remove_from_tree(nodes)
		repopulate_tree(target, subtrees_under_nodes)
	end

	def find_subtrees_under nodes
		Hash[nodes.map {|node| [node, subtree_under(node)]}]
	end
	
	def subtree_under target
		TreeUtils.tree_starting_at(target, @tree)[target] || {}
	end

	def remove_from_tree nodes
		nodes.each {|node| TreeUtils.tree_starting_at(node, @tree).delete(node)}
	end

	def repopulate_tree target, subtrees
		TreeUtils.tree_starting_at(target, @tree)[target] = subtrees
	end
end