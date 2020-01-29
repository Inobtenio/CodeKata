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
			@processed_dependencies[key] = all_dependencies_for(@raw_dependencies[key], [key])&.uniq&.sort
		end
	end

	private

	def all_dependencies_for targets, touched
		deps = Array.new
		targets.each do |target|
			next if touched.include?(target)
			value = Array(dependencies_for target) - touched
			value = calculate_dependencies_for(target, touched.push(target)) if value.empty?
			deps.push(value, target)
		end
		deps.flatten
	end

	def calculate_dependencies_for target, touched
		@raw_dependencies[target].nil? ? target : all_dependencies_for(@raw_dependencies[target], touched)
	end
end
