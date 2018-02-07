//
//  GameView.swift
//  Sekans
//
//  Created by Guest User on 12/8/17.
//  Copyright © 2017 Guest User. All rights reserved.
//

import UIKit


var maxX = 16
var maxY = 24
var snakesize = 20
var xx = 30
var offsetX = 30
var offsetY = 20

var playerStartX = 0
var computerStartX = 15
var playerstarty = 0
var computerStarty = 23

var currentPlayerX = 0
var currentPlayery = 0

var currentcomputerX = 15
var currentcomputerY = 23

var snakeValue = [[Int]](repeatElement([Int](repeatElement(0, count: 24)), count: 16))



class GameView: UIView {

    // UIView, UIKit
    override func draw( _ rect: CGRect) {
        
        
        
    }
    
    override func draw(_ layer: CALayer, in ctx: CGContext) {
     //   layer.backgroundColor = UIColor.green.cgColor
        
        
        
        
       
        
        //self.layer.backgroundColor = UIColor.white.cgColor
        let background = CGRect(x: 0, y: 0, width: self.frame.width, height: self.frame.height)
        
        ctx.clear(background)
        
        ctx.addRect(background)
        ctx.setFillColor(UIColor.lightGray.cgColor)
        ctx.fillPath()
        
        
        let playbackground = CGRect(x: offsetX, y: offsetY  , width: 320, height: 480)
        
        ctx.addRect(playbackground)
        ctx.setFillColor(bColor.cgColor)
        ctx.fillPath()
        
        
       
        
        //draw snake body

        for i in 0...snakeValue.count - 1 {
            for j in 0...snakeValue[i].count - 1{
                if snakeValue[i][j] == 1{
                    
                    let computerhead = CGRect(x: offsetX+i*snakesize, y: offsetY+j*snakesize, width: snakesize, height: snakesize)
                    
                    ctx.addRect(computerhead)
                    ctx.setFillColor(UIColor.black.cgColor)
                    ctx.fillPath()
                }
                
                
            }
            
        }
        
        //draw player snake head
        let playerhead = CGRect(x: offsetX+currentPlayerX*snakesize, y: offsetY+currentPlayery*snakesize, width: snakesize, height: snakesize)
        
        ctx.addRect(playerhead)
        ctx.setFillColor(pColor.cgColor)
        ctx.fillPath()
        
        
        //draw computer snake head
        let computerhead = CGRect(x: offsetX+currentcomputerX*snakesize, y: offsetY+currentcomputerY*snakesize, width: snakesize, height: snakesize)
        
        ctx.addRect(computerhead)
        ctx.setFillColor(aColor.cgColor)
        ctx.fillPath()
      
    }


}
