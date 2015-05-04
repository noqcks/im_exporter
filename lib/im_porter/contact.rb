module IM_Porter
  module Contact
    def self.parse_contact_name_from_string(row)
      return row.select{|element| row.count(element) > 1 }.uniq.select{ |i| i[/[a-zA-Z]/] }.join(' ')
    end

    def self.name(id, phone)
      name = id
      $user_db.execute('select ZSTRINGFORINDEXING from ZABCDCONTACTINDEX') do |contact|
        row = contact.join('').split(' ')
        contact_name = self.parse_contact_name_from_string(row)
        contact_phone = row.last
        if contact_phone.eql? phone
          name = contact_name
        end
      end
      return name
    end

    def self.get_contact_ids
      return $chat_db.execute('select ROWID, id from handle')
    end
  end
end
