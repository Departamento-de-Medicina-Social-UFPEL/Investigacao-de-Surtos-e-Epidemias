locomotive = require 'locomotive'
Controller = locomotive.Controller
Demo = require '../lib/demo.coffee'

class DemoController extends Controller

  index: () ->
    demo = new Demo
    todos = {}
    for nome, estado in do demo.getUfs
      todos[estado] = demo.getData estado, 100
    @res.json todos

  show: () ->
    demo = new Demo
    uf = @param 'uf'
    pop = @param 'pop'
    data = demo.getData uf,pop
    # console.log data
    @res.send "Oi"

demoController = new DemoController

module.exports = demoController