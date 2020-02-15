class Dependencies
  def initialize
    @dependencies = Hash.new
  end

  def add_direct target, dependencies
    TreeUtils.append(@dependencies, target, dependencies)
  end

  def dependencies_for target
    TreeUtils.all_nodes(TreeUtils.subtree(target, @dependencies)).sort
  end
end