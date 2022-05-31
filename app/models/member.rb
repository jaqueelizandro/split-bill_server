class Member < ApplicationRecord
    belongs_to :group
    has_many :transactions, dependent: :destroy
end
