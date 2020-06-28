//
//  GameScene.swift
//  SKGame1
//
//  Created by Christopher Devito on 6/27/20.
//  Copyright © 2020 Christopher Devito. All rights reserved.
//

import SpriteKit
//import GameplayKit

@objcMembers
class GameScene: SKScene, SKPhysicsContactDelegate {

    // MARK: - Properties
    var player = SKSpriteNode(imageNamed: "player-rocket.png")
    var touchingPlayer = false
    var gameTimer: Timer?

    override func didMove(to view: SKView) {
        // this method is called when your game scene is ready to run
        let background = SKSpriteNode(imageNamed: "space.jpg")
        background.zPosition = -1
        addChild(background)

        if let particles = SKEmitterNode(fileNamed: "SpaceDust") {
            particles.position.x = view.frame.width/2
            particles.advanceSimulationTime(10)
            addChild(particles)
        }

        let texture = SKTexture(imageNamed: "player-rocket.png")
        texture.size()
        let renderedTexture = view.texture(from: SKSpriteNode(texture: texture))!
        addPlayer(renderedTexture, view: view)

        gameTimer = Timer.scheduledTimer(timeInterval: 0.50, target: self, selector: #selector(createEnemy), userInfo: nil, repeats: true)
    }

    func addPlayer(_ texture: SKTexture, view: SKView) {
        player = SKSpriteNode(texture: texture)
        player.position.x = -((view.frame.width / 2) - 20)
        player.zPosition = 1
        player.name = "player"
        addChild(player)

        player.physicsBody = SKPhysicsBody(texture: texture, size: texture.size())
        player.physicsBody!.categoryBitMask = 1
        physicsWorld.contactDelegate = self
        player.physicsBody!.contactTestBitMask = 0
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        // this method is called when the user touches the screen
        guard let touch = touches.first else { return }
        let location = touch.location(in: self)
        let  tappedNodes = nodes(at: location)
        if tappedNodes.contains(player) {
            touchingPlayer = true
        }
    }

    override func touchesMoved(_ touches: Set<UITouch>, with event: UIEvent?) {
        guard touchingPlayer, let touch = touches.first else { return }

        let location = touch.location(in: self)
        player.position = location
    }

    override func touchesEnded(_ touches: Set<UITouch>, with event: UIEvent?) {
        // this method is called whtn the user stops touching the screen
        touchingPlayer = false
    }

    override func update(_ currentTime: TimeInterval) {
        // Called before each frame is rendered
    }

    func createEnemy() {
        let sprite = SKSpriteNode(imageNamed: "asteroid")
        let halfHeight = Int((view?.frame.height ?? 700) / 2)
        let halfWidth = Int((view?.frame.width ?? 1200) / 2)
        sprite.position = CGPoint(x: halfWidth, y: Int.random(in: -halfHeight...halfHeight))
        sprite.name = "enemy"
        sprite.zPosition = 1
        addChild(sprite)

        sprite.physicsBody = SKPhysicsBody(texture: sprite.texture!, size: sprite.size)
        sprite.physicsBody!.velocity = CGVector(dx: -500, dy: 0)
        sprite.physicsBody!.linearDamping = 0
        sprite.physicsBody!.affectedByGravity = false
        sprite.physicsBody!.categoryBitMask = 0
        sprite.physicsBody!.contactTestBitMask = 1
    }

    func didBegin(_ contact: SKPhysicsContact) {
        print("before the guard let in didBegin")
        guard let nodeA = contact.bodyA.node, let nodeB = contact.bodyB.node else { return }
        print("passed the guard let in didBegin")

        if nodeA == player {
            playerHit(nodeB)
        } else {
            playerHit(nodeA)
        }
    }

    func playerHit(_ node: SKNode) {
        print("inside playerHit")
        player.removeFromParent()
    }
}
