class NfeProcessorJob
  include Sidekiq::Job

  def perform(file_path)
    NfeProcessorService.new(file_path).call

    # File.delete(file_path) if File.exist?(file_path)
  end
end
