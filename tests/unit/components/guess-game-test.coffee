`import { test, skip, moduleForComponent } from 'ember-qunit'`
`import Game from 'Game'`

moduleForComponent 'guess-game',
  needs: []

test 'it renders', (assert) ->
  assert.expect 2

  # Creates the component instance
  component = @subject()
  assert.equal component._state, 'preRender'

  # Renders the component to the page
  @render()
  assert.equal component._state, 'inDOM'

test 'Has .game div', (assert) ->
  assert.ok @$().find('.game').length

test 'Has no .game.result div', (assert) ->
  assert.ok @$().find('.game .result').length == 0

test 'Has .game.result div when answer isnt 0', (assert) ->
  @subject().set('answer', 'answer')
  assert.ok @$().find('.game .result').length

test 'Has .game .input', (assert) ->
  assert.ok @$().find('.game input[name="number"]').length

test 'Has .game .submit button', (assert) ->
  assert.ok @$().find('.game .submit').length

test 'Has counter', (assert) ->
  assert.ok @$().find('.game .counter').length

test 'Has div that wraps input and submit', (assert) ->
  assert.ok @$().find('.game .gameProgress').length

test 'Has Play Again button', (assert) ->
  assert.ok @$().find('.game .playAgain').length

test 'Right answer guessed', (assert) ->
  component = @subject()
  component.set('game', new Game(20))

  component.set('guessValue', 20)

  assert.equal component.get('answer'), 'You guessed right'

test 'Bigger number answer guessed', (assert) ->
  component = @subject()
  component.set('game', new Game(10))

  component.set('guessValue', 20)

  assert.equal component.get('answer'), 'The number is smaller'

test 'Smaller number answer guessed', (assert) ->
  component = @subject()
  component.set('game', new Game(10))

  component.set('guessValue', 5)

  assert.equal component.get('answer'), 'The number is bigger'

test 'Get count number', (assert) ->
  component = @subject()
  component.set('game', new Game(10))

  assert.equal component.get('count'), 0

  component.set('guessValue', 5)
  component.get('answer')
  component.set('guessValue', 10)
  component.get('answer')

  assert.equal component.get('count'), 2

test 'Play again needs to be hidden', (assert) ->
  assert.ok @$('.game .playAgain').is(':hidden')
