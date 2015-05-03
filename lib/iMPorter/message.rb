module IMPorter
  module Message
    def self.write(user, message)
      $pdf.font("/Library/Fonts/Times New Roman.ttf") do
        $pdf.text "#{user}: #{message}"
      end
    end

    def self.read(id)
      return $chat_db.execute('select is_from_me, text, cache_has_attachments, rowid from message where handle_id= ? ', id)
    end

    def self.is_from_me?(message)
      (message === 1) ? true : false
    end

    def self.is_an_attachment?(message)
      (message === 1) ? true : false
    end
  end
end
