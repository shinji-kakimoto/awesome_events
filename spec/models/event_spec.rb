require 'rails_helper'

RSpec.describe Event, type: :model do

  it { should have_many(:tickets).dependent(:destroy) }
  it { should belong_to(:owner).class_name('User') }

  describe '#name' do
    it { should validate_presence_of(:name) }
    it { should validate_length_of(:name).is_at_most(50) }
  end

  describe '#place' do
    it { should validate_presence_of(:place) }
    it { should validate_length_of(:place).is_at_most(100) }
  end

  describe '#content' do
    it { should validate_presence_of(:content) }
    it { should validate_length_of(:content).is_at_most(2000) }
  end

  describe '#start_time' do
    it { should validate_presence_of(:start_time) }
  end

  describe '#end_time' do
    it { should validate_presence_of(:end_time) }
  end

  describe '#start_time_should_be_before_end_time' do
    let(:now) { Time.zone.now }

    context '#start_time もしくは #end_time が nil なとき' do
      it '#errors[:start_time] が空であること' do
        event = Event.new(start_time: now, end_time: nil)
        event.send(:start_time_should_be_before_end_time)
        expect(event.errors[:start_time]).to be_empty

        event = Event.new(start_time: nil, end_time: now)
        event.send(:start_time_should_be_before_end_time)
        expect(event.errors[:start_time]).to be_empty

        event = Event.new(start_time: nil, end_time: nil)
        event.send(:start_time_should_be_before_end_time)
        expect(event.errors[:start_time]).to be_empty
      end
    end

    context '#start_time と #end_time が同時刻なとき' do
      it '#errors[:start_time] が空でないこと' do
        event = Event.new(start_time: now, end_time: now)
        event.send(:start_time_should_be_before_end_time)
        expect(event.errors[:start_time]).to be_present
      end
    end

    context '#start_time と比べて #end_time が1分後なとき' do
      it '#errors[:start_time] が空であること' do
        event = Event.new(start_time: now, end_time: now + 1.minute)
        event.send(:start_time_should_be_before_end_time)
        expect(event.errors[:start_time]).to be_blank
      end
    end

    context '#start_time と比べて #end_time が1分前なとき' do
      it '#errors[:start_time] が空でないこと' do
        event = Event.new(start_time: now, end_time: now - 1.minute)
        event.send(:start_time_should_be_before_end_time)
        expect(event.errors[:start_time]).to be_present
      end
    end
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
