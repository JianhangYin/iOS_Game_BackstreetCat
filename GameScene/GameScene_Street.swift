//
//  GameScene_Street.swift
//  BackstreetCat
//
//  Created by Jianhang Yin on 5/11/18.
//  Copyright © 2018 Jianhang. All rights reserved.
//

import SpriteKit
import GameplayKit

class GameScene_Street: SKScene {
    
    let catNode = SKSpriteNode(imageNamed: "cat_1_1")
    let lightSource = SKLightNode()
    let arrowL = SKSpriteNode(imageNamed: "arrow_l")
    let arrowR = SKSpriteNode(imageNamed: "arrow_r")
    let heartNode = SKSpriteNode(imageNamed: "heart")

    var catKind = 0
    
    let foodNode = SKSpriteNode(imageNamed: "food_\(foodNumber)")
    
    let clickSound = SKAction.playSoundFileNamed("click.wav", waitForCompletion: false)
    let wrongSound = SKAction.playSoundFileNamed("wrong.wav", waitForCompletion: false)
    let bowlSound = SKAction.playSoundFileNamed("bowl.wav", waitForCompletion: false)
    let catSound = SKAction.playSoundFileNamed("Meow.mp3", waitForCompletion: false)

    let foodLabel = SKLabelNode(fontNamed: "RussoOne-Regular")

    override func didMove(to view: SKView) {
        
        initialization()
        
    }
    override func touchesMoved(_ touches: Set<UITouch>, with event: UIEvent?) {
        movemode(touches: touches, targetNode: lightSource)
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        if gameStage == sceneStage.offerFood {
            selectFood(touches: touches)
        }
        if gameStage == sceneStage.catAppear {
            selectCat(touches: touches)
        }
    }
    
    func initialization() {
        
        let backGround = SKSpriteNode(imageNamed: "background", normalMapped: true)
        backGround.name = "Background"
        backGround.size = self.size
        backGround.position = CGPoint(x: self.size.width * 0.5, y: self.size.height * 0.5)
        backGround.zPosition = 0
        backGround.lightingBitMask = 1
        backGround.shadowCastBitMask = 0
        backGround.shadowedBitMask = 1
        self.addChild(backGround)
        
        lightSource.categoryBitMask = 1
        lightSource.falloff = 1
        lightSource.ambientColor = SKColor(red: 0.3, green: 0.3, blue: 0.3, alpha: 0.9)
        lightSource.lightColor = SKColor(red: 0.8, green: 0.8, blue: 0.5, alpha: 0.8)
        lightSource.shadowColor = SKColor(red: 0.0, green: 0.0, blue: 0.0, alpha: 0.8)
        lightSource.position = CGPoint(x: self.size.width * 0.5, y: self.size.height * 0.55)
        addChild(lightSource)
        
        let trashBin = SKSpriteNode(imageNamed: "trashbin")
        trashBin.name = "Trashbin"
        trashBin.setScale(1)
        trashBin.position = CGPoint(x: self.size.width * 0.7, y: self.size.height * 0.5)
        trashBin.zPosition = 2
        trashBin.lightingBitMask = 1
        trashBin.shadowCastBitMask = 1
        trashBin.shadowedBitMask = 1
        self.addChild(trashBin)
        
        let currentTime = NSDate()
        
        let defaultsTime = UserDefaults()
        let recordTime = defaultsTime.object(forKey: "timeSaved")
        let lastTime = recordTime
        
        if lastTime != nil {
            let timeInterval = Int(currentTime.timeIntervalSince(lastTime as! Date))
            if timeInterval >= 7200 {
                gameStage = sceneStage.catAppear
            }
        }
        
        if gameStage == sceneStage.offerFood {
            arrowL.name = "ArrowL"
            arrowL.setScale(0.5)
            arrowL.position = CGPoint(x: self.size.width * 0.25, y: self.size.height * 0.4)
            arrowL.zPosition = 3
            self.addChild(arrowL)
            
            arrowR.name = "ArrowR"
            arrowR.setScale(0.5)
            arrowR.position = CGPoint(x: self.size.width * 0.75, y: self.size.height * 0.4)
            arrowR.zPosition = 3
            self.addChild(arrowR)
            
            foodNode.setScale(1)
            foodNode.position = CGPoint(x: self.size.width * 0.5, y: self.size.height * 0.4)
            foodNode.zPosition = 3
            self.addChild(foodNode)
            
            switch foodNumber {
            case 1:
                foodLabel.text = "× ∞"
            case 2:
                foodLabel.text = "× \(foodAmount_2)"
            case 3:
                foodLabel.text = "× \(foodAmount_3)"
            case 4:
                foodLabel.text = "× \(foodAmount_4)"
            default:
                foodLabel.text = "× \(foodAmount_5)"
            }
            foodLabel.fontSize = 150
            foodLabel.fontColor = SKColor.white
            foodLabel.horizontalAlignmentMode = SKLabelHorizontalAlignmentMode.center
            foodLabel.position = CGPoint(x: self.size.width * 0.5, y: self.size.height * 0.2)
            foodLabel.zPosition = 3
            self.addChild(foodLabel)
            
        } else if gameStage == sceneStage.waitCat {
            
            let defaultAmount = UserDefaults()
            let recordNumber = defaultAmount.integer(forKey: "numberSaved")
            if recordNumber != 0 {
                foodNumber = recordNumber
            }
            foodNode.texture = SKTexture(imageNamed: "food_\(foodNumber)")
            foodNode.setScale(1)
            foodNode.position = CGPoint(x: self.size.width * 0.5, y: self.size.height * 0.4)
            foodNode.zPosition = 3
            self.addChild(foodNode)
            
        } else if gameStage == sceneStage.catAppear {
            let diceNum = Int(randomNum(num_1: 1, num_2: 101))
            let defaultAmount = UserDefaults()
            let recordNumber = defaultAmount.integer(forKey: "numberSaved")
            if recordNumber != 0 {
                foodNumber = recordNumber
            }
            
            if diceNum < 81 {
                switch foodNumber {
                case 1:
                    catNode.texture = SKTexture(imageNamed: "cat_1_1")
                    catKind = 1
                case 2:
                    catNode.texture = SKTexture(imageNamed: "cat_2_1")
                    catKind = 2
                case 3:
                    catNode.texture = SKTexture(imageNamed: "cat_3_1")
                    catKind = 3
                case 4:
                    catNode.texture = SKTexture(imageNamed: "cat_4_1")
                    catKind = 4
                default:
                    catNode.texture = SKTexture(imageNamed: "cat_5_1")
                    catKind = 5
                }
            } else if diceNum < 86 {
                switch foodNumber {
                case 1:
                    catNode.texture = SKTexture(imageNamed: "cat_2_1")
                    catKind = 2
                case 2:
                    catNode.texture = SKTexture(imageNamed: "cat_3_1")
                    catKind = 3
                case 3:
                    catNode.texture = SKTexture(imageNamed: "cat_4_1")
                    catKind = 4
                case 4:
                    catNode.texture = SKTexture(imageNamed: "cat_5_1")
                    catKind = 5
                default:
                    catNode.texture = SKTexture(imageNamed: "cat_1_1")
                    catKind = 1
                }
            } else if diceNum < 91 {
                switch foodNumber {
                case 1:
                    catNode.texture = SKTexture(imageNamed: "cat_3_1")
                    catKind = 3
                case 2:
                    catNode.texture = SKTexture(imageNamed: "cat_4_1")
                    catKind = 4
                case 3:
                    catNode.texture = SKTexture(imageNamed: "cat_5_1")
                    catKind = 5
                case 4:
                    catNode.texture = SKTexture(imageNamed: "cat_1_1")
                    catKind = 1
                default:
                    catNode.texture = SKTexture(imageNamed: "cat_2_1")
                    catKind = 2
                }
            } else if diceNum < 96 {
                switch foodNumber {
                case 1:
                    catNode.texture = SKTexture(imageNamed: "cat_4_1")
                    catKind = 4
                case 2:
                    catNode.texture = SKTexture(imageNamed: "cat_5_1")
                    catKind = 5
                case 3:
                    catNode.texture = SKTexture(imageNamed: "cat_1_1")
                    catKind = 1
                case 4:
                    catNode.texture = SKTexture(imageNamed: "cat_2_1")
                    catKind = 2
                default:
                    catNode.texture = SKTexture(imageNamed: "cat_3_1")
                    catKind = 3
                }
            } else if diceNum < 101 {
                switch foodNumber {
                case 1:
                    catNode.texture = SKTexture(imageNamed: "cat_5_1")
                    catKind = 5
                case 2:
                    catNode.texture = SKTexture(imageNamed: "cat_1_1")
                    catKind = 1
                case 3:
                    catNode.texture = SKTexture(imageNamed: "cat_2_1")
                    catKind = 2
                case 4:
                    catNode.texture = SKTexture(imageNamed: "cat_3_1")
                    catKind = 3
                default:
                    catNode.texture = SKTexture(imageNamed: "cat_4_1")
                    catKind = 4
                }
            }
            
            catNode.name = "Cat"
            catNode.setScale(2)
            catNode.position = CGPoint(x: self.size.width * 0.5, y: self.size.height * 0.5)
            catNode.zPosition = 3
            catNode.lightingBitMask = 1
            catNode.shadowCastBitMask = 1
            catNode.shadowedBitMask = 1
            self.addChild(catNode)
            
            catAction()
            
            heartNode.name = "Heart"
            heartNode.setScale(0)
            heartNode.position = CGPoint(x: self.size.width * 0.5, y: self.size.height * 0.6)
            heartNode.zPosition = 1
            heartNode.alpha = 0.8
            heartNode.lightingBitMask = 1
            heartNode.shadowCastBitMask = 1
            heartNode.shadowedBitMask = 1
            self.addChild(heartNode)
            
        }
    
    }
    
    func catAction() {
        
        let catAction = SKAction.animate(with: [SKTexture(imageNamed: "cat_\(catKind)_1"), SKTexture(imageNamed: "cat_\(catKind)_2"), SKTexture(imageNamed: "cat_\(catKind)_3"), SKTexture(imageNamed: "cat_\(catKind)_2")], timePerFrame: 0.2)
        
        catNode.run(SKAction.repeat(catAction, count: -1))
        
    }
    
    
    func movemode(touches: Set<UITouch>, targetNode: SKLightNode) {
        for touch in touches {
            let locationOne = touch.location(in: self)
            let locationTwo = touch.previousLocation(in: self)
            let distanceX = locationOne.x - locationTwo.x
            let distanceY = locationOne.y - locationTwo.y
            targetNode.position.x += distanceX
            if targetNode.position.x > self.size.width * 0.75 {
                targetNode.position.x = self.size.width * 0.75
            }
            if targetNode.position.x < self.size.width * 0.25 {
                targetNode.position.x = self.size.width * 0.25
            }
            targetNode.position.y += distanceY
            if targetNode.position.y > self.size.height * 0.87 {
                targetNode.position.y = self.size.height * 0.87
            }
            if targetNode.position.y < self.size.height * 0.2 {
                targetNode.position.y = self.size.height * 0.2
            }
            
        }
    }
    
    func selectFood (touches: Set<UITouch>) {
        
        for touch in touches {
            let location = touch.location(in: self)
            
            let scaleOut = SKAction.scale(to: 0.8, duration: 0.1)
            let scaleIn = SKAction.scale(to: 0.5, duration: 0.1)
            let scaleOutFood = SKAction.scale(to: 1.2, duration: 0.1)
            let scaleInFood = SKAction.scale(to: 1, duration: 0.1)
            let waitTime = SKAction.wait(forDuration: 0.5)
            let removeItem = SKAction.removeFromParent()
            let buttonSequence = SKAction.sequence([clickSound, scaleOut, scaleIn])
            let foodSequence = SKAction.sequence([bowlSound, scaleOutFood, scaleInFood, waitTime, removeItem])
            let failSequence = SKAction.sequence([wrongSound, scaleOutFood, scaleInFood])

            if arrowL.contains(location) && foodNumber > 1 {
                foodNumber -= 1
                foodNode.texture = SKTexture(imageNamed: "food_\(foodNumber)")
                switch foodNumber {
                case 1:
                    foodLabel.text = "× ∞"
                case 2:
                    foodLabel.text = "× \(foodAmount_2)"
                case 3:
                    foodLabel.text = "× \(foodAmount_3)"
                case 4:
                    foodLabel.text = "× \(foodAmount_4)"
                default:
                    foodLabel.text = "× \(foodAmount_5)"
                }
                arrowL.run(buttonSequence)
                
            } else if arrowR.contains(location) && foodNumber < 5 {
                foodNumber += 1
                switch foodNumber {
                case 1:
                    foodLabel.text = "× ∞"
                case 2:
                    foodLabel.text = "× \(foodAmount_2)"
                case 3:
                    foodLabel.text = "× \(foodAmount_3)"
                case 4:
                    foodLabel.text = "× \(foodAmount_4)"
                default:
                    foodLabel.text = "× \(foodAmount_5)"
                }
                foodNode.texture = SKTexture(imageNamed: "food_\(foodNumber)")
                arrowR.run(buttonSequence)
            } else if arrowR.contains(location) || arrowL.contains(location) {
                foodNode.run(wrongSound)
            } else if foodNode.contains(location) {
                
                switch foodNumber {
                case 1:
                    gameStage = sceneStage.waitCat
                    arrowR.removeFromParent()
                    arrowL.removeFromParent()
                    recordData()
                    recordTime()
                    foodLabel.run(foodSequence)
                case 2:
                    if foodAmount_2 >= 1{
                        foodAmount_2 -= 1
                        foodLabel.text = "× \(foodAmount_2)"
                        gameStage = sceneStage.waitCat
                        arrowR.removeFromParent()
                        arrowL.removeFromParent()
                        recordData()
                        recordTime()
                        foodLabel.run(foodSequence)
                    } else {
                        foodLabel.run(failSequence)
                    }
                case 3:
                    if foodAmount_3 >= 1{
                        foodAmount_3 -= 1
                        foodLabel.text = "× \(foodAmount_3)"
                        gameStage = sceneStage.waitCat
                        arrowR.removeFromParent()
                        arrowL.removeFromParent()
                        recordData()
                        recordTime()
                        foodLabel.run(foodSequence)
                    } else {
                        foodLabel.run(failSequence)
                    }
                case 4:
                    if foodAmount_4 >= 1{
                        foodAmount_4 -= 1
                        foodLabel.text = "× \(foodAmount_4)"
                        gameStage = sceneStage.waitCat
                        arrowR.removeFromParent()
                        arrowL.removeFromParent()
                        recordData()
                        recordTime()
                        foodLabel.run(foodSequence)
                    } else {
                        foodLabel.run(failSequence)
                    }
                default:
                    if foodAmount_5 >= 1{
                        foodAmount_5 -= 1
                        foodLabel.text = "× \(foodAmount_5)"
                        gameStage = sceneStage.waitCat
                        arrowR.removeFromParent()
                        arrowL.removeFromParent()
                        recordData()
                        recordTime()
                        foodLabel.run(foodSequence)
                    } else {
                        foodLabel.run(failSequence)
                    }
                }
            }
        }
        
    }
    
    func selectCat(touches: Set<UITouch>) {
        
        for touch in touches {
            let location = touch.location(in: self)
            if catNode.contains(location) {
                
                let diceNum = Int(randomNum(num_1: 1, num_2: 101))
                if diceNum <= 71 {
                    foodAmount_2 += 1
                } else if diceNum < 81 {
                    foodAmount_3 += 1
                } else if diceNum < 91 {
                    foodAmount_4 += 1
                } else if diceNum < 101 {
                    foodAmount_5 += 1
                }
                gameStage = sceneStage.offerFood
                resetTime()
                recordData()
                
                let scaleIn = SKAction.scale(to: 5, duration: 1.5)
                let fadeOut = SKAction.fadeOut(withDuration: 1)
                let deleteHeart = SKAction.removeFromParent()
                let heartSequence = SKAction.sequence([catSound, scaleIn, fadeOut, deleteHeart])
                heartNode.run(heartSequence) {
                    self.changeScene()
                }
            }
        }
        
    }
    
    func recordData() {
        let defaultStage = UserDefaults()
        var recordStage = defaultStage.integer(forKey: "stageSaved")
        recordStage = gameStage.rawValue
        defaultStage.set(recordStage, forKey: "stageSaved")
        
        
        let defaultAmount = UserDefaults()
        var recordAmount2 = defaultAmount.integer(forKey: "Amount2Saved")
        var recordAmount3 = defaultAmount.integer(forKey: "Amount3Saved")
        var recordAmount4 = defaultAmount.integer(forKey: "Amount4Saved")
        var recordAmount5 = defaultAmount.integer(forKey: "Amount5Saved")
        var recordNumber  = defaultAmount.integer(forKey: "NumberSaved")

        recordAmount2 = foodAmount_2
        recordAmount3 = foodAmount_3
        recordAmount4 = foodAmount_4
        recordAmount5 = foodAmount_5
        recordNumber  = foodNumber
        
        defaultAmount.set(recordAmount2, forKey: "Amount2Saved")
        defaultAmount.set(recordAmount3, forKey: "Amount3Saved")
        defaultAmount.set(recordAmount4, forKey: "Amount4Saved")
        defaultAmount.set(recordAmount5, forKey: "Amount5Saved")
        defaultAmount.set(recordNumber,  forKey: "NumberSaved")
    }
    func recordTime() {
        let defaultsTime = UserDefaults()
        var recordTime = defaultsTime.object(forKey: "timeSaved")
        
        let currentTime = NSDate()
        recordTime = currentTime
        
        defaultsTime.set(recordTime, forKey: "timeSaved")
    }
    func resetTime() {
        let defaultsTime = UserDefaults()
        var recordTime = defaultsTime.object(forKey: "timeSaved")
        
        recordTime = nil
        
        defaultsTime.set(recordTime, forKey: "timeSaved")
    }
    func randomNum(num_1: CGFloat, num_2: CGFloat) -> CGFloat {
        return CGFloat(arc4random()) / CGFloat(UINT32_MAX) * abs(num_1 - num_2) + min(num_1, num_2)
    }
    func changeScene() {
        let targetscene = GameScene_Menu(size: self.size)
        targetscene.scaleMode = self.scaleMode
        let scenetransition = SKTransition.fade(withDuration: 0.2)
        self.view!.presentScene(targetscene, transition: scenetransition)
        view?.showsPhysics = false
    }
    
}



































