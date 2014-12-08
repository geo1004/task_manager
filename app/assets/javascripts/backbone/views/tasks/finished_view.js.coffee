TaskManager.Views.Tasks ||= {}

class TaskManager.Views.Tasks.FinishedView extends Backbone.View
  template: JST["backbone/templates/tasks/finished"]

  initialize: () ->
    # @listenTo @model, 'change:state', @add_to_right_column

  events:
    "dblclick span.title" : "destroy"
    "dblclick span.content" : "destroy"
    "drop": "update_state"

  tagName: "li"

  destroy: () ->
    @model.destroy()
    this.remove()

    return false

  update_state: (event, index) ->
    switch $(event.target).parent('ul').attr('id')
      when 'draft-list'
        @model.set('state', 'draft')
        @model.save(null,
          success: (task) =>
            @model = task
        )
      when 'inprogress-list'
        @model.set('state', 'inprogress')
        @model.save(null,
          success: (task) =>
            @model = task
        )
      when 'finished-list'
        @model.set('state', 'finished')
        @model.save(null,
          success: (task) =>
            @model = task
        )

  render: ->
    @$el.html(@template(@model.toJSON() ))
    return this
