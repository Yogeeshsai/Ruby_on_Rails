Define routes in config/routes.rb:
Rails.application.routes.draw do
  devise_for :users
  resources :tasks
  root to: "tasks#index"
end
Implement Task controller (app/controllers/tasks_controller.rb):
class TasksController < ApplicationController
  before_action :authenticate_user!
  before_action :set_task, only: [:show, :edit, :update, :destroy]

  def index
    @tasks = current_user.tasks.order(due_date: :asc)
  end

  def show
  end

  def new
    @task = current_user.tasks.build
  end

  def create
    @task = current_user.tasks.build(task_params)

    if @task.save
      redirect_to @task, notice: 'Task was successfully created.'
    else
      render :new
    end
  end

  def edit
  end

  def update
    if @task.update(task_params)
      redirect_to @task, notice: 'Task was successfully updated.'
    else
      render :edit
    end
  end

  def destroy
    @task.destroy
    redirect_to tasks_url, notice: 'Task was successfully destroyed.'
  end

  private

  def set_task
    @task = current_user.tasks.find(params[:id])
  end

  def task_params
    params.require(:task).permit(:title, :description, :due_date, :completed)
  end
end
Create views for tasks (app/views/tasks):
index.html.erb
show.html.erb
new.html.erb
edit.html.erb
Implement authentication check in ApplicationController (app/controllers/application_controller.rb):
class ApplicationController < ActionController::Base
  before_action :authenticate_user!
end
