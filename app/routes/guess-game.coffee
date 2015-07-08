`import Ember from 'ember'`

GuessGameRoute = Ember.Route.extend({
  queryParams:
    number: {}

  model: (params, transition) ->
    transition.queryParams
})

`export default GuessGameRoute`
