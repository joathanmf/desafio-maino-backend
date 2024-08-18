class XlsxGeneratorService
  def initialize(nfe)
    @nfe = nfe
  end

  def call
    Axlsx::Package.new do |p|
      p.workbook.add_worksheet(name: 'Nota Fiscal Eletrônica') do |sheet|
        super_title_style = sheet.styles.add_style(b: true, alignment: { horizontal: :center })
        title_style = sheet.styles.add_style(b: true, bg_color: 'CEE7CE', alignment: { horizontal: :center })
        value_style = sheet.styles.add_style(alignment: { horizontal: :center })

        sheet.add_row ['DADOS DA NOTA FISCAL ELETRÔNICA'], style: super_title_style
        sheet.add_row []

        sheet.add_row ['EMITENTE'], style: super_title_style
        sheet.add_row [
                        'CNPJ', 'Razão Social', 'Nome Fantasia', 'Logradouro', 'Número',
                        'Complemento', 'Bairro', 'Código do Município', 'Município', 'UF',
                        'CEP', 'Código do País', 'País', 'Telefone', 'Inscrição Estadual', 'CRT'
                      ], style: title_style

        sheet.add_row [
                        format_cnpj(@nfe.issuer.cnpj), @nfe.issuer.x_nome, @nfe.issuer.x_fant,
                        @nfe.issuer.x_lgr, @nfe.issuer.nro, @nfe.issuer.x_cpl, @nfe.issuer.x_bairro,
                        @nfe.issuer.c_mun, @nfe.issuer.x_mun, @nfe.issuer.uf, format_cep(@nfe.issuer.cep),
                        @nfe.issuer.c_pais, @nfe.issuer.x_pais, @nfe.issuer.fone,
                        @nfe.issuer.ie, @nfe.issuer.crt
                      ], style: value_style

        sheet.add_row []

        sheet.add_row ['DESTINATÁRIO'], style: super_title_style
        sheet.add_row [
                        'CNPJ', 'Razão Social', 'Logradouro', 'Número', 'Bairro',
                        'Código do Município', 'Município', 'UF', 'CEP',
                        'Código do País', 'País', 'Indicador da IE'
                      ], style: title_style

        sheet.add_row [
                        format_cnpj(@nfe.recipient.cnpj), @nfe.recipient.x_nome, @nfe.recipient.x_lgr,
                        @nfe.recipient.nro, @nfe.recipient.x_bairro, @nfe.recipient.c_mun,
                        @nfe.recipient.x_mun, @nfe.recipient.uf, format_cep(@nfe.recipient.cep),
                        @nfe.recipient.c_pais, @nfe.recipient.x_pais, @nfe.recipient.ind_ie
                      ], style: value_style

        sheet.add_row []

        sheet.add_row ['DADOS DA NOTA FISCAL'], style: super_title_style
        sheet.add_row [
                        'Número da NFe', 'Série', 'Data e Hora de Emissão',
                        'Valor do ICMS', 'Valor do IPI', 'Valor do PIS',
                        'Valor do COFINS', 'Valor Total', 'Tributação Total'
                      ], style: title_style

        sheet.add_row [
                        @nfe.num_nf, @nfe.num_serie, format_date(@nfe.dh_emi),
                        format_currency(@nfe.v_icms), format_currency(@nfe.v_ipi), format_currency(@nfe.v_pis),
                        format_currency(@nfe.v_cofins), format_currency(@nfe.v_total), format_currency(@nfe.v_trib)
                      ], style: value_style

        sheet.add_row []

        sheet.add_row ['PRODUTOS'], style: super_title_style
        sheet.add_row(
          ['DESCRIÇÃO', 'NCM', 'CFOP', 'UNIDADE COMERCIALIZADA', 'QUANTIDADE', 'VALOR UNITÁRIO'],
          style: title_style
        )
        @nfe.products.each do |pd|
          sheet.add_row(
            [pd.x_prod, pd.ncm, pd.cfop, pd.u_com, pd.q_com, format_currency(pd.v_un_com)],
            style: value_style)
        end
      end

      return p.to_stream.read
    end
  end

  private

  def format_cnpj(cnpj)
    cnpj.to_s.gsub(/(\d{2})(\d{3})(\d{3})(\d{4})(\d{2})/, '\\1.\\2.\\3/\\4-\\5')
  rescue StandardError
    cnpj
  end

  def format_cep(cep)
    cep.to_s.gsub(/(\d{5})(\d{3})/, '\\1-\\2')
  rescue StandardError
    cep
  end

  def format_date(date)
    date.strftime('%d/%m/%Y %H:%M:%S')
  rescue StandardError
    date
  end

  def format_currency(value)
    sprintf('R$ %.2f', value.to_f)
  rescue StandardError
    value
  end
end
