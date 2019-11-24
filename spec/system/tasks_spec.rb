require 'rails_helper'

describe 'Task', type: :system do
  let(:user) {
    FactoryBot.create(:user)
  }
  let!(:user_2) {
    FactoryBot.create(:user2)
  }
  let!(:task2) {
    FactoryBot.create(:task_user_2_creating)
  }
  before do
    login_as(user, scope: :user)
  end
  describe 'index' do
    before do
      FactoryBot.create(:task)  
      visit '/'
    end
    it 'show task' do
      expect(page).to have_content 'MyTask'
      expect(page).to have_content 'MyString'
      expect(page).to have_content Date.today
      expect(page).to have_content 'work'
      expect(page).to have_no_content 'MyTaskByUser2'
    end
  end  
  describe 'show' do
    context 'show my task' do
      let(:task) {
        FactoryBot.create(:task)
      }
      before do
        visit task_path task.id
      end
      it 'display task' do
        expect(page).to have_title 'Task'
        expect(page).to have_content 'MyTask'
        expect(page).to have_content 'MyString'
        expect(page).to have_content Date.today
        expect(page).to have_content 'work'
      end
    end
    context 'show other users task' do
      before do
        visit task_path task2.id
      end
      it 'redirect all tasks' do
        expect(page).to have_title 'All tasks'
        expect(page).to have_content '自分の作成したタスク以外は閲覧できません'
      end
    end
  end
  describe 'create_new_task' do
    context 'parameter is correct' do
      before do
        visit new_task_path
        fill_in 'Title', with: 'MyTask'
        fill_in 'Detail', with: 'MyDetail'
        fill_in 'Label', with: 'work'
        click_on 'confirm'
      end
      it 'transition confirm' do
        expect(page).to have_title 'Confirm'
        expect(page).to have_content 'MyTask'
        expect(page).to have_content 'MyDetail'
        expect(page).to have_content Date.today
        expect(page).to have_content 'work'
        expect(page).to have_button 'back'
        expect(page).to have_button 'create'
      end
    end

    context 'parameter is incorrect' do
      before do
        visit new_task_path
        fill_in 'Title', with: 'MyTask'
        fill_in 'Detail', with: ''
        fill_in 'Label', with: 'work'
        click_on
      end
      it 'display error message' do
        expect(page).to have_title 'New Task'
        expect(page).to have_text "Detail can't be blank"
        expect(page).to have_button 'confirm'
      end
    end
    context 'set a deadline before today' do
      let(:date) {
        Date.today - 1 
      }
      before do
        visit new_task_path
        fill_in 'Title', with: 'MyTask'
        fill_in 'Detail', with: 'MyDetail'
        select date.year, from: 'task_deadline_1i'
        select date.mon, from: 'task_deadline_2i'
        select date.day, from: 'task_deadline_3i'
        fill_in 'Label', with: 'work'
        click_on 'confirm'
      end
      it 'is displayed error message' do
        expect(page).to have_content "#{date}は過去の日付です"
      end
    end
  end
  describe 'confirm_new_task' do
    context 'create_new_task' do
      before do
        visit new_task_path
        fill_in 'Title', with: 'MyTask'
        fill_in 'Detail', with: 'MyDetail'
        fill_in 'Label', with: 'work'
        click_on 'confirm'
        click_on 'create'
      end
      it 'is registered' do
        expect(page).to have_title 'Task'
        expect(page).to have_content 'MyTask'
        expect(page).to have_content 'MyDetail'
        expect(page).to have_content 'work'
        expect(page).to have_content Date.today 
        expect(page).to have_content 'waiting'
        expect(page).to have_link '編集する'
      end
    end
    context 'back to create screen' do
      before do
        visit new_task_path
        fill_in 'Title', with: 'MyTask'
        fill_in 'Detail', with: 'MyDetail'
        fill_in 'Label', with: 'work'
        click_on 'confirm'
        click_on 'back'
      end
      it 'back to create screen' do
        expect(page).to have_title 'New Task'
        expect(page).to have_content 'Title'
        expect(page).to have_content 'Detail'
        expect(page).to have_content 'Deadline'
        expect(page).to have_content 'Label'
      end
    end
  end
  describe 'edit task' do
    let(:task) {
      FactoryBot.create(:task)
    }
    before do
      visit task_path task.id
      click_on '編集する'
    end
    context 'parameter is correct' do
      before do
        fill_in 'Title', with: 'Edit task'
        click_on 'confirm'
      end
      it 'transition confirm screen' do
        expect(page).to have_title 'Confirm'
        expect(page).to have_content 'Edit task'
        expect(page).to have_content 'MyString'
        expect(page).to have_content task.deadline
        expect(page).to have_content 'work'
        expect(page).to have_button 'update'
        expect(page).to have_button 'back'
      end
    end
    context 'parameter is incorrect' do
      before do
        fill_in 'Title', with: ''
        click_on 'confirm'
      end
      it 'render new screen' do
        expect(page).to have_title 'Edit Task'
        expect(page).to have_content "Title can't be blank"
        expect(page).to have_button 'confirm'
      end
    end
    context 'back to edit screen' do
      before do
        fill_in 'Title', with: 'Edit Task'
        click_on 'confirm'
        click_on 'back'
      end
      it 'render new screen' do
        expect(page).to have_title 'Edit Task'
        expect(page).to have_content 'Edit Task'
        expect(page).to have_button 'confirm'
      end
    end
  end
end
