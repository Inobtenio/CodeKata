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
  end

  test 'can populate a dependency tree' do
    assert_equal ({a: {}}), TreeUtils.append({}, :a, [])
    assert_equal ({a: {b: {}, c: {}}}), TreeUtils.append({}, :a, [:b, :c])
    assert_equal ({a: {b: {c: {}, d: {} }}}), TreeUtils.append({a: {b: {}}}, :b, [:c, :d])
    assert_equal ({a: {b: {c: { d: {}}, e:{} }}}), TreeUtils.append({a: {b: {}, c: { d: {}}}}, :b, [:c, :e])
    assert_equal ({b: {a: {}}}), TreeUtils.append({a: {}}, :b, [:a])
  end

  test 'can find a subtree given a node' do
    assert_equal ({}), TreeUtils.subtree(:a, {})
    assert_equal ({}), TreeUtils.subtree(:a, {a: {}})
    assert_equal ({}), TreeUtils.subtree(:b, {a: {}})
    assert_equal ({b: {}}), TreeUtils.subtree(:a, {a: {b: {}}})
    assert_equal ({c: {}}), TreeUtils.subtree(:b, {a: {b: {c: {}}}})
    assert_equal ({m: {d: {}}}), TreeUtils.subtree(:l, a: {b: {c: {}}}, k: {l: {m: {d: {}}}})
  end
end
