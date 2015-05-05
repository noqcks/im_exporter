@chat_db = SQLite3::Database.new "/Users/#{Etc.getlogin}/Library/Messages/chat.db"

# Export iMessage conversations into TXT or PDF files
module IMExporter
  # A module to handle attachments from the iMessage sqlite database
  module Attachment
    # writes attachments (images) out to a PDF or TXT file
    def self.write(attachment_id)
      query = 'select a.filename from attachment as a join message as m on m.date = a.created_date where m.rowid=?'
      @chat_db.execute(query, attachment_id) do |file_dir|
        file = file_dir.join('').sub!('~', '/Users/benvisser')
        if self.supported_file_type?(file)
          $pdf.image file, height: 250
        else
          $pdf.text '[IMAGE-TYPE NOT SUPPORTED]'
        end
      end
    end

    # checks whether the attachment is supported by prawn
    def self.supported_file_type?(file)
      if file.include?('JPG') || file.include?('PNG') then true else false end
    end
  end
end
