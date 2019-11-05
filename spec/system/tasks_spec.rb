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

  describe 'create_task' do
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

    end
  end
end
