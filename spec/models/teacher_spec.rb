require 'rails_helper'

RSpec.describe Teacher, type: :model do
  describe '#show_name' do
  
    let(:teacher) { create(:teacher, name: name) }

    context '姓名已带老师' do
      let(:name) { '刘老师' }
      it { expect(teacher.show_name).to eq('刘老师') }
    end

    context '姓名无老师字样' do
      let(:name) { '张三' }
      it { expect(teacher.show_name).to eq('张老师') }
    end

    context '姓名为空字符串' do
      let(:name) { '' }
      it { expect(teacher.show_name).to eq('') }
    end

    context '姓名为nil' do
      let(:name) { nil }
      it { expect(teacher.show_name).to eq('') }
    end

    context '姓名为单字' do
      let(:name) { '王' }
      it { expect(teacher.show_name).to eq('王老师') }
    end

    context '姓名为只包含空格' do
      let(:name) { '   ' }
      it { expect(teacher.show_name).to eq('') }
    end

    context '姓名为老师' do
      let(:name) { '老师' }
      it { expect(teacher.show_name).to eq('老师') }
    end
  end
end