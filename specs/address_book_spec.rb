require_relative '../models/address_book'

RSpec.describe AddressBook do
    let(:book) { AddressBook.new }
    
    def check_entry(entry, expected_name, expected_number, expected_email)
        expect(entry.name).to eq(expected_name)
        expect(entry.phone_number).to eq(expected_number)
        expect(entry.email).to eq(expected_email)
    end
    
    describe "attributes" do
        it "responds to entries" do
            expect(book).to respond_to(:entries)
            book.import_from_csv("entries.csv")
            # Check the first entry
            entry_one = book.entries[0]
            check_entry(entry_one, "Bill", "555-555-4854", "bill@blocmail.com")
        end
        
        it "imports the second entry" do
            book.import_from_csv("entries.csv")
            # Check the second entry
            entry_two = book.entries[1]
            check_entry(entry_two, "Bob", "555-555-5415", "bob@blocmail.com")
        end
        
        it "imports the third entry" do
            book.import_from_csv("entries.csv")
            # Check the third entry
            entry_three = book.entries[2]
            check_entry(entry_three, "Joe", "555-555-3660", "joe@blocmail.com")
        end
        
        it "imports the fourth entry" do
            book.import_from_csv("entries.csv")
            # Check the fourth entry
            entry_four = book.entries[3]
            check_entry(entry_four, "Sally", "555-555-4646", "sally@blocmail.com")
        end
        
        it "imports the fifth entry" do
            book.import_from_csv("entries.csv")
            # Check the fifth entry
            entry_five = book.entries[4]
            check_entry(entry_five, "Sussie", "555-555-2036", "sussie@blocmail.com")
        end
        
        it "initializes entries as an array" do
            expect(book.entries).to be_an(Array)
        end
        
        it "initializes entries as empty" do
            expect(book.entries.size).to eq(0)
        end
    end
    
    describe "#add_entry" do
        it "adds only one entry to the address book" do
            book.add_entry('Brandon Caples', '6292019981', 'brandoncaples@gmail.com')
            
            expect(book.entries.size).to eq(1)
        end
        
        it "adds the correct information to entries" do
            book.add_entry('Brandon Caples', '6292019981', 'brandoncaples@gmail.com')
            new_entry = book.entries[0]
            
            expect(new_entry.name).to eq('Brandon Caples')
            expect(new_entry.phone_number).to eq('6292019981')
            expect(new_entry.email).to eq('brandoncaples@gmail.com')
        end
    end
    
    describe "#import_from_csv" do
        it "imports the correct number of entries" do
            book.import_from_csv("entries.csv")
            book_size = book.entries.size
            
            # Check the size of the entries in AddressBook
            expect(book_size).to eq(5)
        end
    end
    
    describe "entries_2.csv" do
        it "imports the correct number of entries" do
            book.import_from_csv("entries_2.csv")
            book_size = book.entries.size
            
            expect(book_size).to eq(3)
        end
        
        it "responds to entries" do
            expect(book).to respond_to(:entries)
            book.import_from_csv("entries_2.csv")
            # Check the first entry
            entry_one = book.entries[0]
            check_entry(entry_one, "Brandon", "555-555-9981", "brandoncaples@gmail.com")
        end
        
        it "imports the second entry" do
            book.import_from_csv("entries_2.csv")
            # Check the second entry
            entry_two = book.entries[1]
            check_entry(entry_two, "Ezra", "555-555-9979", "ezra@caples.com")
        end
        
        it "imports the third entry" do
            book.import_from_csv("entries_2.csv")
            # Check the third entry
            entry_three = book.entries[2]
            check_entry(entry_three, "Jackie", "555-555-9978", "jackie@caples.com")
        end
    end
    
    describe "#remove_entry" do
        it "removes only one entry from the address book" do
            book.remove_entry('Brandon Caples', '6292019981', 'brandoncaples@gmail.com')
            expect(book.entries.size).to eq(0)
        end
    end
    
    # Test iterative_search method
    describe "#iterative_search" do
        it "searches AddressBook for a non-existent entry" do
            book.import_from_csv("entries.csv")
            entry = book.iterative_search("Jacob")
            expect(entry).to be_nil
        end
        
        it "searches AddressBook for Bill" do
            book.import_from_csv("entries.csv")
            entry = book.iterative_search("Bill")
            expect(entry).to be_an Entry
            check_entry(entry, "Bill", "555-555-4854", "bill@blocmail.com")
        end
        
        it "searches AddressBook for Bob" do
            book.import_from_csv("entries.csv")
            entry = book.iterative_search("Bob")
            expect(entry).to be_an Entry
            check_entry(entry, "Bob", "555-555-5415", "bob@blocmail.com")
        end
        
        it "searches AddressBook for Joe" do
            book.import_from_csv("entries.csv")
            entry = book.iterative_search("Joe")
            expect(entry).to be_an Entry
            check_entry(entry, "Joe", "555-555-3660", "joe@blocmail.com")
        end
        
        it "searches AddressBook for Sally" do
            book.import_from_csv("entries.csv")
            entry = book.iterative_search("Sally")
            expect(entry).to be_an Entry
            check_entry(entry, "Sally", "555-555-4646", "sally@blocmail.com")
        end
        
        it "searches AddressBook for Sussie" do
            book.import_from_csv("entries.csv")
            entry = book.iterative_search("Sussie")
            expect(entry).to be_an Entry
            check_entry(entry, "Sussie", "555-555-2036", "sussie@blocmail.com")
        end
    end
    
    # Test binary_search method
    describe "#binary_search" do
        it "searches AddressBook for a non-existent entry" do
            book.import_from_csv("entries.csv")
            entry = book.binary_search("Dan")
            expect(entry).to be_nil
        end
        
        it "searches AddressBook for Bill" do
            book.import_from_csv("entries.csv")
            entry = book.binary_search("Bill")
            expect(entry).to be_an Entry
            check_entry(entry, "Bill", "555-555-4854", "bill@blocmail.com")
        end
        
        it "searches AddressBook for Bob" do
            book.import_from_csv("entries.csv")
            entry = book.binary_search("Bob")
            expect(entry).to be_an Entry
            check_entry(entry, "Bob", "555-555-5415", "bob@blocmail.com")
        end
        
        it "searches AddressBook for Joe" do
            book.import_from_csv("entries.csv")
            entry = book.binary_search("Joe")
            expect(entry).to be_an Entry
            check_entry(entry, "Joe", "555-555-3660", "joe@blocmail.com")
        end
        
        it "searches AddressBook for Sally" do
            book.import_from_csv("entries.csv")
            entry = book.binary_search("Sally")
            expect(entry).to be_an Entry
            check_entry(entry, "Sally", "555-555-4646", "sally@blocmail.com")
        end
        
        it "searches AddressBook for Sussie" do
            book.import_from_csv("entries.csv")
            entry = book.binary_search("Sussie")
            expect(entry).to be_an Entry
            check_entry(entry, "Sussie", "555-555-2036", "sussie@blocmail.com")
        end
        
        it "searches AddressBook for Billy" do
            book.import_from_csv("entries.csv")
            entry = book.binary_search("Billy")
            expect(entry).to be_nil
        end
    end
end