

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
  game.physics.enable(ball, Phaser.Physics.ARCADE)
  ball.anchor.set(0.5)
  ball.body.velocity.x = 20
  ball.body.velocity.y = -200
  ball.body.collideWorldBounds = true
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
  paddle_collision = (ball, paddle) ->
    # Adjust ball x velocity depending on closeness to paddle midpoint when rebounding.
    x_delta = ball.x - paddle.x
    velocity = ball.body.velocity.x + x_delta * 5

    # Limit it to some max speed.
    max_speed = 300
    velocity = Math.min(max_speed, velocity)
    velocity = Math.max(-1 * max_speed, velocity)

    ball.body.velocity.x = velocity


  # Trigger collisions.
  Breakout.game.physics.arcade.collide(Breakout.ball, Breakout.bricks, brick_collision)
  Breakout.game.physics.arcade.collide(Breakout.ball, Breakout.paddle, paddle_collision)


create = ->
  game = Breakout.game
  game.physics.startSystem(Phaser.Physics.ARCADE)
  Breakout.bricks = create_bricks(game)
  Breakout.paddle = create_paddle(game)
  Breakout.ball = create_ball(game)

  game.physics.arcade.checkCollision.down = false


# Globals:
Breakout.game = new Phaser.Game(800, 600, Phaser.AUTO, 'phaser-example', { create: create, update: update, preload: preload })
