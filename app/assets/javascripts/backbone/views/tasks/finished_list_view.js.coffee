TaskManager.Views.Tasks ||= {}

class TaskManager.Views.Tasks.FinishedListView extends Backbone.View
  template: JST["backbone/templates/tasks/finished_list"]

  initialize: () ->
    @collection.bind('reset', @addAll)
    @listenTo @collection, 'add', @addOne

  addAll: () =>
    @collection.each(@addOne)

  addOne: (task) =>
    view = new TaskManager.Views.Tasks.FinishedView({model : task})
    @$("ul").append(view.render().el)

  render: =>
    @$el.html(@template(tasks: @collection.toJSON() ))
    @addAll()
    @$("#finished-list").sortable(
      stop: (event, ui) ->
        ui.item.trigger('drop', ui.item.index())
    )
    @$("#finished-list").sortable( "option", "connectWith", "#inprogress-list");


    return this
