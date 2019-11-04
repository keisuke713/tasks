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
  
  describe "GET #new" do
    it "returns http success" do
      get :new
      expect(response.status).to eq 200
    end
    it "render new" do
      get :new
      expect(response).to render_template 'new'
    end
  end

  describe "POST #confirm" do
    let(:valid_attributes) {
      FactoryBot.attributes_for(:task)
    }
    let(:params) {
      { task: valid_attributes }
    }
    let!(:task) {
      FactoryBot.build(:task)
    }
    it 'assigns object' do
      post :confirm_new, params: params
      expect(assigns(:task.title)).to eq task.title
      expect(@task.instance_vairable_get(:@title)).to eq task.title
    end
    it 'render show page' do
      post :confirm_new, params: params
      expect(response).to render_template 'confirm_new'
    end
  end

  describe "POST #create" do
    let!(:task_params) {
      FactoryBot.attributes_for(:task)
    }
    context "parameter is correct" do
      it "inserted record" do
        expect {
          post :create, params: task_params
        }.to change(Task, :count).by 1
      end
      it "redirect show page" do
        post :create, params: task_params
        expect(response).redirect_to tasks_path
      end
    end
    context "parameter is incorrect" do
      before do
        task_params[:title] = ''
      end
      it "didn't insert record" do
        expect {
          post :create, params: task_params
        }.to change(Task, :count).by 0
      end
      it "render new" do
        expect(response).to render_template 'new'
      end
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
  
  describe "GET #edit" do
    it "request http success" do

    end
    it "assigns task" do

    end
    it "render edit page" do
      
    end
  end
  describe "PUT #update" do
    context "parameter is correct" do
      it "update record" do
        
      end
      it "redirect show page" do

      end
    end
    context "parameter is incorrect" do
      it "doesn't update record" do

      end
      it "render show page" do

      end
    end
  end
end
