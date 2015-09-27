$ ->
  class Task extends Backbone.Model
    defaults: ->
      finished: false
      text: ""

  class TaskCollection extends Backbone.Collection
    model: Task

  class TaskView extends Backbone.View
    tagName: "li"

    # initialize: ->
    #   _.bindAll @

    render: ->
      $(@el).html "<span>#{@model.get 'text'}. Complete? #{@model.get 'finished'}.</span>"

      @

  class ListView extends Backbone.View
    el: $ "body"

    initialize: ->
      # _.bindAll @

      @collection = new TaskCollection
      @collection.bind "add", @appendItem

      @counter = 0
      @render()

    render: ->
      $(@el).append "<button>Add List Item</button>"
      $(@el).append "<ul></ul>"

    addItem: ->
      @counter++
      task = new Task
      task.set text: "Hi #{@counter}"
      @collection.add task

    appendItem: (task) ->
      task_view = new TaskView model: task
      $("ul").append task_view.render().el

    events: "click button": "addItem"

  list = new ListView
