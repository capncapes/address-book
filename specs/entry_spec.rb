require_relative '../models/entry'

RSpec.describe Entry do
    
    describe "attributes" do
        let(:entry) { entry = Entry.new('Brandon Caples', '6292019981', 'brandoncaples@gmail.com') }
        
        it "responds to name" do
            expect(entry).to respond_to(:name)
        end
        
        it "reports its name" do
            expect(entry.name).to eq('Brandon Caples')
        end
        
        it "responds to phone number" do
            expect(entry).to respond_to(:phone_number)
        end
        
        it "reports its phone number" do
            expect(entry.phone_number).to eq('6292019981')
        end
        
        it "responds to email" do
            expect(entry).to respond_to(:email)
        end
        
        it "reports its email" do
            expect(entry.email).to eq('brandoncaples@gmail.com')
        end
    end
    
    describe "#to_s" do
        it "prints an entry as a string" do
            entry = Entry.new('Brandon Caples', '6292019981', 'brandoncaples@gmail.com')
            expected_string = "Name: Brandon Caples\nPhone Number: 6292019981\nEmail: brandoncaples@gmail.com"
            expect(entry.to_s).to eq(expected_string)
        end
    end
end