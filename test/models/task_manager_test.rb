require_relative '../test_helper'

class TaskManagerTest < Minitest::Test
  include TestHelpers

  def test_it_creates_a_task
    create_tasks(1)

    task = task_manager.find(1)

    assert_equal "Task Title 1", task.title
    assert_equal "Task Description 1", task.description
    assert_equal 1, task.id
  end

  def test_it_returns_all_tasks
    create_tasks(3)

    tasks = task_manager.all

    assert_equal 3, tasks.size
    assert_equal "Task Title 1", tasks[0].title
    assert_equal "Task Title 2", tasks[1].title
    assert_equal "Task Title 3", tasks[2].title
  end

  def test_it_can_find_a_specific_task
    create_tasks

    task = task_manager.find(2)

    assert_equal 2, task.id
    assert_equal "Task Title 2", task.title
    assert_equal "Task Description 2", task.description
  end

  def test_it_can_update_a_task
    create_tasks

    task = task_manager.find(2)

    assert_equal "Task Title 2", task.title
    assert_equal "Task Description 2", task.description

    task_manager.update(2, {
      :title       => "an updated title",
      :description => "an updated description"
      })

    task = task_manager.find(2)

    assert_equal "an updated title", task.title
    assert_equal "an updated description", task.description
  end

  def test_it_can_destroy_a_task
    create_tasks

    tasks = task_manager.all

    assert_equal 2, tasks.size
    assert tasks.any? { |task| task.title == "Task Title 2" }

    task_manager.destroy(2)

    tasks = task_manager.all

    assert_equal 1, tasks.size
    refute tasks.any? { |task| task.title == "Task Title 2" }
  end
end
