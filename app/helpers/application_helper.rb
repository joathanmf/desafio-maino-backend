# frozen_string_literal: true

module ApplicationHelper
  include Pagy::Frontend

  def active_link?(controllers:, actions:)
    current_controller = controller_name
    current_action = action_name
    controllers.include?(current_controller) && actions.include?(current_action)
  end

  def currency_br(number)
    number_to_currency(number, unit: 'R$ ', separator: ',', delimiter: '.')
  end

  def format_cnpj(cnpj)
    return cnpj unless cnpj.present?

    cnpj = cnpj.gsub(/[^0-9a-zA-Z]/, '')

    if valid_old_cnpj?(cnpj) || valid_new_cnpj?(cnpj)
      "#{cnpj[0..1]}.#{cnpj[2..5]}.#{cnpj[6..8]}/#{cnpj[9..12]}-#{cnpj[13..14]}"
    else
      cnpj
    end
  end

  def format_cep(cep)
    return cep unless cep.present?

    cep = cep.gsub(/\D/, '')

    if cep.length == 8
      "#{cep[0..4]}-#{cep[5..7]}"
    else
      cep
    end
  end

  def search_fields
    fields = %w[
      issuer_x_nome
      issuer_cnpj
      issuer_x_fant
      issuer_x_lgr
      issuer_nro
      issuer_x_cpl
      issuer_x_bairro
      issuer_c_mun
      issuer_x_mun
      issuer_uf
      issuer_cep
      issuer_c_pais
      issuer_x_pais
      issuer_fone
      issuer_ie
      issuer_crt
      recipient_x_nome
      recipient_cnpj
      recipient_x_lgr
      recipient_nro
      recipient_x_bairro
      recipient_c_mun
      recipient_x_mun
      recipient_uf
      recipient_cep
      recipient_c_pais
      recipient_x_pais
      recipient_ind_ie
      num_serie
      num_nf
      v_icms
      v_ipi
      v_pis
      v_cofins
      v_total
      v_trib
    ]

    "#{fields.join('_or_')}_i_cont"
  end

  private

  def valid_old_cnpj?(cnpj)
    return false unless cnpj.length == 14

    true
  end

  def valid_new_cnpj?(cnpj)
    return false unless cnpj.length == 14

    true
  end
end
