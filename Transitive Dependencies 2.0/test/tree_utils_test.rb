require "tree_utils"
require "test/unit"
 
class TreeUtilsTest < Test::Unit::TestCase

  test 'can get all the nodes of a tree' do
    assert_equal [], TreeUtils.all_nodes({})
    assert_equal [:a], TreeUtils.all_nodes({a: {}})
    assert_equal [:a, :b, :c], TreeUtils.all_nodes(a: {}, b: {}, c: {})
    assert_equal [:a, :b, :c], TreeUtils.all_nodes(a: { b: { c: {}}})
    assert_equal [:a, :b, :c, :d, :e], TreeUtils.all_nodes(a: { b: {}, c: {}}, d: { e: {}}).sort
  end

  test 'can get a path to a target' do
    assert_equal [], TreeUtils.path(:a, {})
    assert_equal [], TreeUtils.path(:a, {b: {}})
    assert_equal [:a], TreeUtils.path(:a, { a: {}})
    assert_equal [:a], TreeUtils.path(:a, { a: {}, b: {}})
    assert_equal [:a, :b, :c], TreeUtils.path(:c, a: {b: { c: {}}})
    assert_equal [:k, :l, :m, :d], TreeUtils.path(:d, a: {b: {c: {}}}, k: {l: {m: {d: {}}}})
    assert_equal [], TreeUtils.path(:s, a: {b: {c: {}}}, k: {l: {m: {d: {}}}})
    assert_equal [:d, :a, :b, :e], TreeUtils.path(:e, {d: {a: {b: {c: {g: {}}, e: {}}}, f: {}}})
    assert_equal [:a], TreeUtils.path(:a, { a: {b: {c: {d: {e: {f: {}}}}}}, z: {}})
  end

  test 'can get a subtree from the level the target is at' do
    assert_equal ({}), TreeUtils.tree_starting_at(:a, {})
    assert_equal ({a: {}, b: {}}), TreeUtils.tree_starting_at(:a, {a: {}, b: {}})
    assert_equal ({a: {}}), TreeUtils.tree_starting_at(:b, {a: {}})
    assert_equal ({a: {b: {}}}), TreeUtils.tree_starting_at(:a, {a: {b: {}}})
    assert_equal ({b: {c: {}}}), TreeUtils.tree_starting_at(:b, {a: {b: {c: {}}}})
    assert_equal ({l: {m: {d: {}}}}), TreeUtils.tree_starting_at(:l, a: {b: {c: {}}}, k: {l: {m: {d: {}}}})
  end
end
