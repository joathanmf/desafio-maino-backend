# == Schema Information
#
# Table name: issuers
#
#  id         :bigint           not null, primary key
#  c_mun      :string
#  c_pais     :string
#  cep        :string
#  cnpj       :string           not null
#  crt        :string
#  fone       :string
#  ie         :string
#  nro        :string
#  uf         :string
#  x_bairro   :string
#  x_cpl      :string
#  x_fant     :string
#  x_lgr      :string
#  x_mun      :string
#  x_nome     :string           not null
#  x_pais     :string
#  created_at :datetime         not null
#  updated_at :datetime         not null
#
require 'test_helper'

class IssuerTest < ActiveSupport::TestCase
  # test "the truth" do
  #   assert true
  # end
end
