//
//  GameScene_Menu.swift
//  BackstreetCat
//
//  Created by Jianhang Yin on 5/11/18.
//  Copyright © 2018 Jianhang. All rights reserved.
//

import SpriteKit
import GameplayKit

enum sceneStage: Int {
    
    case offerFood = 1
    case waitCat   = 2
    case catAppear = 3
    
}

var foodAmount_2 = 0
var foodAmount_3 = 0
var foodAmount_4 = 0
var foodAmount_5 = 0

var foodNumber = 1

var gameStage = sceneStage.offerFood

class GameScene_Menu: SKScene {
    
    let startLabel = SKLabelNode(fontNamed: "RussoOne-Regular")

    override func didMove(to view: SKView) {
        initialization()
    }
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        startgame(touches: touches)
    }
    
    func initialization() {
        
        let defaultAmount = UserDefaults()
        let recordAmount2 = defaultAmount.integer(forKey: "Amount2Saved")
        let recordAmount3 = defaultAmount.integer(forKey: "Amount3Saved")
        let recordAmount4 = defaultAmount.integer(forKey: "Amount4Saved")
        let recordAmount5 = defaultAmount.integer(forKey: "Amount5Saved")
        let recordNumber  = defaultAmount.integer(forKey: "NumberSaved")

        
        foodAmount_2 = recordAmount2
        foodAmount_3 = recordAmount3
        foodAmount_4 = recordAmount4
        foodAmount_5 = recordAmount5
        if recordNumber != 0 {
            foodNumber = recordNumber
        }
        
        let defaultStage = UserDefaults()
        let recordStage = defaultStage.integer(forKey: "stageSaved")
        if recordStage != 0 {
            gameStage = sceneStage(rawValue: recordStage)!
        }
        
        let backGround = SKSpriteNode(imageNamed: "background_menu")
        backGround.name = "Background"
        backGround.size = self.size
        backGround.position = CGPoint(x: self.size.width * 0.5, y: self.size.height * 0.5)
        backGround.zPosition = 0
        self.addChild(backGround)
        
        let gameLabel1 = SKLabelNode(fontNamed: "RussoOne-Regular")
        gameLabel1.numberOfLines = 2
        gameLabel1.text = "BACK"
        gameLabel1.fontSize = 200
        gameLabel1.fontColor = SKColor.white
        gameLabel1.position = CGPoint(x: self.size.width / 2, y: self.size.height * 0.75)
        gameLabel1.zPosition = 2
        self.addChild(gameLabel1)
        
        let gameLabel1s = SKLabelNode(fontNamed: "RussoOne-Regular")
        gameLabel1s.numberOfLines = 2
        gameLabel1s.text = "BACK"
        gameLabel1s.fontSize = 200
        gameLabel1s.fontColor = SKColor.black
        gameLabel1s.position = CGPoint(x: self.size.width / 2 - 10, y: self.size.height * 0.75 - 10)
        gameLabel1s.zPosition = 1
        self.addChild(gameLabel1s)
        
        let gameLabel3 = SKLabelNode(fontNamed: "RussoOne-Regular")
        gameLabel3.numberOfLines = 2
        gameLabel3.text = "STREET"
        gameLabel3.fontSize = 200
        gameLabel3.fontColor = SKColor.white
        gameLabel3.position = CGPoint(x: self.size.width / 2, y: self.size.height * 0.65)
        gameLabel3.zPosition = 2
        self.addChild(gameLabel3)
        
        let gameLabel3s = SKLabelNode(fontNamed: "RussoOne-Regular")
        gameLabel3s.numberOfLines = 2
        gameLabel3s.text = "STREET"
        gameLabel3s.fontSize = 200
        gameLabel3s.fontColor = SKColor.black
        gameLabel3s.position = CGPoint(x: self.size.width / 2 - 10, y: self.size.height * 0.65 - 10)
        gameLabel3s.zPosition = 1
        self.addChild(gameLabel3s)
        
        let gameLabel2 = SKLabelNode(fontNamed: "RussoOne-Regular")
        gameLabel2.numberOfLines = 2
        gameLabel2.text = "CAT"
        gameLabel2.fontSize = 200
        gameLabel2.fontColor = SKColor.white
        gameLabel2.position = CGPoint(x: self.size.width / 2, y: self.size.height * 0.55)
        gameLabel2.zPosition = 2
        self.addChild(gameLabel2)
        
        let gameLabel2s = SKLabelNode(fontNamed: "RussoOne-Regular")
        gameLabel2s.numberOfLines = 2
        gameLabel2s.text = "CAT"
        gameLabel2s.fontSize = 200
        gameLabel2s.fontColor = SKColor.black
        gameLabel2s.position = CGPoint(x: self.size.width / 2 - 10, y: self.size.height * 0.55 - 10)
        gameLabel2s.zPosition = 1
        self.addChild(gameLabel2s)
        
        startLabel.text = "START"
        startLabel.fontSize = 180
        startLabel.fontColor = SKColor.white
        startLabel.position = CGPoint(x: self.size.width / 2, y: self.size.height * 0.20)
        startLabel.zPosition = 2
        self.addChild(startLabel)
        
        let startLabels = SKLabelNode(fontNamed: "RussoOne-Regular")
        startLabels.text = "START"
        startLabels.fontSize = 180
        startLabels.fontColor = SKColor.black
        startLabels.position = CGPoint(x: self.size.width / 2 - 10, y: self.size.height * 0.20 - 10)
        startLabels.zPosition = 1
        self.addChild(startLabels)
    }
    
    func startgame(touches: Set<UITouch>) {
        
        for touch in touches {
            let location = touch.location(in: self)
            if startLabel.contains(location) {
                changeScene()
            }
        }
        
    }
    
    func changeScene() {
        let targetscene = GameScene_Street(size: self.size)
        targetscene.scaleMode = self.scaleMode
        let scenetransition = SKTransition.fade(withDuration: 0.1)
        self.view!.presentScene(targetscene, transition: scenetransition)
        view?.showsPhysics = false
    }
}












