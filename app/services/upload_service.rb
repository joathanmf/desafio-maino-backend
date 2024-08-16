require 'zip'

class UploadService
  ALLOWED_EXTENSIONS = %w[xml zip].freeze

  def initialize(uploaded_file, current_user_id)
    @uploaded_file = uploaded_file
    @current_user_id = current_user_id
  end

  def call
    validate_file
    process_file
  end

  private

  def validate_file
    extension = File.extname(@uploaded_file.original_filename).delete('.').downcase

    return if ALLOWED_EXTENSIONS.include?(extension)

    raise ArgumentError, I18n.t('notices.alert.invalid_file')
  end

  def process_file
    extension = File.extname(@uploaded_file.original_filename).delete('.').downcase

    if extension == 'zip'
      process_zip_file
    elsif extension == 'xml'
      enqueue_processing_job(@uploaded_file.read, @uploaded_file.original_filename)
    end
  end

  def process_zip_file
    Zip::File.open_buffer(@uploaded_file.read) do |zip_file|
      zip_file.each do |entry|
        next unless File.extname(entry.name).downcase == '.xml'

        content = entry.get_input_stream.read
        enqueue_processing_job(content, entry.name)
      end
    end
  end

  def enqueue_processing_job(file_content, filename)
    NfeProcessorJob.perform_async(file_content, filename, @current_user_id)
  end
end
