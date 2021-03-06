require 'rails_helper'

RSpec.feature "Logins", type: :feature do
  context 'トップページに遷移し、"Twitterでログイン"をクリックした時' do
    context 'かつTwitterでログインに成功した時' do
      before do
        visit root_path
        click_link 'Twitterでログイン'
      end
      it 'トップページに遷移していること' do
        expect(page.current_path).to eq root_path
      end

      it 'ログインしましたと表示されること' do
        expect(page).to have_content 'ログインしました'
      end
    end

    context 'かつTwitterでのログインに失敗したとき' do
      around do |example|
        original_mock_auth = OmniAuth.config.mock_auth[:twitter]
        OmniAuth.config.mock_auth[:twitter] = :invalid_credentials
        visit root_path
        click_link 'Twitterでログイン'
        example.run # HACK: ここでテストが実行される
        OmniAuth.config.mock_auth[:twitter] = original_mock_auth
      end

      it 'トップページに遷移していること' do
        expect(page.current_path).to eq root_path
      end

      it '"ログインに失敗しました"と表示されること' do
        expect(page).to have_content 'ログインに失敗しました'
      end
    end
  end
end
