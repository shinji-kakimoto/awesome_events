require 'rails_helper'

RSpec.describe Ticket, type: :model do
  it { should belong_to(:user) }
  it { should belong_to(:event) }

  it { should validate_length_of(:comment).is_at_most(30) }
  it { should allow_value('', nil).for(:comment) }
end
