module IM_Porter
  module Attachment
    def self.write(attachment_id)
      $chat_db.execute('select a.filename from attachment as a join message as m on m.date = a.created_date where m.rowid=?', attachment_id) do |file_dir|
        file = file_dir.join('').sub!('~', '/Users/benvisser')
        if self.supported_file_type?(file)
          $pdf.image file, :height => 250
        else
          $pdf.text "[IMAGE-TYPE NOT SUPPORTED]"
        end
      end
    end

    def self.supported_file_type?(file)
      (file.include? "JPG" or file.include? "PNG") ? true : false
    end
  end
end
