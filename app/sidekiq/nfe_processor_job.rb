class NfeProcessorJob
  include Sidekiq::Job

  sidekiq_options retry: false

  def perform(file_path, current_user_id)
    issuer_data, recipient_data, nfe_data, product_data = NfeProcessorService.new(file_path).call

    NfeSaverService.new(nfe_data, issuer_data, recipient_data, product_data, file_path, current_user_id).call

    File.delete(file_path) if File.exist?(file_path)
  end
end
