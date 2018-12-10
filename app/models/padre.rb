class Padre < ApplicationRecord
    validates :title, :body, :category, :imgcover, presence: true
end
