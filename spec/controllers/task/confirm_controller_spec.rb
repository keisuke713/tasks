require 'rails_helper'

RSpec.describe Task::ConfirmController, type: :controller do
  describe "POST #show" do
    let(:valid_attributes) {
      FactoryBot.attributes_for(:task)
    }
    let(:params) {
      FactoryBot.attributes_for(:task) 
    }
    let(:tasks) {
      FactoryBot.build(:task)
    }
    it 'assigns object' do
      byebug
      post :show, params: params
      expect(assings(:task)).to eq tasks
    end
    it 'render show page' do
      post :show, params: params
      expect(response).to render_template 'show'
    end
  end
end
