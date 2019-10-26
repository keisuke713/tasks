require 'rails_helper'

RSpec.describe TasksController, type: :controller do

  describe "GET #index" do
    let!(:task) {
      FactoryBot.create(:task)
    }
    it "returns http success" do
      get :index
      expect(response.status).to eq 200
    end
    it "assigns all tasks" do
      get :index
      expect(assigns(:tasks)).to include task
    end
    it "render index" do
       get :index
       expect(response).to render_template 'index'
    end
  end
  
  describe "GET #show" do
    let!(:task) {
      FactoryBot.create(:task)
    }
    let!(:id) {
      { id: task.id }
    }
    it "returns http success" do
      get :show, params: id 
      expect(response.status).to eq 200
    end
    it "assigns task" do
      get :show, params: id
      expect(assigns(:task)).to eq task
    end
    it "render show" do
      get :show, params: id
      expect(response).to render_template 'show'
    end 
  end
end
