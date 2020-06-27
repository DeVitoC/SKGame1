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
        
    }
}
