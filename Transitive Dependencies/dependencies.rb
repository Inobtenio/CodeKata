require 'set'

class Dependencies
	def initialize
		@raw_dependencies = Hash.new
		@processed_dependencies = Hash.new
	end

	def add_direct target, dependencies
		@raw_dependencies[target] = dependencies
	end

	def dependencies_for target
		@processed_dependencies[target].to_a
	end

	def calculate_dependencies
		@raw_dependencies.keys.each do |key|
			@processed_dependencies[key] = all_dependencies_for(@raw_dependencies[key], Set[key])
		end
	end

	private

	def all_dependencies_for targets, seen_targets
		dependencies = SortedSet.new(targets)
		targets.each do |target|
			next if seen_targets.include?(target)
			dependencies += look_up_or_calculate_dependencies_for(target, seen_targets)
		end
		remove_first_target_from(dependencies, seen_targets)
	end

	def look_up_or_calculate_dependencies_for target, seen_targets
		@processed_dependencies[target] || calculate_dependencies_for(target, seen_targets.add(target))
	end

	def remove_first_target_from set, targets
		set.delete(targets.first)
	end

	def calculate_dependencies_for target, seen_targets
		@raw_dependencies[target].nil? ? [target] : all_dependencies_for(@raw_dependencies[target], seen_targets)
	end
end
