director.Director = class Director
  ###
  Configure and initialize the directive
  ###
  constructor: (config) ->
    ###
    The scope within which to look for directives
    ###
    @scope = $ "body"
    ###
    The prefix to use to signify directive related attributes
    ###
    @prefix = "x-"
    ###
    The directive instances associated with this director
    ###
    @directives = []

    @configure config if config?

    if @directives.length is 0
      @addDirective Directive.Confirm
      @addDirective Directive.Alert
      @addDirective Directive.Trigger

  ###
  Configure the directive based on a config object
  ###
  configure: (config) ->
    @[attribute] = value for attribute, value of config
    this

  ###
  Adds the given directive
  ###
  addDirective: (directive) ->
    if typeof directive is "function"
      directive = new directive this
    else
      directive.director = this
    @directives.push directive
    this

  ###
  Starts the director
  ###
  start: ->
    directive.start() for directive in @directives
    this

  ###
  Stops the director
  ###
  stop: ->
    directive.stop() for directive in @directives
    this
