director.Directive = class Directive
  ###
  Configure and initialize the directive
  ###
  constructor: (@director, config) ->
    @initialize()
    @configure config if config?

  ###
  Initialize the directive
  ###
  initialize: ->
    ###
    Holds the root scope for the directive
    ###
    @scope = @director?.scope
    ###
    Holds the events that have been bound
    ###
    @bound = []
    ###
    Holds the supported selector events
    ###
    @selectorEvents = []

    this

  ###
  Configure the directive based on a config object
  ###
  configure: (config) ->
    @[attribute] = value for attribute, value of config
    this

  ###
  Determine whether or not a given element is an input element,
  for example a textarea, input or select tag
  ###
  isInputElement: (el) ->
    el = el[0] unless el instanceof Element
    /^(input|select|textarea)$/i.test el.tagName

  ###
  Return all directive attributes in the given element
  ###
  attributes: (element) =>
    attributes = {}
    re = new RegExp "^#{@director.prefix}(.*)", "i"
    $.each element.attributes, (i, attr) ->
      if matches = attr.name.match re
        attributes[matches[1]] = attr.value
    if attributes.args?
      attributes.args = @createArguments attributes.args
    attributes

  ###
  Create function arguments based on a string
  ###
  createArguments: (argumentString) ->
    fn = new Function ["return [", argumentString, "];"].join ""
    fn()

  ###
  Finds the nearest element that matches a given selector
  ###
  findNearest: ($el, selector, upwardsOnly = false) ->
    return $found.first() if not upwardsOnly and ($found = $el.find selector).length
    $context = $el.parent()
    while $context.length
      return $context if $context.is selector
      return $found.first() if ($found = $context.find selector).length
      $context = $context.parent()
    return $()


  ###
  Start the directive
  ###
  start: ->
    @register selector, eventName for [selector, eventName] in @selectorEvents
    this

  ###
  Stops the directive
  ###
  stop: ->
    @unregister fn while fn = @bound.pop()
    this

  ###
  Register a directive for a selector / event name
  ###
  register: (selector, eventName) ->
    handler = (e) =>
      return false if e.isPropagationStopped()
      attributes = @attributes e.target
      @handleEvent e, attributes

    @bound.push handler
    @scope.on eventName, selector, handler
    this

  ###
  Unregister a bound handler
  ###
  unregister: (fn) ->
    @bound.splice (@bound.indexOf fn), 1
    this

  ###
  Handles an event event
  ###
  handleEvent: (e) ->
