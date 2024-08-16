# frozen_string_literal: true

module ApplicationHelper
  # Função que
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
