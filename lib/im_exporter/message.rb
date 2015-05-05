module IM_Exporter
  module Message
    def self.write(user, message, file_name, file_type)
      if file_type.eql? 'PDF'
        $pdf.font("/Library/Fonts/Times New Roman.ttf") do
          $pdf.text "#{user}: #{message}"
        end
      else
        File.open("#{file_name}.txt", 'a') {|f| f.write("#{user}: #{message}\n") }
      end
    end

    def self.read(id)
      return $chat_db.execute("select is_from_me, text, cache_has_attachments, rowid, cache_roomnames from message where handle_id= ?", id)
    end

    def self.parse(message_row, contact_name, file_type)
      if message.is_an_attachment?(message_row[2])
        attachment.write(message_row[3]) if file_type.eql? 'PDF'
      else
        if message.is_from_me?(message_row[0])
          message.write("me", message_row[1], contact_name, file_type)
        else
          message.write(contact_name, message_row[1], contact_name, file_type)
        end
      end if message_row[4].nil?
    end

    def self.is_from_me?(message)
      (message === 1) ? true : false
    end

    def self.is_an_attachment?(message)
      (message === 1) ? true : false
    end
  end
end