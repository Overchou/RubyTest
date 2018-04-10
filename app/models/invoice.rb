class Invoice < ApplicationRecord
  validates :rent, presence: true,
                    numericality: { greater_than: 50 }
end
