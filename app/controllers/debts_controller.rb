class DebtsController < ApplicationController

    def index
        group = Group.find(params[:group_id])
        members = group.members
        transactions = group.transactions

        # # trans_amount_by_member = transactions.group(:member_id).sum('case when "transactions"."kind" = 0 then "transactions"."amount" else "transactions"."amount" * -1 end')
        # income_by_member = transactions.group(:member_id).where(kind: :income).sum(:amount)
        # expense_group = transactions.where(kind: :expense).sum(:amount)
        # total_member = expense_group / members.length
        # trans_amount_by_member = transactions.group(:member_id, :kind).sum(:amount)
        # # {[38, "expense"]=>30, [38, "income"]=>10, [39, "expense"]=>154, [39, "settle"]=>10}

        expense_by_member = transactions.group(:member_id).where(kind: :expense).sum(:amount)
        # {38=>30, 39=>154}

        settle_by_member = Transaction.joins(:settle).group(:member_id, :paid_for_id).sum(:amount)

        debt = Debt.new
        result = debt.calculate(expense_by_member, settle_by_member, members)

        render json: result
    end
end