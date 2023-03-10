class Product < ApplicationRecord
    validates :name, :description, :price, presence: true
    has_many_attached :images
end
