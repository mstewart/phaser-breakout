

this.Breakout = {}

create_bricks = (game) ->
  bricks = game.add.group()
  bricks.enableBody = true
  bricks.physicsBodyType = Phaser.Physics.ARCADE

  origin = [100, 100]
  stepsize = [50, 50]

  for i in [1..10]
    for j in [1..5]
      brick = bricks.create(origin[0] + stepsize[0] * i,
                            origin[1] + stepsize[1] * j,
                            'block')
      brick.body.immovable = true
  return bricks

create_paddle = (game) ->
  paddle = game.add.sprite(game.width / 2, 500, 'paddle')
  paddle.anchor.set(0.5)
  game.physics.enable(paddle, Phaser.Physics.ARCADE)
  paddle.body.immovable = true
  return paddle

create_ball = (game) ->
  ball = game.add.sprite(game.width / 2, 450, 'ball')
  ball.anchor.set(0.5)
  game.physics.enable(ball, Phaser.Physics.ARCADE)
  ball.body.velocity.x = 20
  ball.body.velocity.y = -200
  ball.body.bounce.set(1)
  return ball


preload = ->
  images = ['block', 'paddle', 'ball']
  for key in images
    Breakout.game.load.image(key, 'assets/' + key + '.png')
 

update = ->
  Breakout.paddle.x = Breakout.game.input.x

  brick_collision = (ball, brick) ->
    brick.kill()

  # Trigger collisions.
  Breakout.game.physics.arcade.collide(Breakout.ball, Breakout.bricks, brick_collision)
  Breakout.game.physics.arcade.collide(Breakout.ball, Breakout.paddle)


create = ->
  game = Breakout.game
  game.physics.startSystem(Phaser.Physics.ARCADE)
  Breakout.bricks = create_bricks(game)
  Breakout.paddle = create_paddle(game)
  Breakout.ball = create_ball(game)



# Globals:
Breakout.game = new Phaser.Game(800, 600, Phaser.AUTO, 'phaser-example', { create: create, update: update, preload: preload })
