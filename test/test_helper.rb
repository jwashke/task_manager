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

  def create_tasks(num = 2)
    num.times do |i|
      task_manager.create({
        :title => "Task Title #{i + 1}",
        :description => "Task Description #{i + 1}"
        })
    end
  end
end
