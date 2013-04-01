###
# Director.coffee
###

###
Creates / Returns the director instance for the
given scope
###
module.exports = director = (scope = $("body"), config) ->
  for instance in director.instances
    if instance.scope is scope
      instance.configure config if config?
      return instance
  config = {} unless config?
  config.scope or= scope
  instance = new Director config
  director.instances.push instance
  instance




###
Holds the director instances
###
director.instances = []
