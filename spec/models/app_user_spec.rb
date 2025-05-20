require 'rails_helper'

RSpec.describe V1::AppUser, type: :model do

  describe '#show_name' do
  
    let(:app_user) { create(:app_user, name: name) }

    it '返回原名（已带老师）' do
      user = AppUser.new(name: '刘老师')
      expect(user.show_name).to eq('刘老师')
    end

    it '返回姓+老师（无老师字样）' do
      user = AppUser.new(name: '张三')
      expect(user.show_name).to eq('张老师')
    end

    it '姓名为空字符串时返回空字符串' do
      user = AppUser.new(name: '')
      expect(user.show_name).to eq('')
    end

    it '姓名为nil时返回空字符串' do
      user = AppUser.new(name: nil)
      expect(user.show_name).to eq('')
    end

    it '姓名为单字时返回字+老师' do
      user = AppUser.new(name: '王')
      expect(user.show_name).to eq('王老师')
    end

    it '姓名为只包含空格时返回空字符串' do
      user = AppUser.new(name: '   ')
      expect(user.show_name).to eq('')
    end

    it '姓名为老师时返回老师' do
      user = AppUser.new(name: '老师')
      expect(user.show_name).to eq('老师')
    end
  end
end