require 'rails_helper'

RSpec.feature "Logouts", type: :feature do
  include LoginHelper::Feature
  context 'ログインユーザがトップページに遷移したとき' do
    before do
      login
      visit root_path
    end

    it '"ログアウト"リンクが表示されていること' do
      expect(page).to have_link 'ログアウト'
    end

    context 'かつ"ログアウト"リンクをクリックしたとき' do
      before { click_link 'ログアウト' }

      it '"ログアウトしました"と表示されていること' do
        expect(page).to have_content 'ログアウトしました'
      end

      it '"ログアウト"リンクが表示されていないこと' do
        expect(page).to have_no_link 'ログアウト'
      end
    end
  end
end
