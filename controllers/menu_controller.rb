require_relative '../models/address_book'

class MenuController
    attr_reader :address_book
    
    def initialize
        @address_book = AddressBook.new
    end
    
    def main_menu
        puts "Main Menu - #{address_book.entries.count} entries"
        puts "1 - View all entries"
        puts "2 - Create an entry"
        puts "3 - View Entry Number n"
        puts "4 - Search for an entry"
        puts "5 - Import entries from a CSV"
        puts "6 - Nuke the address book"
        puts "7 - Exit"
        print "Enter your selection: "
        
        selection = gets.to_i
        case selection
            when 1
                system "clear"
                view_all_entries
                main_menu
            when 2
                system "clear"
                create_entry
                main_menu
            when 3
                system "clear"
                view_entry_number
                main_menu
            when 4
                system "clear"
                search_entries
                main_menu
            when 5
                system "clear"
                read_csv
                main_menu
            when 6
                system "clear"
                nuke
                main_menu
            when 7
                puts "Goodbye!"
                exit(0)
            else
                system "clear"
                puts "Sorry, that is not a valid input."
                main_menu
        end
    end
    
    def view_all_entries
        address_book.entries.each do |entry|
            system "clear"
            puts entry.to_s
            entry_submenu(entry)
        end
        
        system "clear"
        puts "End of entries"
    end
    
    def create_entry
        system "clear"
        puts "New AddressBook Entry"
        print "Name: "
        name = gets.chomp
        print "Phone number: "
        phone = gets.chomp
        print "Email: "
        email = gets.chomp
        
        address_book.add_entry(name, phone, email)
        
        system "clear"
        puts "New entry created"
    end
    
    def view_entry_number
        system "clear"
        puts "There are #{address_book.entries.count} entries. Enter the number of the entry you want to see."
        print "Enter your selection: "
        
        num = gets.to_i
        address_book.entries.each_with_index do |entry, index|
            if num == index + 1
                system "clear"
                puts entry
                entry_submenu(entry)
            else
                puts "Sorry, that's not a valid entry. Please enter a number up to #{address_book.entries.count}."
                main_menu
            end
        end
    end
    
    def search_entries
        print "Search by name: "
        name = gets.chomp
        match = address_book.binary_search(name)
        system "clear"
        if match
            puts match.to_s
            search_submenu(match)
        else
            puts "No match found for #{name}!"
        end
    end
    
    def read_csv
        print "Enter CSV file to import: "
        file_name = gets.chomp
        
        if file_name.empty?
            system "clear"
            puts "No CSV file read"
            main_menu
        end
        
        begin
            entry_count = address_book.import_from_csv(file_name).count
            system "clear"
            puts "#{entry_count} new entries added from #{file_name}"
        rescue
            puts "#{file_name} is not a valid CSV file. Please enter the name of a valid CSV file."
            read_csv
        end
    end
    
    def nuke
        print "Are you sure you want to delete ALL entries? (Y/N) "
        nuke_order = gets.chomp
        
        if nuke_order == "Y" || nuke_order == "y"
            address_book.entries.clear
            puts "The address book is now empty." if address_book.entries.empty?
            main_menu
        elsif nuke_order == "N" || nuke_order == "n"
            puts "Whew! That was a close one."
            main_menu
        else
            "#{nuke_order} is not a valid input."
            main_menu
        end
    end
    
    def entry_submenu(entry)
        puts "n - next entry"
        puts "d - delete entry"
        puts "e - edit this entry"
        puts "m - return to main menu"
        
        selection = gets.chomp
        
        case selection
            when "n"
            when "d"
                delete_entry(entry)
            when "e"
                edit_entry(entry)
                entry_submenu(entry)
            when "m"
                system "clear"
                main_menu
            else
                system "clear"
                puts "#{selection} is not a valid input."
                entry_submenu(entry)
        end
    end
    
    def search_submenu(entry)
        puts "\nd - delete entry"
        puts "e - edit this entry"
        puts "m - return to main menu"
        selection = gets.chomp
        
        case selection
            when "d"
                system "clear"
                delete_entry(entry)
                main_menu
            when "e"
                edit_entry(entry)
                system "clear"
                main_menu
            when "m"
                system "clear"
                main_menu
            else
                system "clear"
                puts "#{selection} is not a valid input."
                puts entry.to_s
                search_submenu(entry)
        end
    end
    
    def edit_entry(entry)
        print "Updated name: "
        name = gets.chomp
        print "Updated phone number: "
        phone_number = gets.chomp
        print "Updated email address: "
        email = gets.chomp
        entry.name = name if !name.empty?
        entry.phone_number = phone_number if !phone_number.empty?
        entry.email = email if !email.empty?
        system "clear"
        puts "Updated entry:"
        puts entry
    end
    
    def delete_entry(entry)
        address_book.entries.delete(entry)
        puts "#{entry.name} has been deleted."
    end
end