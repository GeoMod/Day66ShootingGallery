//
//  GameScene.swift
//  Day66ShootingGallery
//
//  Created by Daniel O'Leary on 4/9/19.
//  Copyright © 2019 Impulse Coupled Dev. All rights reserved.
//

import SpriteKit
import GameplayKit

class GameScene: SKScene {
    
    var gameScore: SKLabelNode!
    var score = 0 {
        didSet {
            gameScore?.text = "Score: \(score)"
        }
    }
    
    
    override func didMove(to view: SKView) {
        let background = SKSpriteNode(imageNamed: "background")
        background.position = CGPoint(x: 512, y: 384)
        background.blendMode = .replace
        background.zPosition = -1
        addChild(background)
        
        let grass = SKSpriteNode(imageNamed: "grass")
        grass.position = CGPoint(x: 512, y: 88)
        grass.zPosition = -0.8
        addChild(grass)
        
        // For demo purposes
        let duckRight = SKSpriteNode(imageNamed: "duckRight")
        duckRight.position = CGPoint(x: 768, y: 502)
        addChild(duckRight)
        
        let duckLeft = SKSpriteNode(imageNamed: "duckLeft")
        duckLeft.position = CGPoint(x: 200, y: 600)
        addChild(duckLeft)
        
        let dog = SKSpriteNode(imageNamed: "dogSniff")
        dog.position = CGPoint(x: 432, y: 65)
        addChild(dog)
        
        
        gameScore = SKLabelNode(fontNamed: "Chalkduster")
        gameScore?.text = "Score: 0"
        gameScore?.position = CGPoint(x: 8, y: 720)
        gameScore?.horizontalAlignmentMode = .left
        gameScore?.fontSize = 38
        addChild(gameScore)
        
   
    }
    
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
       
    }
    
    override func touchesMoved(_ touches: Set<UITouch>, with event: UIEvent?) {
    }
    
    override func update(_ currentTime: TimeInterval) {
        // Called before each frame is rendered
    }
}
