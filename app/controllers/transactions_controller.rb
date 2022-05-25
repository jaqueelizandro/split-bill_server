class TransactionsController < ApplicationController
        
    def index
        group = Group.find(params[:group_id])
        transactions = group.transactions
        render json: transactions
    end

    def create
        transaction = Transaction.create!(
            kind: params[:kind],
            description: params[:description],
            amount: params[:amount],
            date: params[:date],
            image: params[:image],
            group_id: params[:group_id],
            member_id: params[:member_id]
        )
        group = Group.find(params[:group_id])
        group.transactions << transaction
        transactions = group.transactions
        render json: transactions, status: :created
    end
end
