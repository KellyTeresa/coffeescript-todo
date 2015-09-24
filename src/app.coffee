class Task extends Backbone.Model
  defaults:
    finished: false
    text: ""

class TaskCollection extends Backbone.Collection
  model: Task

class TaskView extends Backbone.View

class CoffeeTodo

$ ->
  app = new CoffeeTodo

# test task
task = new Task
  text: "Wash the dishes"

console.log(task.get 'text')
console.log(task.get 'finished')
