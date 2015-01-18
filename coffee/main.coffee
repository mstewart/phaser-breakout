
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

preload = ->
  game.load.image('block', 'assets/block.png')
 
update = ->

create = ->
  game.physics.startSystem(Phaser.Physics.ARCADE)
  bricks = create_bricks(game)


# Globals: (game,)
game = new Phaser.Game(800, 600, Phaser.AUTO, 'phaser-example', { create: create, update: update, preload: preload })
