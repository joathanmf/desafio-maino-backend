class ReportsController < ApplicationController
  def index
    @query = Nfe.where(user: current_user).joins(:issuer, :recipient).ransack(params[:q])

    # Aplicando condições de filtro com base nos parâmetros
    @nfes = if params[:cnpj].present? || params[:x_nome].present? || params[:x_mun].present?
              apply_filters(@query.result, params)
            else
              @query.result
            end

    @pagy, @nfes = pagy(@nfes)

    # Coletando valores únicos para os filtros
    @cnpjs = (Issuer.distinct.pluck(:cnpj) + Recipient.distinct.pluck(:cnpj)).uniq
    @x_nomes = (Issuer.distinct.pluck(:x_nome) + Recipient.distinct.pluck(:x_nome)).uniq
    @x_muns = (Issuer.distinct.pluck(:x_mun) + Recipient.distinct.pluck(:x_mun)).uniq
  end

  def show
    @nfe = Nfe.find_by(id: params[:id])
    @issuer = @nfe.issuer
    @recipient = @nfe.recipient
  end

  def destroy
    nfe = Nfe.find_by(id: params[:id])

    nfe.destroy
  end

  def xml_download
    nfe = Nfe.find_by(id: params[:id])

    flash[:alert] = I18n.t('notices.alert.file_not_found') unless nfe.xml.attached?

    send_data(
      nfe.xml.download,
      filename: "NFe_#{nfe.num_nf}_#{nfe.created_at.to_s.gsub(' UTC', '')}.xml",
      type: nfe.xml.content_type
    )
  end

  private

  def apply_filters(query, params)
    conditions = []
    values = {}

    if params[:cnpj].present?
      conditions << '(issuers.cnpj = :cnpj OR recipients.cnpj = :cnpj)'
      values[:cnpj] = params[:cnpj]
    end

    if params[:x_nome].present?
      conditions << '(issuers.x_nome = :x_nome OR recipients.x_nome = :x_nome)'
      values[:x_nome] = params[:x_nome]
    end

    if params[:x_mun].present?
      conditions << '(issuers.x_mun = :x_mun OR recipients.x_mun = :x_mun)'
      values[:x_mun] = params[:x_mun]
    end

    query = query.where(conditions.join(' AND '), values) if conditions.any?

    query
  end
end
