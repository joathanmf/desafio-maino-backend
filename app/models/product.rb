# == Schema Information
#
# Table name: products
#
#  id         :bigint           not null, primary key
#  cfop       :string
#  ncm        :string
#  q_com      :integer
#  u_com      :string
#  v_un_com   :decimal(10, 2)
#  x_prod     :string
#  created_at :datetime         not null
#  updated_at :datetime         not null
#  nfe_id     :bigint           not null
#
# Indexes
#
#  index_products_on_nfe_id  (nfe_id)
#
# Foreign Keys
#
#  fk_rails_...  (nfe_id => nfes.id)
#
class Product < ApplicationRecord
  belongs_to :nfe
end
