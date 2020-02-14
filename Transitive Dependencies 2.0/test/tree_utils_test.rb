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
  end

  test 'can populate a dependency tree' do

    assert_equal ({a: {}}), TreeUtils.populate_tree({}, :a, [])
    assert_equal ({a: {b: {}, c: {}}}), TreeUtils.populate_tree({}, :a, [:b, :c])
    assert_equal ({a: {b: {c: {}, d: {}}}}), TreeUtils.populate_tree({a: {b: {}}}, :b, [:c, :d])
  end
end
