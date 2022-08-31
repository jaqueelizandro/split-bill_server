class TransactionsController < ApplicationController
        
    def index
        group = Group.find(params[:group_id])
        transactions = group.transactions
        settle = transactions.settle
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

                trans_income = Transaction.create!(
                    kind: 'income',
                    description: params[:description],
                    amount: params[:amount],
                    date: params[:date],
                    image: params[:image],
                    group_id: params[:group_id],
                    member_id: params[:paid_for]
                )

                settle = Settle.create!(
                    paid_for_id: params[:paid_for],
                    transaction_id: trans_settle.id,
                    income_id: trans_income.id
                )
            end

            head :created
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
            transactions = group.transactions

            render json: transactions, status: :created
        end
    end

    def update
        group = Group.find(params[:group_id])
        transaction = group.transactions.find(params[:id])
        transaction.update!(
            kind: params[:kind],
            description: params[:description],
            amount: params[:amount],
            date: params[:date],
            image: params[:image],
            group_id: params[:group_id],
            member_id: params[:member_id]
        )

        render json: transaction, status: :created
    end

    def destroy
        group = Group.find(params[:group_id])
        transaction = group.transactions.find(params[:id])
        if params[:kind] == 'income'
            ActiveRecord::Base.transaction do
                settle = Settle.find_by income_id: transaction
                trans_settle = group.transactions.find_by id: settle.transaction_id 

                settle.destroy!
                transaction.destroy!
                trans_settle.destroy!
            end
        elsif params[:kind] == 'settle'
            ActiveRecord::Base.transaction do
                settle = Settle.find_by income_id: transaction
                trans_income = group.transactions.find_by id: settle.transaction_id 

                settle.destroy!
                transaction.destroy!
                trans_income.destroy!
            end
        else
            transaction.destroy!
        end

        head :no_content
    end

end
