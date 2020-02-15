require "dependencies"
require "test/unit"
 
class TestDependencies < Test::Unit::TestCase

	def test_basic
		dep = Dependencies.new
		dep.add_direct('A', %w{ B C } )
		dep.add_direct('B', %w{ C E } )
		dep.add_direct('C', %w{ G   } )
		dep.add_direct('D', %w{ A F } )
		dep.add_direct('E', %w{ F   } )
		dep.add_direct('F', %w{ H   } )

		#dep.dependencies = {"D"=>{"A"=>{"B"=>{"C"=>{"G"=>{}}, "E"=>{"F"=>{"H"=>{}}}}}}}

		assert_equal( %w{ B C E F G H },   dep.dependencies_for('A'))
		assert_equal( %w{ C E F G H },     dep.dependencies_for('B'))
		assert_equal( %w{ G },             dep.dependencies_for('C'))
		assert_equal( %w{ A B C E F G H }, dep.dependencies_for('D'))
		assert_equal( %w{ F H },           dep.dependencies_for('E'))
		assert_equal( %w{ H },             dep.dependencies_for('F'))
	end

	# def test_cyclic
	# 	dep = Dependencies.new
	# 	dep.add_direct('A', %w{ B })
	# 	dep.add_direct('B', %w{ C })
	# 	dep.add_direct('C', %w{ A })

	# 	dep.dependencies = {"A"=>{"B"=>{"C"=>{"A"=>{"B"=>{}}}}}}
	# 	dep.dependencies = {"B"=>{"C"=>{"A"=>{"B"=>{"C"=>{}}}}}}

	# 	assert_equal( %w{ B C },   dep.dependencies_for('A'))
	# 	assert_equal( %w{ A C },   dep.dependencies_for('B'))
	# 	assert_equal( %w{ A B },   dep.dependencies_for('C'))
	# end

	# def test_complex_cyclic
	# 	dep = Dependencies.new
	# 	dep.add_direct('A', %w{ B C D E F G H I J K L M N O } )
	# 	dep.add_direct('B', %w{ C E D J } )
	# 	dep.add_direct('C', %w{ G } )
	# 	dep.add_direct('D', %w{ A F } )
	# 	dep.add_direct('E', %w{ F } )
	# 	dep.add_direct('F', %w{ H G I J K } )
	# 	dep.add_direct('G', %w{ F } )
	# 	dep.add_direct('H', %w{ Z } )
	# 	dep.add_direct('I', %w{ S } )
	# 	dep.add_direct('J', %w{ M O P } )
	# 	dep.add_direct('K', %w{ G H I } )
	# 	dep.add_direct('L', %w{ X } )
	# 	dep.add_direct('M', %w{ A B C D J } )

	# 	assert_equal( %w{ B C D E F G H I J K L M N O P S X Z },   dep.dependencies_for('A'))
	# 	assert_equal( %w{ A C D E F G H I J K L M N O P S X Z },   dep.dependencies_for('B'))
	# 	assert_equal( %w{ X },                                     dep.dependencies_for('L'))
	# 	assert_equal( %w{ A B D E F G H I J K L M N O P S X Z },   dep.dependencies_for('C'))
	# end
end
