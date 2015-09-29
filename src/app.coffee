$ ->
  class Task extends Backbone.Model
    defaults: ->
      text: ""
      completed: "No"

  class TaskCollection extends Backbone.Collection
    model: Task

  class TaskView extends Backbone.View
    tagName: "li"

    initialize: ->
      @model.bind "change", @render
      @model.bind "remove", @unrender

    render: =>
      $(@el).html """
        <span>#{@model.get 'text'}. Complete? #{@model.get 'completed'}.</span>
        <span class="check button">Check</span>
        <span class="delete button">Delete</span>
      """
      @

    unrender: =>
      $(@el).remove()

    check: ->
      if (@model.get 'completed') is "No"
        @model.set completed: "Yes"
      else
        @model.set completed: "No"

    remove: -> @model.destroy()

    events:
      "click .check": "check"
      "click .delete": "remove"

  class ListView extends Backbone.View
    el: $ "body"

    initialize: ->
      @collection = new TaskCollection
      @collection.bind "add", @appendItem
      @render()

    render: ->
      $(@el).append "<button>Add List Item</button>"
      $(@el).append "<ol></ol>"

    addItem: ->
      task_text = $('input[name="task"]').val()
      @counter++
      task = new Task
      task.set text: task_text
      @collection.add task

    appendItem: (task) ->
      task_view = new TaskView model: task
      $("ol").append task_view.render().el

    events:
      "click button": "addItem"


  Backbone.sync = (method, model, success, error) ->
    success()

  list_view = new ListView
