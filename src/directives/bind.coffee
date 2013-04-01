###
# Directive: Bind

Triggers an action when an element is clicked on or changed by the user.

###
class Directive.Trigger extends Directive
  ###
  Initialize the directive
  ###
  initialize: ->
    super
    ###
    Holds the selector events that should invoke triggers
    ###
    @selectorEvents = [
      ["form[#{@director.prefix}trigger]", "submit"]
      ["input[#{@director.prefix}trigger], textarea[#{@director.prefix}trigger], select[#{@director.prefix}trigger]", "change"]
      ["*[#{@director.prefix}trigger]:not(form, input, textarea, select)", "click"]
    ]
    this

  ###
  Handles a trigger event
  ###
  handleEvent: (e, attributes) =>
    e.preventDefault() if e.type is "click" or e.type is "submit"
    $el = $(e.target)
    if attributes.target?
      subject = @findNearest $el, attributes.target, true
    else
      subject = $el
    subject[attributes.trigger].apply subject, attributes.args or []
