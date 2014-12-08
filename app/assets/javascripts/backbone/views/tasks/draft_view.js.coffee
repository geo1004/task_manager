TaskManager.Views.Tasks ||= {}

class TaskManager.Views.Tasks.DraftView extends Backbone.View
  template: JST["backbone/templates/tasks/draft"]

  events:
    "click span.title" : "send_to_progress"
    "click span.content" : "send_to_progress"
    "drop": "update_state"

  tagName: "li"

  send_to_progress: () ->
    @model.set('state', 'inprogress')
    @model.save(null,
      success: (task) =>
        @model = task
    )
    this.remove()
    switch @model.get('state')
      when 'draft'
        view = new TaskManager.Views.Tasks.DraftView({model : @model})
        $("#task_draft ul").append(view.render().el)
      when 'inprogress'
        view = new TaskManager.Views.Tasks.InProgressView({model : @model})
        $("#task_in_progress ul").append(view.render().el)
      when 'finished'
        view = new TaskManager.Views.Tasks.FinishedView({model : @model})
        $("#task_finished ul").append(view.render().el)

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
