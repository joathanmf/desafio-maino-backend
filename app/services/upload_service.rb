class UploadService
  def initialize(uploaded_file)
    @uploaded_file = uploaded_file
  end

  def call
    temp_file_path = save_to_tempfile
    enqueue_processing_job(temp_file_path)
  end

  private

  def save_to_tempfile
    temp_file_path = Rails.root.join('tmp', @uploaded_file.original_filename)

    File.open(temp_file_path, 'wb') do |file|
      file.write(@uploaded_file.read)
    end

    temp_file_path
  end

  def enqueue_processing_job(temp_file_path)
    NfeProcessorJob.perform_async(temp_file_path.to_s)
  end
end
