require "rails_helper"

RSpec.feature "task_management", :type => :feature do
  context 'task CRUD' do
    let!(:task) {FactoryBot.create (:task) }
  
    describe '#create' do
      it "Successfuly creates a new task " do
        # p task.title
        visit tasks_path
        click_link("新增任務")
        expect(current_path).to have_content('tasks/new')
    
        within("form") do 
            fill_in 'task_title', with:"task1"
            fill_in 'task_content', with:"123"
            fill_in 'task_start_time', with: DateTime.now
            fill_in 'task_end_time', with: DateTime.now
            select 'high', from: 'task_priority'
            select'running', from: 'task_status'
        end

        click_button "新增任務"

        expect(page).to have_text("新增任務成功")
        expect(current_path).to have_content(tasks_path)
      end
    end

    describe '#update' do
      it "Successfuly updates a new task" do
        visit tasks_path
        task = Task.find_by(title:'task1')
        click_link("編輯任務")
        expect(current_path).to have_content(edit_task_path(task))

        within("form") do 
            fill_in 'task_title', with:"task2"
        end

        click_button "更新任務"
        expect(page).to have_text("更新任務成功")
        expect(current_path).to have_content(tasks_path)
      end
    end
  
    describe '#show' do
      it "Successfuly read a task" do
        visit tasks_path
        task = Task.find_by(title:'task1')
        click_link '查看任務'
        expect(current_path).to have_content(task_path(task))

        click_link '返回上一頁'
        expect(current_path).to have_content(tasks_path)
      end
    end
  
    describe '#destroy' do
      it "Successfuly delete a task", driver: :selenium_chrome, js: true  do
        visit tasks_path
        task = Task.find_by(title:'task1')
        click_link '刪除任務'
        accept_alert(text: "您確定要刪除嗎？")
      
        expect(page).to have_current_path(tasks_path)
        expect(page).to have_content('任務已刪除')
        
      end
    end
  end
  # context 'task order' do
  #   scenario "desc order by task create time on index page" do
  #     task1 = Task.create(title:"task1", content:"123456", start_time: DateTime.now, end_time: DateTime.now ,priority:"high", status:"running", created_at: DateTime.now)
  #     task2 = Task.create(title:"task2", content:"654321", start_time: DateTime.now, end_time: DateTime.now ,priority:"high", status:"running", created_at: DateTime.now+1)

  #     visit tasks_path
  #     expect(Task.all.map(&:created_at)).to have_content([task2.created_at, task1.created_at])

  #   end
  # end
end