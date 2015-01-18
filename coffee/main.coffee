
create_brick = (bricks_group, i, j) ->
  origin = [100, 100]
  stepsize = [50, 50]
  bricks_group.create(origin[0] + stepsize[0] * i,
                      origin[1] + stepsize[1] * j,
                      'block')

preload = ->
  game.load.image('block', 'assets/block.png')
 
update = ->

create = ->
  game.physics.startSystem(Phaser.Physics.ARCADE)

  bricks = game.add.group()
  bricks.enableBody = true
  bricks.physicsBodyType = Phaser.Physics.ARCADE

  for i in [1..10]
    for j in [1..5]
      create_brick(bricks, i,j)


# Globals: (game,)
game = new Phaser.Game(800, 600, Phaser.AUTO, 'phaser-example', { create: create, update: update, preload: preload })
