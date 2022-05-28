class Debt
    def calculate(expenses, settle, members)
        how_much_each_member_has_to_pay = [];
        expenses.each do |key, value|
            total_member = value / members.length
            members.each do |member|
                if member[:id] != key
                    how_much_each_member_has_to_pay.push({
                        settle: member,
                        income: members.find {|m| m[:id] == key},
                        amount: total_member
                    })
                end
            end
        end

        if settle.empty?
            return how_much_each_member_has_to_pay
        end

        how_much_each_member_has_to_pay_discounted = []
        how_much_each_member_has_to_pay.each do |each_member|
            found = false

            settle.each do |key, value|
                if key[0] == each_member[:settle] && key[1] == each_member[:income]
                    found = true
                    remain_value = each_member[:amount] - value
                    if remain_value > 0
                        how_much_each_member_has_to_pay_discounted.push({
                            settle: key[0],
                            income: each_member[:income],
                            amount: remain_value
                        })
                    end
                    break;
                end
            end

            if !found 
                how_much_each_member_has_to_pay_discounted.push({
                    settle: each_member[:settle],
                    income: each_member[:income],
                    amount: each_member[:amount]
                })
            end
        end
        return how_much_each_member_has_to_pay_discounted
    end
end
