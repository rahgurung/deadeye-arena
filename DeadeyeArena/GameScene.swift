//
//  GameScene.swift
//  Deadeye Arena
//
//  Created by Rahul Gurung on 26/01/25.
//

import SpriteKit

class GameScene: SKScene {
    var bulletsSprite: SKSpriteNode!
    var bulletTextures = [
        SKTexture(imageNamed: "shots0"),
        SKTexture(imageNamed: "shots1"),
        SKTexture(imageNamed: "shots2"),
        SKTexture(imageNamed: "shots3"),
    ]
    var score = 0 {
        didSet {
            scoreLabel.text = "Score: \(score)"
        }
    }

    var scoreLabel: SKLabelNode!
    var targetSpeed = 4.0
    var targetDelay = 0.8
    var targetsCreated = 0

    var isGameOver = false
    
    override func didMove(to view: SKView) {
        createBackground()
        createWater()
        createOverlay()
        
        levelUp()
    }
    
    private func createBackground() {
        // create background
        let background = SKSpriteNode(imageNamed: "wood-background")
        background.position = CGPoint(x: self.size.width/2, y: self.size.height/2)
        background.size = self.size
        background.blendMode = .replace
        addChild(background)

        let grass = SKSpriteNode(imageNamed: "grass-trees")
        grass.position = CGPoint(x: self.size.width/2, y: self.size.height/2)
        grass.zPosition = 100
        grass.size = CGSize(width: self.size.width, height: 400)
        addChild(grass)
    }
    
    private func createWater() {
        func animate(_ node: SKNode, distance: CGFloat, duration: TimeInterval) {
            let movementUp = SKAction.moveBy(x: 0, y: distance, duration: duration)
            let movementDown = movementUp.reversed()
            let sequence = SKAction.sequence([movementUp, movementDown])
            let repeatForever = SKAction.repeatForever(sequence)
            node.run(repeatForever)
        }

        let waterBackground = SKSpriteNode(imageNamed: "water-bg")
        waterBackground.position = CGPoint(x: self.size.width/2, y: self.size.height/5)
        waterBackground.size = CGSize(width: self.size.width, height: 400)
        waterBackground.zPosition = 200
        addChild(waterBackground)

        let waterForeground = SKSpriteNode(imageNamed: "water-fg")
        waterForeground.position = CGPoint(x: self.size.width/2, y: self.size.height/20)
        waterForeground.size = CGSize(width: self.size.width, height: 400)
        waterForeground.zPosition = 300
        addChild(waterForeground)

        animate(waterBackground, distance: 8, duration: 1.3)
        animate(waterForeground, distance: 12, duration: 1)
    }
    
    private func createOverlay() {
        let curtains = SKSpriteNode(imageNamed: "curtains")
        curtains.position = CGPoint(x: self.size.width/2, y: self.size.height/2)
        curtains.zPosition = 400
        curtains.size = self.size
        addChild(curtains)

        bulletsSprite = SKSpriteNode(imageNamed: "shots3")
        bulletsSprite.position = CGPoint(x: 170, y: 60)
        bulletsSprite.zPosition = 500
        addChild(bulletsSprite)

        scoreLabel = SKLabelNode(fontNamed: "Chalkduster")
        scoreLabel.horizontalAlignmentMode = .right
        scoreLabel.position = CGPoint(x: 680, y: 50)
        scoreLabel.zPosition = 500
        scoreLabel.text = "Score: 0"
        addChild(scoreLabel)
    }
    
    private func levelUp() {
        targetSpeed *= 0.99
        targetDelay *= 0.99
        targetsCreated += 1

        if targetsCreated < 100 {
            DispatchQueue.main.asyncAfter(deadline: .now() + targetDelay) { [unowned self] in
                self.createTarget()
            }
        } else {
            DispatchQueue.main.asyncAfter(deadline: .now() + 2) { [unowned self] in
                self.gameOver()
            }
        }
    }
    
    private func createTarget() {
        // create targets
        
    }
    
    private func gameOver() {
        // over the game
    }

    override func update(_ currentTime: TimeInterval) {
        // Called before each frame is rendered
    }
}
