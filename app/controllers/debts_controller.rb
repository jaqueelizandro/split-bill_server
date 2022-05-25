class DebtsController < ApplicationController

    def index
        group = Group.find(params[:group_id])
        members = group.members
        transactions = group.transactions
        debt = Hash.new
        credit = Hash.new
        settle = Hash.new

        _total = 0
        transactions.each do |transaction|
            if transaction.kind == 'expense'
                _total += transaction.amount
            end
        end
        _debt = _total / members.size

        members.each do |member|
            _total = 0
            transactions.each do |transaction|
                if member.id == transaction.member_id
                    if transaction.kind == 'expense'
                        _total += transaction.amount
                    end
                end
            end
            if ((_total - _debt) > 0)
                credit[member.name] = (_total - _debt)
            else 
                debt[member.name] = (_total - _debt)
            end
        end

        puts debt
        puts credit
    
        
        
        
        
        
        
        
        
        render json: transactions
    end
end