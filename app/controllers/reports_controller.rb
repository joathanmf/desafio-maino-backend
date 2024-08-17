class ReportsController < ApplicationController
  def index
    @query = Nfe.where(user: current_user).joins(:issuer, :recipient).ransack(params[:q])
    @nfes = @query.result

    if params[:cnpj].present?
      @nfes = @nfes.where(issuers: { cnpj: params[:cnpj] }).or(@nfes.where(recipients: { cnpj: params[:cnpj] }))
    end

    if params[:x_nome].present?
      @nfes = @nfes.where(issuers: { x_nome: params[:x_nome] }).or(@nfes.where(recipients: { x_nome: params[:x_nome] }))
    end

    if params[:x_mun].present?
      @nfes = @nfes.where(issuers: { x_mun: params[:x_mun] }).or(@nfes.where(recipients: { x_mun: params[:x_mun] }))
    end

    @cnpjs = Issuer.distinct.pluck(:cnpj) + Recipient.distinct.pluck(:cnpj)
    @x_nomes = Issuer.distinct.pluck(:x_nome) + Recipient.distinct.pluck(:x_nome)
    @x_muns = Issuer.distinct.pluck(:x_mun) + Recipient.distinct.pluck(:x_mun)
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
end
