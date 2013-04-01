###
# Directive: Confirm

Triggers a confirmation box that will prevent subsequent
actions from occuring unless the user clicks `Yes`
###
class Directive.Confirm extends Directive
  ###
  Initialize the directive
  ###
  initialize: ->
    super
    ###
    Holds the selector events that should invoke triggers
    ###
    @selectorEvents = [
      ["form[#{@director.prefix}confirm]", "submit"]
      ["input[#{@director.prefix}confirm], textarea[#{@director.prefix}confirm], select[#{@director.prefix}confirm]", "change"]
      ["*[#{@director.prefix}confirm]:not(form, input, textarea, select)", "click"]
    ]
    this


  ###
  Handles a trigger event
  ###
  handleEvent: (e, attributes) =>
    unless confirm attributes.confirm
      e.preventDefault()
      e.stopPropagation()
      false
    else
      true
