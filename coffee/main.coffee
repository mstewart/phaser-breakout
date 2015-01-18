

Breakout = {}

create_bricks = (game) ->
  bricks = game.add.group()
  bricks.enableBody = true
  bricks.physicsBodyType = Phaser.Physics.ARCADE

  origin = [100, 100]
  stepsize = [50, 50]

  for i in [1..10]
    for j in [1..5]
      bricks.create(origin[0] + stepsize[0] * i,
                    origin[1] + stepsize[1] * j,
                    'block')
  return bricks

create_paddle = (game) ->
  paddle = game.add.sprite(100, 500, 'paddle')
  paddle.anchor.set(0.5)
  return paddle



preload = ->
  game = Breakout.game
  game.load.image('block', 'assets/block.png')
  game.load.image('paddle', 'assets/paddle.png')
 

update = ->
  Breakout.paddle.x = Breakout.game.input.x


create = ->
  game = Breakout.game
  game.physics.startSystem(Phaser.Physics.ARCADE)
  Breakout.bricks = create_bricks(game)
  Breakout.paddle = create_paddle(game)



# Globals:
Breakout.game = new Phaser.Game(800, 600, Phaser.AUTO, 'phaser-example', { create: create, update: update, preload: preload })
