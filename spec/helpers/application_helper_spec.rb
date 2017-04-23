require 'rails_helper'

# Specs in this file have access to a helper object that includes
# the ApplicationHelper. For example:
#
# describe ApplicationHelper do
#   describe "string concat" do
#     it "concats two strings with spaces" do
#       expect(helper.concat_strings("this","that")).to eq("this that")
#     end
#   end
# end
RSpec.describe ApplicationHelper, type: :helper do
  describe '#url_for_twitter' do
    it '引数とした渡したユーザの twitter URLを返すこと' do
      user = create :user, nickname: 'willnet'

      expect(helper.url_for_twitter(user)).to eq 'https://twitter.com/willnet'
    end
  end
end
