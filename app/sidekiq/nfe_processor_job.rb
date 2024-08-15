class NfeProcessorJob
  include Sidekiq::Job

  def perform(file_path)
    issuer_data, recipient_data, nfe_data, product_data = NfeProcessorService.new(file_path).call

    NfeSaverService.new(nfe_data, issuer_data, recipient_data, product_data, file_path).call

    File.delete(file_path) if File.exist?(file_path)
  end
end
