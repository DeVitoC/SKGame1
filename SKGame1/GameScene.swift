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

    override func didMove(to view: SKView) {
        // this method is called when your game scene is ready to run
        let background = SKSpriteNode(imageNamed: "space.jpg")
        background.zPosition = -1
        addChild(background)
        if let particles = SKEmitterNode(fileNamed: "SpaceDust") {
            particles.position.x = 512
            particles.advanceSimulationTime(10)
            addChild(particles)
        }
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        // this method is called when the user touches the screen
    }

    override func touchesEnded(_ touches: Set<UITouch>, with event: UIEvent?) {
        // this method is called whtn the user stops touching the screen
    }

    override func update(_ currentTime: TimeInterval) {
        // Called before each frame is rendered
    }
}
