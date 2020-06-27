//
//  GameScene.swift
//  SKGame1
//
//  Created by Christopher Devito on 6/27/20.
//  Copyright © 2020 Christopher Devito. All rights reserved.
//

import SpriteKit
import GameplayKit

class GameScene: SKScene {

    // MARK: - Properties
    let player = SKSpriteNode(imageNamed: "player-rocket.png")
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
        player.position.x = -((view.frame.width / 2) - 20)
        player.zPosition = 1
        addChild(player)

        gameTimer = Timer.scheduledTimer(timeInterval: 0.50, target: self, selector: #selector(createEnemy), userInfo: nil, repeats: true)
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

    @objc func createEnemy() {
        let sprite = SKSpriteNode(imageNamed: "asteroid")
        let halfHeight = Int((view?.frame.height ?? 700) / 2)
        let halfWidth = Int((view?.frame.width ?? 1200) / 2)
        sprite.position = CGPoint(x: halfWidth, y: Int.random(in: -halfHeight...halfHeight))
        sprite.name = "enemy"
        sprite.zPosition = 1
        addChild(sprite)

        sprite.physicsBody = SKPhysicsBody(texture: sprite.texture!, size: sprite.size)
        sprite.physicsBody?.velocity = CGVector(dx: -500, dy: 0)
        sprite.physicsBody?.linearDamping = 0
        sprite.physicsBody?.affectedByGravity = false
    }
}
