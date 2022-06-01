class DebtsController < ApplicationController

    def index
        group = Group.find(params[:group_id])
        members = group.members
        transactions = group.transactions

        expense_by_member = transactions.group(:member_id).where(kind: :expense).sum(:amount)

        settle_by_member = Transaction.joins(:settle).group(:member_id, :paid_for_id).sum(:amount)

        debt = Debt.new
        result = debt.calculate(expense_by_member, settle_by_member, members)

        render json: result
    end
end