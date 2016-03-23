ENV['RACK_ENV'] ||= 'test'

require File.expand_path('../../config/environment', __FILE__)
require 'minitest/autorun'
require 'tilt/erb'

module TestHelpers
  def teardown
    task_manager.delete_all
    super
  end

  def task_manager
    database = YAML::Store.new('db/task_manager_test')
    @task_manager ||= TaskManager.new(database)
  end

  def create_three_tasks
    task_manager.create({
      :title       => "a title",
      :description => "a description"
      })
    task_manager.create({
      :title       => "another title",
      :description => "another description"
      })
    task_manager.create({
      :title       => "a third title",
      :description => "a third description"
      })
  end
end
