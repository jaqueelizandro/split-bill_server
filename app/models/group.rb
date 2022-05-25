class Group < ApplicationRecord
    has_many :members
    has_many :transactions
end
