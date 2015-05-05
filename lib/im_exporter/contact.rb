@user_db = SQLite3::Database.new "/Users/#{Etc.getlogin}/Library/Application Support/AddressBook/AddressBook-v22.abcddb"
@chat_db = SQLite3::Database.new "/Users/#{Etc.getlogin}/Library/Messages/chat.db"

# Export iMessage conversations into TXT or PDF files
module IMExporter
  # A module to handle contact lists from the iMessage sqlite database
  module Contact
    # returns a contact name from a string that includes the contact's name and phone number
    def self.parse_contact_name_from_string(row)
      row.select { |element| row.count(element) > 1 }.uniq.select { |string| string[/[a-zA-Z]/] }.join(' ')
    end

    # returns the name of the contact with the specified ID and Phone number
    def self.name(id, phone)
      name = id
      query = 'select ZSTRINGFORINDEXING from ZABCDCONTACTINDEX'
      @user_db.execute(query) do |contact|
        row = contact.join('').split(' ')
        contact_name = self.parse_contact_name_from_string(row)
        contact_phone = row.last
        if contact_phone.eql? phone then name = contact_name end
      end
      name
    end

    # returns all contact IDs within the iMessage sqlitedb
    def self.contact_ids
      @chat_db.execute('select ROWID, id from handle')
    end
  end
end
