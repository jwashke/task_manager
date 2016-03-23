require_relative '../test_helper'

class TaskManagerTest < Minitest::Test
  include TestHelpers

  def test_it_creates_a_task
    task_manager.create({
      :title       => "a title",
      :description => "a description"
      })

    task = task_manager.find(1)
    assert_equal "a title", task.title
    assert_equal "a description", task.description
    assert_equal 1, task.id
  end

  def test_it_returns_all_tasks
    create_three_tasks

    tasks = task_manager.all
    assert_equal 3, tasks.count
    assert_equal "a title", tasks[0].title
    assert_equal "another title", tasks[1].title
    assert_equal "a third title", tasks[2].title
  end

  def test_it_can_find_a_specific_task
    create_three_tasks

    task = task_manager.find(2)
    assert_equal 2, task.id
    assert_equal "another title", task.title
    assert_equal "another description", task.description
  end

  def test_it_can_update_a_task
    create_three_tasks

    task_manager.update(2, {
      :title       => "an updated title",
      :description => "an updated description"
      })

    task = task_manager.find(2)
    assert_equal "an updated title", task.title
    assert_equal "an updated description", task.description
  end

  def test_it_can_destroy_a_task
    create_three_tasks

    task_manager.destroy(2)
    tasks = task_manager.all
    assert_equal 2, tasks.count
    assert_equal "a title", tasks[0].title
    assert_equal "a third title", tasks[1].title
  end
end
