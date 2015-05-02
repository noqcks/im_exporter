# require_relative 'iMPorter/contacts'
# require_relative 'iMPorter/messages'
# require_relative 'iMPorter/attachments'
# ##

# require "iMPorter/version"
# require 'commander/import'
# require 'sqlite3'
# require 'prawn'
# require 'etc'


# $chat_db = SQLite3::Database.new "/Users/#{Etc.getlogin}/Library/Messages/chat.db"
# $user_db = SQLite3::Database.new "/Users/#{Etc.getlogin}/Library/Application Support/AddressBook/AddressBook-v22.abcddb"

# module IMPorter
#   class Contact
#     attr_accessor :id, :name, :phone

#     def initialize(id, phone)
#       @id = id
#       @phone = phone
#       @name = get_contact_name()
#     end

#     def get_contact_name
#       name = @id
#       $user_db.execute('select ZSTRINGFORINDEXING from ZABCDCONTACTINDEX') do |contact|
#         row = contact.join('').split(' ')
#         contact_name = parse_contact_name_from_string(row)
#         contact_phone = row.last
#         if contact_phone.eql? @phone
#           name = contact_name
#         end
#       end
#       return name
#     end

#     def get_messages
#       return $chat_db.execute('select is_from_me, text, cache_has_attachments, rowid from message where handle_id= ? ', @id)
#     end

#     def parse_contact_name_from_string(row)
#       return row.select{|element| row.count(element) > 1 }.uniq.select{ |i| i[/[a-zA-Z]/] }.join(' ')
#     end

#     private :parse_contact_name_from_string
#   end

#   def init_user()
#     $chat_db.execute('select ROWID, id from handle') do |user_row|
#       @pdf = Prawn::Document.new
#       id = user_row[0]
#       phone = user_row[1].delete '+'
#       contact = Contact.new(id, phone)
#       contact.get_messages.each do |message|
#         if is_from_me?(message[0])
#           if has_attachment?(message[2])
#             write_attachment(message[3])
#           else
#             write_message(message[1], "me")
#           end
#         else
#           if has_attachment?(message[2])
#             write_attachment(message[3])
#           else
#             write_message(message[1], contact.name)
#           end
#         end
#       end
#       p contact.name
#       @pdf.render_file "#{contact.name}.pdf"
#     end
#   end

#   def write_attachment(message)
#     $chat_db.execute('select a.filename from attachment as a join message as m on m.date = a.created_date where m.rowid=?', message) do |file_dir|
#       file = file_dir.join('').sub!('~', '/Users/benvisser')
#       if supported_file_type?(file)
#         @pdf.image file, :height => 250
#       else
#         @pdf.text "[IMAGE-TYPE NOT SUPPORTED]"
#       end
#     end
#   end

#   def write_message(message, usr)
#     @pdf.font("/Library/Fonts/Times New Roman.ttf") do
#       @pdf.text "#{usr}: #{message}"
#     end
#   end

#   def is_from_me?(message)
#     (message === 1) ? true : false
#   end

#   def has_attachment?(message)
#     (message[2] === 1) ? true : false
#   end

#   def supported_file_type?(file)
#     return (file.include? "JPG" or file.include? "PNG") ? true : false
#   end
# end