###
# Directive: Alert

Triggers an alert box that displays a message before continuing
###
class Directive.Alert extends Directive
  ###
  Initialize the directive
  ###
  initialize: ->
    super
    ###
    Holds the selector events that should invoke triggers
    ###
    @selectorEvents = [
      ["form[#{@director.prefix}alert]", "submit"]
      ["input[#{@director.prefix}alert], textarea[#{@director.prefix}alert], select[#{@director.prefix}alert]", "change"]
      ["*[#{@director.prefix}alert]:not(form, input, textarea, select)", "click"]
    ]
    this


  ###
  Handles a trigger event
  ###
  handleEvent: (e, attributes) =>
    alert attributes.alert
