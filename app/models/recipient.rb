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
end
