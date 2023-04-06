# https://github.com/trkin/rails_minitest/blob/main/test/a/assert_equal_when_sorted.rb
module MiniTest::Assertions
  # Fails unless <tt>exp</tt> and <tt>act</tt> are both arrays and
  # contain the same elements which are sorted by keys (default is :id)
  #
  #     assert_equal_when_sorted [{id: 1}, {id: 2}], [{id: 2}, {id: 1}]

  def assert_equal_when_sorted(exp, act, default_key: :id)
    exp_ary = exp.to_ary
    assert_kind_of Array, exp_ary
    act_ary = act.to_ary
    assert_kind_of Array, act_ary
    assert_equal exp_ary.size, act_ary.size
    assert_equal (exp_ary.sort_by { |i| i[default_key] }), (act_ary.sort_by { |i| i[default_key] })
  end
end
