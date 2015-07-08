`import Ember from 'ember'`
`import Game from 'Game'`

GuessGameComponent = Ember.Component.extend({

  hideButton: (->
    @$('.game .playAgain').hide()
  ).on('didInsertElement')

  game: Ember.computed( ->
    initial = @get('initialNumber') || @randomNumber()
    new Game(initial)
  )

  count: ( ->
      @get('game').getGuessesCount()
    ).property('guessValue', 'game')

  answer: ( ->
    guessingAnswer = @get('game').aGuess(@get('guessValue'))
    if(@get('game').isGameOver())
      @toggleVisibility()
      @set 'isGameOver', true
      return guessingAnswer
    else guessingAnswer

  ).property('guessValue', )

  randomNumber: ->
    Math.floor Math.random() * 100 + 1


  toggleVisibility: ->
    $('.game .gameProgress').toggle()
    $('.game .playAgain').toggle()

  actions:
    performGuess: ->
      gValue = @$('input[name="number"]').val()
      @$('input[name="number"]').select()
      lastGuessValue = @get('guessValue')
      if (lastGuessValue == gValue)
        return
      @set 'guessValue', gValue
    newGame: ->
      @toggleVisibility()
      @set 'isGameOver', false
      @set 'game', new Game(@randomNumber())
      @set 'guessValue', ''
})

`export default GuessGameComponent`
