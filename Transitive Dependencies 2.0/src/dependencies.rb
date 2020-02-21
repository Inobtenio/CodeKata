class Dependencies
	attr_accessor :tree

	def initialize
		@tree = Hash.new
	end

	def add_direct target, dependencies
		append(target, dependencies)
	end

	def dependencies_for target
		TreeUtils.all_nodes(TreeUtils.subtree(target, @tree)).sort
	end

	private

	def append target, nodes
		subtrees = subtrees(nodes)
		remove_from_tree(nodes)
		repopulate_tree(target, subtrees)
	end

	def subtrees nodes
		Hash[nodes.map {|node| [node, TreeUtils.subtree(node, @tree)]}]
	end

	def remove_from_tree nodes
		nodes.each do |node|
			path_up_to_parent(node).reduce(@tree, :[]).delete(node)
		end
	end

	def path_up_to_parent target
		TreeUtils.path(target, @tree).tap(&:pop)
	end

	def repopulate_tree target, subtrees
		path_up_to_parent(target).reduce(@tree, :[])[target] = subtrees
	end
end