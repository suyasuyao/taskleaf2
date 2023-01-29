class TasksController < ApplicationController
  def index; end

  def show; end

  def new
    @Task = Task.new
  end

  def edit; end
end
