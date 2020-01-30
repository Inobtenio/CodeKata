class Dependencies
	def initialize
		@raw_dependencies = Hash.new
		@processed_dependencies = Hash.new
	end

	def add_direct target, dependencies
		@raw_dependencies[target] = dependencies
	end

	def dependencies_for target
		@processed_dependencies[target]
	end

	def calculate_dependencies
		@raw_dependencies.keys.each do |key|
			@processed_dependencies[key] = all_dependencies_for(@raw_dependencies[key], [key])
		end
	end

	private

	def all_dependencies_for targets, seen_targets
		dependencies = Array(targets)
		targets.each do |target|
			next if seen_targets.include?(target)
			dependencies += look_up_or_calculate_dependencies_for(target, seen_targets)
		end
		refine(dependencies, seen_targets.first)
	end

	def look_up_or_calculate_dependencies_for target, seen_targets
		dependencies_for(target) || calculate_dependencies_for(target, seen_targets.push(target))
	end

	def refine array, target_to_exclude
		array.uniq.sort - [target_to_exclude]
	end

	def calculate_dependencies_for target, seen_targets
		@raw_dependencies[target].nil? ? [target] : all_dependencies_for(@raw_dependencies[target], seen_targets)
	end
end
