class Transaction < ApplicationRecord
    belongs_to :group
    belongs_to :member

    # validates :member_id, presence: true
    
    enum kind: { expense: 0, transfer: 1, income: 2 }
end
