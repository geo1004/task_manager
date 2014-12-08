TaskManager.Views.Tasks ||= {}

class TaskManager.Views.Tasks.InProgressListView extends Backbone.View
  template: JST["backbone/templates/tasks/in_progress_list"]

  initialize: () ->
    @collection.bind('reset', @addAll)
    @listenTo @collection, 'add', @addOne

  addAll: () =>
    @collection.each(@addOne)

  addOne: (task) =>
    view = new TaskManager.Views.Tasks.InProgressView({model : task})
    @$("ul").append(view.render().el)

  render: =>
    @$el.html(@template(tasks: @collection.toJSON() ))
    @addAll()
    @$("#inprogress-list").sortable(
      stop: (event, ui) ->
        ui.item.trigger('drop', ui.item.index())
    )
    @$("#inprogress-list").sortable( "option", "connectWith", ["#finished-list", "#draft-list"]);

    return this
