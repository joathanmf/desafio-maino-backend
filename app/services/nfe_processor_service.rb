class NfeProcessorService
  def initialize(file_path)
    @file_path = file_path
  end

  def call
    puts "Processing NFE file: #{@file_path}"
    doc = Nokogiri::XML(File.read(@file_path))

    issuer_data = extract_issuer_data(doc)
    recipient_data = extract_recipient_data(doc)
    nfe_data = extract_nfe_data(doc)
    product_data = extract_product_data(doc)
  end

  private

  def extract_issuer_data(doc)
    issuer_data = doc.xpath('//xmlns:emit')
    address_data = issuer_data.xpath('xmlns:enderEmit')

    {
      cnpj: issuer_data.xpath('xmlns:CNPJ').text,
      x_nome: issuer_data.xpath('xmlns:xNome').text,
      x_fant: issuer_data.xpath('xmlns:xFant').text,
      x_lgr: address_data.xpath('xmlns:xLgr').text,
      nro: address_data.xpath('xmlns:nro').text,
      x_cpl: address_data.xpath('xmlns:xCpl').text,
      x_bairro: address_data.xpath('xmlns:xBairro').text,
      c_mun: address_data.xpath('xmlns:cMun').text,
      x_mun: address_data.xpath('xmlns:xMun').text,
      uf: address_data.xpath('xmlns:UF').text,
      cep: address_data.xpath('xmlns:CEP').text,
      c_pais: address_data.xpath('xmlns:cPais').text,
      x_pais: address_data.xpath('xmlns:xPais').text,
      fone: address_data.xpath('xmlns:fone').text,
      ie: issuer_data.xpath('xmlns:IE').text,
      crt: issuer_data.xpath('xmlns:CRT').text
    }
  end

  def extract_recipient_data(doc)
    recipient_data = doc.xpath('//xmlns:dest')
    address_data = recipient_data.xpath('xmlns:enderDest')

    {
      cnpj: recipient_data.xpath('xmlns:CNPJ').text,
      x_nom: recipient_data.xpath('xmlns:xNome').text,
      x_lgr: address_data.xpath('xmlns:xLgr').text,
      nro: address_data.xpath('xmlns:nro').text,
      x_bairro: address_data.xpath('xmlns:xBairro').text,
      c_mun: address_data.xpath('xmlns:cMun').text,
      x_mun: address_data.xpath('xmlns:xMun').text,
      uf: address_data.xpath('xmlns:UF').text,
      cep: address_data.xpath('xmlns:CEP').text,
      c_pais: address_data.xpath('xmlns:cPais').text,
      x_pais: address_data.xpath('xmlns:xPais').text,
      ind_ie: recipient_data.xpath('xmlns:indIEDest').text
    }
  end

  def extract_nfe_data(doc)
    nfe_data = doc.xpath('//xmlns:ide')
    total_data = doc.xpath('//xmlns:total')

    {
      num_serie: nfe_data.xpath('xmlns:serie').text,
      num_nf: nfe_data.xpath('xmlns:nNF').text,
      dh_emi: nfe_data.xpath('xmlns:dhEmi').text,
      v_icms: total_data.xpath('xmlns:ICMSTot/xmlns:vICMS').text,
      v_ipi: total_data.xpath('xmlns:ICMSTot/xmlns:vIPI').text,
      v_pis: total_data.xpath('xmlns:ICMSTot/xmlns:vPIS').text,
      v_cofins: total_data.xpath('xmlns:ICMSTot/xmlns:vCOFINS').text,
      v_total: total_data.xpath('xmlns:ICMSTot/xmlns:vNF').text,
      v_trib: total_data.xpath('xmlns:ICMSTot/xmlns:vTotTrib').text
    }
  end

  def extract_product_data(doc)
    products = []

    doc.xpath('//xmlns:det').each do |product_data|
      data = {
        x_prod: product_data.xpath('xmlns:prod/xmlns:xProd')&.text,
        ncm: product_data.xpath('xmlns:prod/xmlns:NCM')&.text,
        cfop: product_data.xpath('xmlns:prod/xmlns:CFOP')&.text,
        u_com: product_data.xpath('xmlns:prod/xmlns:uCom')&.text,
        q_com: product_data.xpath('xmlns:prod/xmlns:qCom')&.text,
        v_un_com: product_data.xpath('xmlns:prod/xmlns:vUnCom')&.text
      }

      products << data
    end

    products
  end
end
