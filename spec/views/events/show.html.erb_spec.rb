require 'rails_helper'


RSpec.describe "events/show", type: :view do
  context '未ログインユーザがアクセスしたとき' do
    # https://github.com/rspec/rspec-rails/issues/1076
    # stubが動かん
    before do
      # http://qiita.com/yoot/items/5628257a6fa1ffa5db31
      def view.logged_in?; end
      def view.current_user; end
      # HACK: viewオブジェクトにlogged_in?というメソッドを仮に定義(stub)
      allow(view).to receive(:logged_in?) { false }
      allow(view).to receive(:current_user) { nil }
    end

    context 'かつ @event.ownerがnilのとき' do
      before do
        assign(:event, create(:event, owner: nil))
        assign(:tickets, [])
      end

      it '"退会したユーザです"と表示されること' do
        render
        expect(rendered).to match /退会したユーザです/
      end
    end
  end
end
