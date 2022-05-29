class TransactionsController < ApplicationController
        
    def index
        group = Group.find(params[:group_id])
        transactions = group.transactions
        render json: transactions
    end

    def create
        if params[:kind] == 'settle'
            ActiveRecord::Base.transaction do
                trans_settle = Transaction.create!(
                    kind: 'settle',
                    description: params[:description],
                    amount: params[:amount],
                    date: params[:date],
                    image: params[:image],
                    group_id: params[:group_id],
                    member_id: params[:who_paid]
                )
                group = Group.find(params[:group_id])
                group.transactions << trans_settle

                settle = Settle.create!(
                    paid_for_id: params[:paid_for],
                    transaction_id: trans_settle.id
                )

                trans_income = Transaction.create!(
                    kind: 'income',
                    description: params[:description],
                    amount: params[:amount],
                    date: params[:date],
                    image: params[:image],
                    group_id: params[:group_id],
                    member_id: params[:paid_for]
                )
                group = Group.find(params[:group_id])
                group.transactions << trans_income

            end
            # render json: [trans_expense, trans_income], status: :created
            # respond_to do |format|
            #     format.json  { render :json => {:trans_expense => trans_expense, 
            #                                     :trans_income => trans_income }}
            #   end
        else
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
end
