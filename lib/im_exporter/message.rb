# Export iMessage conversations into TXT or PDF files
module IMExporter
  # A module to handle messages from the iMessage sqlite database
  module Message
    # writes the iMessage to a PDF or TXT document
    def self.write(user, message, file_name, file_type)
      if file_type.eql? 'PDF'
        $pdf.font('/Library/Fonts/Times New Roman.ttf') do
          $pdf.text "#{user}: #{message}"
        end
      else
        File.open("#{file_name}.txt", 'a') { |file| file.write("#{user}: #{message}\n") }
      end
    end

    # gets metadata about each iMessage
    def self.read(id)
      select_rows = 'is_from_me, text, cache_has_attachments, rowid, cache_roomnames'
      query = "select #{select_rows} from message where handle_id= ?"
      $chat_db.execute(query, id)
    end

    # the logic behind how things get written to the document
    def self.write_logic(message_row, contact_name, file_type)
      if self.is_an_attachment?(message_row[2])
        IMExporter::Attachment.write(message_row[3]) if file_type.eql? 'PDF'
      else
        if self.is_from_me?(message_row[0])
          write('me', message_row[1], contact_name, file_type)
        else
          write(contact_name, message_row[1], contact_name, file_type)
        end
      end if message_row[4].nil?
    end

    # checks whether an iMessage is from yourself
    def self.is_from_me?(message)
      if message.eql? 1 then true else false end
    end

    # checks whether the iMessage is actually an attachment (image)
    def self.is_an_attachment?(message)
      if message.eql? 1 then true else false end
    end
  end
end
