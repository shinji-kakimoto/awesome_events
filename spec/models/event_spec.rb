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

  describe '#created_by?' do
    let(:event) { create(:event) }
    subject { event.created_by?(user) }

    context '引数が nil なとき' do
      let(:user) { nil }
      it { should be_falsey }
    end

    context '#owner_id と 引数の#idが同じ時' do
      # HACK: 実際にUserモデルのオブジェクトを作成してテストも可能
      # そうすると、EventモデルのテストはUserモデルの実装に依存してしまう
      # 依存を減らしてそれぞれの結合を疎にしたほうが管理がしやすいテストコードになる。
      let(:user) { double('user', id: event.id) }
      it { should be_truthy }
    end
  end

  describe '#rails?' do
    context '#nameが"Rails勉強会"の時' do
      it 'trueを返すこと' do
        event = create(:event, name: 'Rails勉強会')
        expect(event.rails?).to eq true
      end
    end
    context '#nameが"Ruby勉強会"の時' do
      it 'falseを返すこと' do
        event = create(:event, name: 'Ruby勉強会')
        expect(event.rails?).to eq false
      end
    end
  end
end
