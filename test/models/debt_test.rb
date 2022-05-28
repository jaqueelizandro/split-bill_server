class Debts < ActiveSupport::TestCase
  test "calculate one person paid for one bill and no one paid back" do 
    debt = Debt.new
    result = debt.calculate({38=>30}, {}, [{"id": 39}, {"id": 38}, {"id": 46}])
    expected = [{"settle": {"id": 39}, "income": {"id": 38}, "amount": 10},
                {"settle": {"id": 46}, "income": {"id": 38}, "amount": 10}]
    assert_equal(expected, result)
  end

  test "calculate two people paid for bills and no one paid back" do 
    debt = Debt.new
    result = debt.calculate({38=>30, 46=>60}, {}, [{"id": 39}, {"id": 38}, {"id": 46}])
    expected = [{"settle": {"id": 39}, "income": {"id": 38}, "amount": 10},
                {"settle": {"id": 46}, "income": {"id": 38}, "amount": 10},
                {"settle": {"id": 39}, "income": {"id": 46}, "amount": 20},
                {"settle": {"id": 38}, "income": {"id": 46}, "amount": 20}]
    assert_equal(expected, result)
  end

  test "calculate one person paid for bill and one paid back" do 
    debt = Debt.new
    result = debt.calculate({38=>30}, {[39, 38]=>10}, [{"id": 39}, {"id": 38}, {"id": 46}])
    expected = [{"settle": {"id": 46}, "income": {"id": 38}, "amount": 10}]
    assert_equal(expected, result)
  end

  test "calculate one person paid for bill and one paid back partial" do 
    debt = Debt.new
    result = debt.calculate({38=>30}, {[39, 38]=>5}, [{"id": 39}, {"id": 38}, {"id": 46}])
    expected = [{"settle": {"id": 46}, "income": {"id": 38}, "amount": 10},
                {"settle": {"id": 39}, "income": {"id": 38}, "amount": 5}]
    assert_equal(expected.sort{ |a, b| a[:settle] <=> b[:settle] }, result.sort{ |a, b| a[:settle] <=> b[:settle] })
  end

  test "calculate two people paid for bills and one paid back" do 
    debt = Debt.new
    result = debt.calculate({38=>30, 46=>60}, {[39, 38]=>10}, [{"id": 39}, {"id": 38}, {"id": 46}])
    expected = [{"settle": {"id": 46}, "income": {"id": 38}, "amount": 10},
                {"settle": {"id": 39}, "income": {"id": 46}, "amount": 20},
                {"settle": {"id": 38}, "income": {"id": 46}, "amount": 20}]
    assert_equal(expected.sort{ |a, b| a[:settle] <=> b[:settle] }, result.sort{ |a, b| a[:settle] <=> b[:settle] })
  end

  test "calculate two people paid for bills and two paid back" do 
    debt = Debt.new
    result = debt.calculate({38=>30, 46=>60}, {[39, 38]=>10, [39, 46]=>15}, [{"id": 39}, {"id": 38}, {"id": 46}])
    expected = [{"settle": {"id": 46}, "income": {"id": 38}, "amount": 10},
                {"settle": {"id": 39}, "income": {"id": 46}, "amount": 5},
                {"settle": {"id": 38}, "income": {"id": 46}, "amount": 20}]
    assert_equal(expected.sort{ |a, b| a[:settle] <=> b[:settle] }, result.sort{ |a, b| a[:settle] <=> b[:settle] })
  end
end


