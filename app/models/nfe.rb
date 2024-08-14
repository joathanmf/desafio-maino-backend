class Nfe < ApplicationRecord
  self.table_name = 'nfes'

  has_one_attached :xml

  belongs_to :issuer
  belongs_to :recipient

  has_many :products
end
