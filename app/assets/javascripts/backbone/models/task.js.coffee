class TaskManager.Models.Task extends Backbone.Model
  paramRoot: 'task'

  defaults:
    title: null
    content: null
    state: 'draft'

class TaskManager.Collections.TasksCollection extends Backbone.Collection
  model: TaskManager.Models.Task
  url: '/tasks'
