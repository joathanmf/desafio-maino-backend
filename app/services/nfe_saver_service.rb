class NfeSaverService
  def initialize(nfe_data, issuer_data, recipient_data, product_data, file_path)
    @nfe_data = nfe_data
    @issuer_data = issuer_data
    @recipient_data = recipient_data
    @product_data = product_data
    @file_path = file_path
  end

  def call
    ActiveRecord::Base.transaction do
      issuer = Issuer.create!(@issuer_data)
      recipient = Recipient.create!(@recipient_data)

      nfe = Nfe.new(@nfe_data.merge(issuer:, recipient:))
      nfe.xml.attach(io: File.open(@file_path), filename: File.basename(@file_path))
      nfe.save!

      @product_data.each do |product|
        nfe.products.create!(product)
      end
    end
  end
end
