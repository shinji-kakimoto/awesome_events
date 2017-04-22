require 'rails_helper'


RSpec.describe "events/show", type: :view do
  context '未ログインユーザがアクセスしたとき' do
    # https://github.com/rspec/rspec-rails/issues/1076
    # stubが動かん
    before do
      # HACK: viewオブジェクトにlogged_in?というメソッドを仮に定義(stub)
      allow(view).to receive(:logged_in?) { :value }
      allow(view).to receive(:current_user).and_return(false)
    end

    context 'かつ @event.ownerがnilのとき' do
      before do
        assign(:event, create(:event, owner: nil))
        assign(:ticket, [])
      end

      xit '"退会したユーザです"と表示されること' do
        render
        expect(rendered).to match /退会したユーザです/
      end
    end
  end
end
