TaskManager.Views.Tasks ||= {}

class TaskManager.Views.Tasks.InProgressView extends Backbone.View
  template: JST["backbone/templates/tasks/in_progress"]
  template_delete: JST["backbone/templates/tasks/finished"]

  initialize: ->
    @listenTo @model, 'change', @render

  events:
    "dblclick span.content" : "edit"
    "dblclick span.title" : "edit"
    "drop": "update_state"
    "keypress .edit > input": 'update'
    "click i": "destroy"

  tagName: "li"

  edit: ->
    @$("div.edit").removeClass('hidden')
    @$("div.show").addClass('hidden')

  update: (e)->
    if e.which == 13
      @model.set({
        title: @$('input').first().val(),
        content: @$('input').last().val()
      })
      @model.save(null,
        success: (task) =>
          @model = task
          @$("div.edit").addClass('hidden')
          @$("div.show").removeClass('hidden')
      )

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
    if @model.get('state') == "finished"
      @$el.html(@template_delete(@model.toJSON() ))
    else
      @$el.html(@template(@model.toJSON() ))
    return this
