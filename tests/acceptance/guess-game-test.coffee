`import Ember from 'ember'`
`import { module, test } from 'qunit'`
`import startApp from '../helpers/start-app'`

application = null

module 'Acceptance: GuessGame',
  beforeEach: ->
    application = startApp()
    ###
    Don't return as Ember.Application.then is deprecated.
    Newer version of QUnit uses the return value's .then
    function to wait for promises if it exists.
    ###
    return

  afterEach: ->
    Ember.run application, 'destroy'

makeGuess = (number)->
  fillIn 'input[name="number"]', number
  click '.game .submit'
  return

test 'visiting /guess-game', (assert) ->
  visit '/guess-game'

  andThen ->
    assert.equal currentPath(), 'guess-game'

test 'Guessing right number', (assert) ->
  visit '/guess-game?number=20'

  makeGuess('20')

  andThen ->
    assert.equal(find('.result').text(), 'You guessed right')

test 'Guessing right number from fourth time', (assert) ->
  visit '/guess-game?number=20'

  makeGuess('40')

  andThen ->
    assert.equal(find('.result').text(), 'The number is smaller')
    assert.equal(find('.counter').text(), '1')

  makeGuess('30')

  andThen ->
    assert.equal(find('.result').text(), 'The number is smaller')
    assert.equal(find('.counter').text(), '2')

  makeGuess('10')

  andThen ->
    assert.equal(find('.result').text(), 'The number is bigger')
    assert.equal(find('.counter').text(), '3')

  makeGuess('20')

  andThen ->
    assert.equal(find('.result').text(), 'You guessed right')
    assert.equal(find('.counter').text(), '4')

test 'When game is over div gameProgress becomes hidden and playAgain becomes vissible', (assert) ->
  visit '/guess-game?number=20'

  makeGuess('20')

  andThen ->
    assert.ok find('.game .gameProgress').is(':hidden')
    assert.ok find('.game .playAgain').is(':visible')

test 'When Play Again pressed create new game', (assert) ->
  visit '/guess-game?number=30'

  makeGuess('30')
  click '.game .playAgain'

  andThen ->
    assert.equal find('.counter').text(), '0'
