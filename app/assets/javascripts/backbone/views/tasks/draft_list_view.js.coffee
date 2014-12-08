TaskManager.Views.Tasks ||= {}

class TaskManager.Views.Tasks.DraftListView extends Backbone.View
  template: JST["backbone/templates/tasks/draft_list"]

  tagName: "div"

  initialize: () ->
    @collection.bind('reset', @addAll)
    @listenTo @collection, 'add', @addOne

  addAll: () =>
    @collection.each(@addOne)

  addOne: (task) =>
    view = new TaskManager.Views.Tasks.DraftView({model : task})
    @$("ul").append(view.render().el)

  render: =>
    @$el.html(@template(tasks: @collection.toJSON() ))
    @addAll()
    @$("#draft-list").sortable(
      stop: (event, ui) ->
        ui.item.trigger('drop', ui.item.index())
    )
    @$("#draft-list").sortable( "option", "connectWith", ["#inprogress-list"]);

    return this
