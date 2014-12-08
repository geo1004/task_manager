class TaskManager.Routers.TasksRouter extends Backbone.Router
  initialize: (options) ->
    @tasks_draft = new TaskManager.Collections.TasksCollection()
    @tasks_in_progress = new TaskManager.Collections.TasksCollection()
    @tasks_finished = new TaskManager.Collections.TasksCollection()

    @tasks_draft.reset options.tasks_draft
    @tasks_in_progress.reset options.tasks_in_progress
    @tasks_finished.reset options.tasks_finished

  routes:
    "index"    : "index"
    ".*"        : "index"

  index: ->
    @view = new TaskManager.Views.Tasks.NewView(collection: @tasks_draft)
    @draftView = new TaskManager.Views.Tasks.DraftListView(collection: @tasks_draft)
    @inProgressListView = new TaskManager.Views.Tasks.InProgressListView(collection: @tasks_in_progress)
    @finishedistView = new TaskManager.Views.Tasks.FinishedListView(collection: @tasks_finished)

    $("#new_task").html(@view.render().el)
    $("#task_draft").html(@draftView.render().el)
    $("#task_in_progress").html(@inProgressListView.render().el)
    $("#task_finished").html(@finishedistView.render().el)
