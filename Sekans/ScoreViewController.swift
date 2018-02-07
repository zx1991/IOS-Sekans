//
//  SecondViewController.swift
//  Sekans
//
//  Created by Guest User on 11/30/17.
//  Copyright © 2017 Guest User. All rights reserved.
//

import UIKit



class ScoreViewController: UIViewController {
    @IBOutlet weak var computerScoreLabel: UILabel!

    @IBOutlet weak var lastStepLabel: UILabel!
    @IBOutlet weak var playerScoreLabel: UILabel!
    
    var playerScore = 0
    var computerScore = 0
    var lastStep = 0

    override func viewDidLoad() {
        super.viewDidLoad()
        UpdateLabel()
        // Do any additional setup after loading the view, typically from a nib.
    }
    
    override func viewDidAppear(_ animated: Bool) {
        
      

    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    @IBAction func ResetScore(_ sender: Any) {
        
        UserDefaults.standard.set(0, forKey: "playerScore")
        UserDefaults.standard.set(0, forKey: "computerScore")
        UserDefaults.standard.set(0, forKey: "lastStep")
        playerScore = 0
        computerScore = 0
        lastStep = 0
        UpdateLabel()
     
    }
    
    public func Updatescore(winner:Bool){
        
        if(winner){
            
            playerScore += 1;
            
            
        }else{
            
            computerScore += 1 ;
            
            
        }
        
        UpdateLabel()
        
        
    }
    
    func UpdateLabel(){
        playerScoreLabel.text = String(playerScore)
        
        computerScoreLabel.text = String(computerScore)
        
        lastStepLabel.text = String(lastStep)
    }

}

