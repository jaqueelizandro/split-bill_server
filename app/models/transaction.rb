class Transaction < ApplicationRecord
    belongs_to :group
    belongs_to :member
    has_one :settle

    # validates :kind, :amount, :date, :group_id, :member_id, presence: true
    
    enum kind: { expense: 0, settle: 1, income: 2 }
end
