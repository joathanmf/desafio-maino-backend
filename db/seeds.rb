require 'faker'

emitente = Emitente.create!(
  cnpj: Faker::Company.brazilian_company_number,
  x_nome: Faker::Company.name,
  x_fant: Faker::Company.name,
  x_lgr: Faker::Address.street_name,
  nro: Faker::Address.building_number,
  x_cpl: Faker::Address.secondary_address,
  x_bairro: Faker::Address.community,
  c_mun: Faker::Address.zip_code,
  x_mun: Faker::Address.city,
  uf: Faker::Address.state_abbr,
  cep: Faker::Address.zip_code,
  c_pais: '1058',
  x_pais: 'BRASIL',
  fone: Faker::PhoneNumber.phone_number,
  ie: Faker::Company.suffix,
  crt: Faker::Number.between(from: 1, to: 3).to_s
)

destinatario = Destinatario.create!(
  cnpj: Faker::Company.brazilian_company_number,
  x_nome: Faker::Company.name,
  x_lgr: Faker::Address.street_name,
  nro: Faker::Address.building_number,
  x_bairro: Faker::Address.community,
  c_mun: Faker::Address.zip_code,
  x_mun: Faker::Address.city,
  uf: Faker::Address.state_abbr,
  cep: Faker::Address.zip_code,
  c_pais: '1058',
  x_pais: 'BRASIL',
  ind_ie: Faker::Number.between(from: 1, to: 2).to_s
)

nota = NotaFiscal.create!(
  num_serie: Faker::Number.unique.number(digits: 5),
  num_nf: Faker::Number.unique.number(digits: 8),
  dh_emi: Faker::Time.between(from: DateTime.now - 1, to: DateTime.now),
  emitente:,
  destinatario:,
  v_icms: Faker::Commerce.price(range: 0..100.0),
  v_ipi: Faker::Commerce.price(range: 0..100.0),
  v_pis: Faker::Commerce.price(range: 0..100.0),
  v_cofins: Faker::Commerce.price(range: 0..100.0)
)

5.times do
  Produto.create!(
    x_prod: Faker::Commerce.product_name,
    ncm: Faker::Number.unique.number(digits: 8),
    cfop: Faker::Number.number(digits: 4),
    u_com: Faker::Commerce.promotion_code,
    q_com: Faker::Number.decimal(l_digits: 2),
    v_un_com: Faker::Commerce.price(range: 60..100.0),
    nota_fiscal: nota
  )
end
