require 'rails_helper'

RSpec.describe Event, type: :model do
  # HACK: using shoulda-matcher
  # describe "#name" do
  #   context '空白の時' do
  #     let(:event) { Event.new(name: '') }
  #     it 'validでないこと' do
  #       event.valid?
  #       expect(event.errors[:name]).to be_present
  #     end
  #   end
  # end
  describe "#name" do
    it { should validate_presence_of(:name) }
    it { should validate_length_of(:name).is_at_most(50) }
  end
end
