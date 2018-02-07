//
//  SecondViewController.swift
//  Sekans
//
//  Created by Guest User on 11/30/17.
//  Copyright © 2017 Guest User. All rights reserved.
//

import UIKit


var gameSpeed = 5

var pColor: UIColor = UIColor.green
var aColor: UIColor = UIColor.blue

var bColor: UIColor = UIColor.white


class PlayViewController: UIViewController {
    
    @IBOutlet weak var gameOverLabel: UILabel!
    var steps = 0
    //move direction 0->right; 1->left; 2->up; 3->down
  
    
    var playerdirection = 0
    var computerdirection = 1
    var localSpeed = 5
    
    
   
    var isAnimating = false
    var isGameover = true
    
    var playerScore = 0
    var computerScore = 0
    var lastStep = 0
    
    var isGamePaused = false
    
    @IBOutlet weak var gameView: GameView!
    
    @IBOutlet weak var buttonstart: UIBarButtonItem!
  
    @IBOutlet weak var testLabel: UILabel!
    
    var gametimer = Timer()
  
    @IBOutlet weak var stepsLabel: UILabel!
    
    @IBOutlet weak var buttonconfiguration: UIBarButtonItem!
  
   
   // pass data to score view controller
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
       
        guard
            let tabbarcontroller = segue.destination as? UITabBarController else{
                return}
        guard let scoreView = tabbarcontroller.viewControllers![0] as? ScoreViewController else{ return}
        
        
        
        
        scoreView.playerScore = playerScore
        scoreView.computerScore = computerScore
        scoreView.lastStep = lastStep
        
        
    }
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
       
       // debugPrint(gameView.frame.height)
       // debugPrint(gameView.frame.width)
        
        offsetY = Int((gameView.frame.height - 480)/2)
        offsetX = (Int(gameView.frame.width - 320)/2)
        
        
        
        
    }
    
    	
    
    override func viewDidAppear(_ animated: Bool) {
        
        
        
        if let x = UserDefaults.standard.object(forKey: "playerScore") as? Int
        {
            playerScore = x
        }
        if let x = UserDefaults.standard.object(forKey: "computerScore") as? Int
        {
            computerScore = x
        }
        
        if let x = UserDefaults.standard.object(forKey: "lastStep") as? Int
        {
            lastStep = x
        }
        
        gameView.setNeedsDisplay()
        
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func StartGame(_ sender: Any) {
        if gameView == nil {
            debugPrint("nil")
            return
        }
       
        
        
        if(isAnimating){
            
            return
        }
        
        if(isGameover){
            restart()
            gameView.setNeedsDisplay()
            countDown()
        
            //buttonstart.isEnabled = false
            
            buttonstart.title = "Pause"
            
            
        }
        
        else{
            
            if(isGamePaused){
                
                isGamePaused = !isGamePaused
                
                gametimer = Timer.scheduledTimer(timeInterval: TimeInterval(self.localSpeed)/20, target: self, selector: #selector(self.timerFunction), userInfo: nil, repeats: true)
                
                buttonstart.title = "Pause"
                
            }else{
                
                isGamePaused = !isGamePaused
                gametimer.invalidate()
                
                buttonstart.title = "Resume"
                
            }
            
            
        }
        
        
    }
    
    //count down animation before game start
    func countDown(){
        
        localSpeed = gameSpeed
        
        gameOverLabel.isHidden = true
        isAnimating = true
        stepsLabel.isHidden = false
        stepsLabel.text = "3"
        stepsLabel.transform = CGAffineTransform(scaleX: 0.1, y: 0.1)
        UIView.animate(withDuration: 1, animations: {self.stepsLabel.transform = CGAffineTransform(scaleX: 3.1, y: 3.1)},completion:{(success)in
            self.stepsLabel.text = "2"
            self.stepsLabel.transform = CGAffineTransform(scaleX: 0.1, y: 0.1)

            UIView.animate(withDuration: 1, animations: {self.stepsLabel.transform = CGAffineTransform(scaleX: 3.1, y: 3.1)}, completion:{(success)in
            
            
                self.stepsLabel.text = "1"
                self.stepsLabel.transform = CGAffineTransform(scaleX: 0.1, y: 0.1)
                
                UIView.animate(withDuration: 1, animations: {self.stepsLabel.transform = CGAffineTransform(scaleX: 3.1, y: 3.1)}, completion:{
                    (success)in
                    
                    self.gametimer = Timer.scheduledTimer(timeInterval: TimeInterval(self.localSpeed)/20, target: self, selector: #selector(self.timerFunction), userInfo: nil, repeats: true)
                    self.isGameover = false
                    self.stepsLabel.isHidden = true;
                    self.isAnimating = false
                })
                
            
            })
            
        })
       
 

    }
    
    func timerFunction(){
        
        steps += 1
        
        snakeValue[currentPlayerX][currentPlayery] = 1
        snakeValue[currentcomputerX][currentcomputerY] = 1
        //stepsLabel.text = String(direction)
        testLabel.text = String(steps)
        
        switch playerdirection{
        case 0:
            currentPlayerX += 1
        case 1 :
            currentPlayerX -= 1
        case 2:
            currentPlayery -= 1
        case 3:
            currentPlayery += 1
        default:
            debugPrint("error")
        }
        
        switch computerdirection{
        case 0:
            currentcomputerX += 1
        case 1 :
            currentcomputerX -= 1
        case 2:
            currentcomputerY -= 1
        case 3:
            currentcomputerY += 1
        default:
            debugPrint("error")
        }
        
        
        gameView.setNeedsDisplay()
        
        
        computerChangeDirection()
        checkwin()
        
        
        
    }
    
    func checkPosion (x: Int, y: Int) -> Bool{
        if(x >= 0 && x < maxX){
            if(y>=0 && y < maxY){
                if(snakeValue[x][y] == 0){
                
                    return true
                }
            
            }
        }
    
        return false
    
    }
    
    func computerChangeDirection(){
        
        // check 4 posion next to the computer snake head, see if they can be reached
        var possibleDirection = [Int]()
        
        let isright = checkPosion(x: currentcomputerX+1, y: currentcomputerY)
        let isleft = checkPosion(x: currentcomputerX-1, y: currentcomputerY)
        let isup = checkPosion(x: currentcomputerX, y: currentcomputerY-1)
        let isdown = checkPosion(x: currentcomputerX, y: currentcomputerY+1)
        if(isright){
            
            possibleDirection.append(0)
        }
        if(isleft){
            
            possibleDirection.append(1)
        }
        if(isup){
            
            possibleDirection.append(2)
        }
        if(isdown){
            
            possibleDirection.append(3)
        }
        
        switch(computerdirection){
        case 0:
                possibleDirection =  possibleDirection.filter{$0 != 1}
        case 1:
              possibleDirection =  possibleDirection.filter{$0 != 0}
        case 2:
              possibleDirection =  possibleDirection.filter{$0 != 3}
        case 3:
            possibleDirection =  possibleDirection.filter{$0 != 2}
        default:
            break
        
        }
        if(possibleDirection.count <= 0)
        {
            
            return
        }
        
        let index = arc4random_uniform(UInt32(possibleDirection.count))
        
        computerdirection = possibleDirection[Int(index)]
        
    }
    
    func checkwin(){
        
        var playerLost = false
        var computerLost = false
        
        if(currentPlayerX >= maxX || currentPlayerX < 0){
            playerLost = true
        }
        
        else if(currentPlayery >= maxY || currentPlayery < 0){
            
            playerLost = true
        }else if (snakeValue[currentPlayerX][currentPlayery] == 1){
            
            playerLost = true
            
            
            
        }
        
        
        if(currentcomputerX >= maxX || currentcomputerX < 0){
            computerLost = true
            
            
        }
        
        else if(currentcomputerY >= maxY || currentcomputerY < 0){
            
            computerLost = true
        }else if(snakeValue[currentcomputerX][currentcomputerY] == 1){
            
            computerLost = true
            
        }
        
        if(!computerLost && !playerLost){
            
            return
        }
        
        else if(computerLost && playerLost ){
           gameOverLabel.text = "both of you lost!"
            
            computerScore += 1
            
        }else if(computerLost){
            
            gameOverLabel.text = "You Win"
            
            playerScore += 1
            
        }else if(playerLost){
            computerScore += 1
            
            gameOverLabel.text = " You Lost"
            
        }
        
        lastStep = steps
        gametimer.invalidate()
        isGameover = true
        buttonstart.title = "Start"
        gameOverLabel.isHidden = false
        
        
        UserDefaults.standard.set(playerScore, forKey: "playerScore")
        UserDefaults.standard.set(computerScore, forKey: "computerScore")
        UserDefaults.standard.set(lastStep, forKey: "lastStep")
        
        
        
    }
    
    //reset all values
    func restart(){
        
        currentcomputerY = computerStarty
        currentcomputerX = computerStartX
        
        currentPlayery = playerstarty
        currentPlayerX = playerStartX
        
        snakeValue =  [[Int]](repeatElement([Int](repeatElement(0, count: 24)), count: 16))
        
        playerdirection = 0
        computerdirection = 1
        steps = 0
        testLabel.text = "0"
        
    }
    
    //gesture control
    @IBAction func leftSwipe(_ sender: Any) {
        
     //   debugPrint("gesture left")

        if(playerdirection != 0){
            playerdirection  = 1
        }
    }
    @IBAction func rightSwipe(_ sender: Any) {
        
      // debugPrint("gesture rignt")
        
        if(playerdirection != 1){
            
            playerdirection = 0
        }
    }
    @IBAction func downSwipe(_ sender: Any) {
        
       // debugPrint("gesture down")

        
        if(playerdirection != 2){
            
            playerdirection = 3
            
        }
    }
    @IBAction func upSwipe(_ sender: Any) {
        
       // debugPrint("gesture up")

        if(playerdirection != 3){
            
            playerdirection = 2
        }
    }
    
    
    
    
}

