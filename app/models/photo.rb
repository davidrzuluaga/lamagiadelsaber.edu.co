class Photo < ApplicationRecord
    validates :title, :source, :url, presence: true
end
