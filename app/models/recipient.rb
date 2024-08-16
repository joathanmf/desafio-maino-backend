# == Schema Information
#
# Table name: recipients
#
#  id         :bigint           not null, primary key
#  c_mun      :string
#  c_pais     :string
#  cep        :string
#  cnpj       :string           not null
#  ind_ie     :string
#  nro        :string
#  uf         :string
#  x_bairro   :string
#  x_lgr      :string
#  x_mun      :string
#  x_nome     :string           not null
#  x_pais     :string
#  created_at :datetime         not null
#  updated_at :datetime         not null
#
class Recipient < ApplicationRecord
  def self.ransackable_attributes(_auth_object = nil)
    %w[cnpj x_nome x_lgr nro x_bairro c_mun x_mun uf cep c_pais x_pais ind_ie]
  end

  def self.ransackable_associations(_auth_object = nil)
    []
  end
end
