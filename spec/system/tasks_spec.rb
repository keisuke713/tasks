require 'rails_helper'

describe 'Task', type: :system do
  describe 'show' do
    before do
      FactoryBot.create(:task)  
      visit '/'
    end
    it 'show task' do
      expect(page).to have_content 'MyTask'
    end
  end

  describe 'create_new_task' do
    context 'parameter is correct' do
      before do
        visit new_task_path
        fill_in 'Title', with: 'MyTask'
        fill_in 'Detail', with: 'MyDetail'
        click_button 'confirm'
      end
      it 'transition confirm' do
        expect(page).to have_title 'confirm'
        expect(page).to have_content 'MyTask'
        expect(page).to have_content 'MyDetail'
        expect(page).to have_content Date.today
        expect(page).to have_button 'back'
        expect(page).to have_button 'create'
      end
    end

    context 'parameter is incorrect' do
      before do
        visit new_task_path
        fill_in 'Title', with: 'MyTask'
        fill_in 'Detail', with: ''
        click_button
      end
      it 'display error message' do
        expect(page).to have_title 'New Task'
        expect(page).to have_text "Detail can't be blank"
        expect(page).to have_button 'confirm'
      end
    end
  end
  describe 'confirm_new_task' do
    context 'create_new_task' do
      before do
        visit new_task_path
        fill_in 'Title', with: 'MyTask'
        fill_in 'Detail', with: 'MyDetail'
        click_button 'confirm'
        click_button 'create'
      end
      it 'is registered' do
        expect(page).to have_title 'Tasks'
        expect(page).to have_content 'MyTask'
        expect(page).to have_content 'MyDetail'
        expect(page).to have_content '2019-11-06'
        expect(page).to have_content 'waiting'
        expect(page).to have_link '編集する'
      end
    end
    context 'back to create screen' do
      before do
        visit new_task_path
        fill_in 'Title', with: 'MyTask'
        fill_in 'Detail', with: 'MyDetail'
        click_button 'confirm'
        click_button 'back'
      end
      it 'back to create screen' do
        expect(page).to have_title 'New Task'
        expect(page).to have_content 'Title'
        expect(page).to have_content 'Detail'
        expect(page).to have_content 'Deadlie'
      end
    end
  end
end
