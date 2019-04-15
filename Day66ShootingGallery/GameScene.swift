//
//  GameScene.swift
//  Day66ShootingGallery
//
//  Created by Daniel O'Leary on 4/9/19.
//  Copyright © 2019 Impulse Coupled Dev. All rights reserved.
//

import SpriteKit
import GameplayKit

class GameScene: SKScene, SKPhysicsContactDelegate {
    
    let possibleEnemies = ["duckLeft", "duckRight"]
    let possibleFriendly = ["dogLeft", "dogRight"]
    
    var gameIsOver = false
    var gameTimer: Timer?
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
        
        
//        let dog = SKSpriteNode(imageNamed: "dogRight")
//        dog.position = CGPoint(x: 432, y: 65)
//        addChild(dog)
        
        gameScore = SKLabelNode(fontNamed: "Chalkduster")
        gameScore?.text = "Score: 0"
        gameScore?.position = CGPoint(x: 8, y: 720)
        gameScore?.horizontalAlignmentMode = .left
        gameScore?.fontSize = 38
        addChild(gameScore)
        
        gameTimer = Timer.scheduledTimer(timeInterval: 1.5, target: self, selector: #selector(createEnemy), userInfo: nil, repeats: true)
        gameTimer = Timer.scheduledTimer(timeInterval: 6.0, target: self, selector: #selector(createFriendly), userInfo: nil, repeats: true)
        
    }
    
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        guard let touch = touches.first else { return }
        let location = touch.location(in: self)
        let tappedNode = nodes(at: location)
        
        for node in tappedNode {
            guard let hitNode = node as? SKSpriteNode else { continue }
            if hitNode.name == "duckLeft" || hitNode.name == "duckRight" {
                score += 1
                hit(node: hitNode)
            } else if hitNode.name == "dogLeft" || hitNode.name == "dogRight" {
                score -= 1
                hit(node: hitNode)
            }
        }
        
       
    }
    
    override func update(_ currentTime: TimeInterval) {
        // remove nodes from the scene when they are off screen.
        for node in children {
            if node.position.x < -200 || node.position.x > 1300 {
                node.removeFromParent()
            }
        }
    }
    

    @objc func createEnemy() {
        guard let enemy = possibleEnemies.randomElement() else { return }
        let sprite = SKSpriteNode(imageNamed: enemy)
        
        switch enemy {
        case "duckLeft":
            sprite.position = CGPoint(x: 1200, y: Int.random(in: 40...536))
            sprite.physicsBody = SKPhysicsBody(texture: sprite.texture!, size: sprite.size)
            sprite.physicsBody?.categoryBitMask = 0
            sprite.physicsBody?.velocity = CGVector(dx: Int.random(in: -825 ... -655) , dy: 0)
            sprite.name = enemy
            addChild(sprite)
        case "duckRight":
            sprite.position = CGPoint(x: -100, y: Int.random(in: 50...636))
            sprite.physicsBody = SKPhysicsBody(texture: sprite.texture!, size: sprite.size)
            sprite.physicsBody?.categoryBitMask = 0
            sprite.physicsBody?.velocity = CGVector(dx: Int.random(in: 375...500), dy: 0)
            sprite.name = enemy
            addChild(sprite)
        default:
            return
        }
    }
    
    @objc func createFriendly() {
        guard let friendly = possibleFriendly.randomElement() else { return }
        let sprite = SKSpriteNode(imageNamed: friendly)
        
        switch friendly {
        case "dogLeft":
            sprite.position = CGPoint(x: 1200, y: 65)
            sprite.physicsBody = SKPhysicsBody(texture: sprite.texture!, size: sprite.size)
            sprite.physicsBody?.categoryBitMask = 0
            sprite.physicsBody?.velocity = CGVector(dx: Int.random(in: -670 ... -550) , dy: 0)
            sprite.name = friendly
            addChild(sprite)
        case "dogRight":
            sprite.position = CGPoint(x: -100, y: 65)
            sprite.physicsBody = SKPhysicsBody(texture: sprite.texture!, size: sprite.size)
            sprite.physicsBody?.categoryBitMask = 0
            sprite.physicsBody?.velocity = CGVector(dx: Int.random(in: 600...800) , dy: 0)
            sprite.name = friendly
            addChild(sprite)
        default:
            return
        }
    }
    
    func hit(node: SKSpriteNode) {
        if node.name == "duckLeft" || node.name == "duckRight" {
            if let emitter = SKEmitterNode(fileNamed: "feathers") {
                emitter.position = node.position
                addChild(emitter)
            }
            let rotate = SKAction.rotate(byAngle: -.pi, duration: 0.25)
            let rotateForever = SKAction.repeatForever(rotate)
            let fallFromSky = SKAction.moveBy(x: 0, y: -900, duration: 2.5)
            
            node.run(rotateForever)
            node.run(fallFromSky) {
                node.removeFromParent()
            }
        } else if node.name == "dogLeft" || node.name == "dogRight" {
            if let emitter = SKEmitterNode(fileNamed: "FireParticles") {
                emitter.position = node.position
                addChild(emitter)
            }
            node.removeFromParent()
        }
        
//        node.run(SKAction.sequence([delay, rotate, fallFromSky]))

    }
    
    
}
