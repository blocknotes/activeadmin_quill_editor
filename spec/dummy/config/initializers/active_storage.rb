Rails.application.reloader.to_prepare do
  ActiveStorage::Attachment.class_eval do
    class << self
      def ransackable_attributes(auth_object = nil)
        %w[blob_id created_at id name record_id record_type]
      end
    end
  end
end
