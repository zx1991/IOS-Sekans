//
//  FirstViewController.swift
//  Sekans
//
//  Created by Guest User on 11/30/17.
//  Copyright © 2017 Guest User. All rights reserved.
//

import UIKit



class SettingViewController: UIViewController {

  
    
    var headColors :[UIColor] = [UIColor.green, UIColor.blue, UIColor.red, UIColor.brown, UIColor.cyan, UIColor.purple, UIColor.orange,UIColor.darkGray,UIColor.magenta, UIColor.yellow]
    
    var backgroundColors: [UIColor] = [UIColor.white,UIColor.green, UIColor.blue, UIColor.red, UIColor.brown, UIColor.cyan, UIColor.purple, UIColor.orange,UIColor.darkGray,UIColor.magenta, UIColor.yellow]
    
    
    @IBOutlet weak var bgStepper: UIStepper!
    
    @IBOutlet weak var playerStepper: UIStepper!
    
    @IBOutlet weak var playerColor: UIImageView!
    @IBOutlet weak var speedLabel: UILabel!
    
    @IBOutlet weak var speedStepper: UIStepper!
    
    @IBOutlet weak var computerStepper: UIStepper!

    @IBOutlet weak var computerColor: UIImageView!
    
    @IBOutlet weak var bgColor: UIImageView!
    
    override func viewDidLoad() {
        
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        speedStepper.maximumValue = 10
        speedStepper.minimumValue = 1
        
        computerStepper.maximumValue = 9
        computerStepper.minimumValue = 0
        
        playerStepper.maximumValue = 9
        playerStepper.minimumValue = 0
        
        bgStepper.maximumValue = 10
        bgStepper.minimumValue = 0
        
        speedStepper.value = Double(gameSpeed)
        speedLabel.text = String(gameSpeed)
        
        playerColor.backgroundColor = pColor
        
        computerColor.backgroundColor = aColor
        
        
        bgColor.backgroundColor = bColor
        
      
        
       
        
    }
    
    
    @IBAction func changebgColor(_ sender: Any) {
        let index:Int = Int(bgStepper.value)
        
        bColor = backgroundColors[index]
        
        bgColor.backgroundColor = bColor
        
        
    }
    @IBAction func ChangeSpeed(_ sender: Any) {
        
        gameSpeed = Int(speedStepper.value)
        
        speedLabel.text = String(gameSpeed)
        
        
    }
    @IBAction func PlayerChangeColor(_ sender: Any) {
        
        let index:Int = Int(playerStepper.value)
        
        pColor = headColors[index]
        
        playerColor.backgroundColor = pColor
        
        
        
    }

    @IBAction func AiChangeColor(_ sender: Any) {
        
        let index:Int = Int(computerStepper.value)
        
        aColor = headColors[index]
        
        computerColor.backgroundColor = aColor
        
    }
  
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

