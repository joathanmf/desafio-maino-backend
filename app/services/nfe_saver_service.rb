class NfeSaverService
  def initialize(nfe_data, issuer_data, recipient_data, product_data, file_path, current_user_id)
    @nfe_data = nfe_data
    @issuer_data = issuer_data
    @recipient_data = recipient_data
    @product_data = product_data
    @file_path = file_path
    @current_user_id = current_user_id
  end

  def call
    @current_user = User.find(@current_user_id)

    ActiveRecord::Base.transaction do
      issuer = Issuer.create!(@issuer_data)
      recipient = Recipient.create!(@recipient_data)

      nfe = Nfe.new(@nfe_data.merge(issuer:, recipient:, user: @current_user))
      nfe.xml.attach(io: File.open(@file_path), filename: File.basename(@file_path))
      nfe.save!

      @product_data.each do |product|
        nfe.products.create!(product)
      end
    end
  end
end
