//
//  ViewController.swift
//  catch game
//
//  Created by abdullah's Ventura on 24.04.2023.
//

import UIKit

class ViewController: UIViewController {

    //images
    @IBOutlet weak var highScore: UILabel!
    @IBOutlet weak var scoreLabel: UILabel!
    @IBOutlet weak var timer: UILabel!
    @IBOutlet weak var imageView1: UIImageView!
    @IBOutlet weak var imageView2: UIImageView!
    @IBOutlet weak var imageView3: UIImageView!
    @IBOutlet weak var imageView4: UIImageView!
    @IBOutlet weak var imageView5: UIImageView!
    @IBOutlet weak var imageView6: UIImageView!
    @IBOutlet weak var imageView7: UIImageView!
    @IBOutlet weak var imageView8: UIImageView!
    @IBOutlet weak var imageView9: UIImageView!
    
    //variables
    var flowerArray = [UIImageView]()
    var scoreCounter = 0
    var second = 10
    var gameTimer = Timer()
    var changeflowerTimer = Timer()
    var highscore = 0
    
    override func viewDidLoad() {
        
        super.viewDidLoad()
        
       //highScore check
        let storedHighscore =  UserDefaults.standard.object(forKey: "highScore")
        if storedHighscore == nil {
            highscore = 0
            highScore.text = "High Score:\(highscore)"
        }
        if let newScore = storedHighscore as? Int{
            highscore = newScore
            highScore.text = "High Score:\(newScore)"
        }
        
        //views
        let gestureRecognizer1 = UITapGestureRecognizer(target: self, action: #selector(score))
        let gestureRecognizer2 = UITapGestureRecognizer(target: self, action: #selector(score))
        let gestureRecognizer3 = UITapGestureRecognizer(target: self, action: #selector(score))
        let gestureRecognizer4 = UITapGestureRecognizer(target: self, action: #selector(score))
        let gestureRecognizer5 = UITapGestureRecognizer(target: self, action: #selector(score))
        let gestureRecognizer6 = UITapGestureRecognizer(target: self, action: #selector(score))
        let gestureRecognizer7 = UITapGestureRecognizer(target: self, action: #selector(score))
        let gestureRecognizer8 = UITapGestureRecognizer(target: self, action: #selector(score))
        let gestureRecognizer9 = UITapGestureRecognizer(target: self, action: #selector(score))
        
        imageView1.addGestureRecognizer(gestureRecognizer1)
        imageView2.addGestureRecognizer(gestureRecognizer2)
        imageView3.addGestureRecognizer(gestureRecognizer3)
        imageView4.addGestureRecognizer(gestureRecognizer4)
        imageView5.addGestureRecognizer(gestureRecognizer5)
        imageView6.addGestureRecognizer(gestureRecognizer6)
        imageView7.addGestureRecognizer(gestureRecognizer7)
        imageView8.addGestureRecognizer(gestureRecognizer8)
        imageView9.addGestureRecognizer(gestureRecognizer9)
        
        imageView1.isUserInteractionEnabled = true
        imageView2.isUserInteractionEnabled = true
        imageView3.isUserInteractionEnabled = true
        imageView4.isUserInteractionEnabled = true
        imageView5.isUserInteractionEnabled = true
        imageView6.isUserInteractionEnabled = true
        imageView7.isUserInteractionEnabled = true
        imageView8.isUserInteractionEnabled = true
        imageView9.isUserInteractionEnabled = true
        
        //Timers
        
        gameTimer = .scheduledTimer(timeInterval: 1, target: self, selector: #selector(countDown), userInfo: nil, repeats: true)
        changeflowerTimer = .scheduledTimer(timeInterval: 0.3, target: self, selector: #selector(changeflower), userInfo: nil, repeats: true)
        
        //Array
        flowerArray = [imageView1,imageView2,imageView3,imageView4,imageView5,imageView6,imageView7,imageView8,imageView9]
        
        // function
        flowerHidden()
        
    }
    func flowerHidden(){
        for array in flowerArray {
            array.isHidden = true
        }
    }
    @objc func changeflower(){
        for _ in flowerArray {
            flowerHidden()
            let randomInt = Int.random(in: 0..<9)
            flowerArray[randomInt].isHidden = false
        }
       
    }
    
    @objc func countDown(){
        second -= 1
        timer.text = "\(second)"
        
        
        //highscore
       
        if second == 0 {
            gameTimer.invalidate()
            changeflowerTimer.invalidate()
          
            if highscore < scoreCounter {
                highscore  = scoreCounter
                highScore.text = "High Score:\(highscore)"
                UserDefaults.standard.set(highscore, forKey: "highScore")
            }
            
            
            //alert
            let alert = UIAlertController(title: "Game Over", message: "Your Score \(scoreCounter)", preferredStyle: .alert)
            let okButton = UIAlertAction(title: "Ok", style: .cancel) { UIAlertAction in
                for array in self.flowerArray {
                    self.scoreLabel.text = "Score:"
                    array.isHidden = true
                }
            }
            let replayButton = UIAlertAction(title: "Try Again ", style: .default) { UIAlertAction in
                //replay function
                self.second = 10
                self.scoreLabel.text = "Score:"
                self.scoreCounter = 0
                //check timer
                if self.gameTimer.isValid && self.changeflowerTimer.isValid {
                    self.gameTimer.invalidate()
                    self.changeflowerTimer.invalidate()
                }
                //timer restart
                self.gameTimer = .scheduledTimer(timeInterval: 1, target: self, selector: #selector(self.countDown), userInfo: nil, repeats: true)
                self.changeflowerTimer = .scheduledTimer(timeInterval: 0.3, target: self, selector: #selector(self.changeflower), userInfo: nil, repeats: true)
              
            }
            alert.addAction(okButton)
            alert.addAction(replayButton)
            present(alert, animated: true)
         
        }
        
    }
    func highScoreFunc(){
       
    }
   
    @objc func score() {
      scoreCounter += 1
        scoreLabel.text = "Score: \(scoreCounter)"
    }
}

