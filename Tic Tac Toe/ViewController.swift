//
//  ViewController.swift
//  Tic Tac Toe
//
//  Created by John Willingham on 3/23/15.
//  Copyright (c) 2015 John Willingham. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet var tictac1: UIImageView!
    @IBOutlet var tictac2: UIImageView!
    @IBOutlet var tictac3: UIImageView!
    @IBOutlet var tictac4: UIImageView!
    @IBOutlet var tictac6: UIImageView!
    @IBOutlet var tictac5: UIImageView!
    @IBOutlet var tictac7: UIImageView!
    @IBOutlet var tictac8: UIImageView!
    @IBOutlet var tictac9: UIImageView!
    
    @IBOutlet var TicBtn1: UIButton!
    @IBOutlet var TicBtn2: UIButton!
    @IBOutlet var TicBtn3: UIButton!
    @IBOutlet var TicBtn4: UIButton!
    @IBOutlet var TicBtn5: UIButton!
    @IBOutlet var TicBtn6: UIButton!
    @IBOutlet var TicBtn7: UIButton!
    @IBOutlet var TicBtn8: UIButton!
    @IBOutlet var TicBtn9: UIButton!
    
    @IBOutlet var StartOverBtn: UIButton!
    
    @IBOutlet var Message: UILabel!
    
    
    var plays = [Int:Int]()
    var done = false
    var aiDeciding = false
    
    
    @IBAction func UIButtonClicked(sender:UIButton){
        Message.hidden = true
        if plays[sender.tag] == nil && !aiDeciding && !done {
            setImageForSpot(sender.tag, player:1)
        }
        
        checkforwin()
        aiTurn()
        
    }
    
    func setImageForSpot(spot:Int,player:Int) {
        var playerMark = player == 1 ? "x" : "o"
        plays[spot] = player
        switch spot {
        case 1:
            tictac1.image = UIImage(named: playerMark)
        case 2:
            tictac2.image = UIImage(named: playerMark)
        case 3:
            tictac3.image = UIImage(named: playerMark)
        case 4:
            tictac4.image = UIImage(named: playerMark)
        case 5:
            tictac5.image = UIImage(named: playerMark)
        case 6:
            tictac6.image = UIImage(named: playerMark)
        case 7:
            tictac7.image = UIImage(named: playerMark)
        case 8:
            tictac8.image = UIImage(named: playerMark)
        case 9:
            tictac9.image = UIImage(named: playerMark)
        default:
            tictac5.image = UIImage(named: playerMark)
        }
        
    }
    
    @IBAction func StartOverBtnClicked(sender:UIButton){
        done = false
        StartOverBtn.hidden = true
        Message.hidden = true
        reset()
    }
    
    
    func reset() {
        plays = [:]
        tictac1.image = nil
        tictac2.image = nil
        tictac3.image = nil
        tictac4.image = nil
        tictac5.image = nil
        tictac6.image = nil
        tictac7.image = nil
        tictac8.image = nil
        tictac9.image = nil
    }
    
    func checkforwin() {
        var whoWon = ["I":0, "You":1]
        for(key,value) in whoWon {
            var won:Bool = false
            
            if plays[7] == value && plays[8] == value && plays[9] == value
            {
                won = true
            }
            
            if plays[4] == value && plays[5] == value && plays[6] == value
            {
                won = true
            }
            
            if plays[1] == value && plays[2] == value && plays[3] == value
            {
                won = true
            }
            
            if plays[1] == value && plays[6] == value && plays[7] == value
            {
                won = true
            }
            
            if plays[2] == value && plays[5] == value && plays[8] == value
            {
                won = true
            }
            
            if plays[3] == value && plays[4] == value && plays[9] == value
            {
                won = true
            }
            
            if plays[1] == value && plays[5] == value && plays[9] == value
            {
                won = true
            }
            
            if plays[3] == value && plays[5] == value && plays[7] == value
            {
                won = true
            }
            
            if won
            {
                Message.hidden = false
                Message.text = "Looks like \(key) won!"
                StartOverBtn.hidden = false
                done = true
            }
        }
    }
    
    func checkBottom(#value:Int) -> (location:String,pattern:String) {
        return ("bottom",checkFor(value, inList: [7,8,9]))
    }
    
    func checkTop(#value:Int) -> (location:String,pattern:String) {
        return ("Top",checkFor(value, inList: [1,2,3]))
    }
    
    func checkLeft(#value:Int) -> (location:String,pattern:String) {
        return ("Left",checkFor(value, inList: [1,6,7]))
    }
    
    func checkRight(#value:Int) -> (location:String,pattern:String) {
        return ("Right",checkFor(value, inList: [3,4,9]))
    }
    
    func checkMiddleAcross(#value:Int) -> (location:String,pattern:String) {
        return ("MiddleAcross",checkFor(value, inList: [3,4,5]))
    }
    
    func checkMiddleDown(#value:Int) -> (location:String,pattern:String) {
        return ("MiddleDown",checkFor(value, inList: [2,5,8]))
    }
    
    func checkDiagLeftRight(#value:Int) -> (location:String,pattern:String) {
        return ("DiagLeftRight",checkFor(value, inList: [1,5,9]))
    }
    
    func checkDiagRightLeft(#value:Int) -> (location:String,pattern:String) {
        return ("DiagRightLeft",checkFor(value, inList: [3,5,7]))
    }
    
    
    func checkFor(value:Int, inList:[Int]) -> String {
        var conclusion = ""
        for cell in inList {
            if plays[cell] == value {
                conclusion += "1"
            }else{
                conclusion += "0"
            }
        }
        return conclusion
    }
    
    func rowCheck(#Value:Int) -> (location:String,pattern:String) {
        var exceptableFinds = ["011", "110", "101"]
        var findfuncs = [checkTop,checkBottom,checkLeft,checkRight,checkMiddleAcross, checkMiddleDown,checkDiagLeftRight, checkDiagRightLeft]
        for algorithm in findfuncs {
            var algorithmResults = algorithm(value:Value)
            if find(exceptableFinds, algorithmResults.pattern) != nil {
                return algorithmResults
            }
        }
        
        return ("null", "null")
    }
    
    func whereToPlay(location:String,pattern:String) ->Int {
        var leftpattern = "011"
        var rightpattern = "110"
        var middlepattern = "101"
        
        switch location {
            case "top":
                if pattern == leftpattern {
                    return 1
                }else if pattern == rightpattern {
                    return 3
                }else {
                    return 2
                }
        case "bottom":
            if pattern == leftpattern {
                return 7
            }else if pattern == rightpattern {
                return 9
            }else {
                return 8
            }
            
        case "right":
            if pattern == leftpattern {
                return 3
            }else if pattern == rightpattern {
                return 9
            }else {
                return 4
            }
            
        case "left":
            if pattern == leftpattern {
                return 1
            }else if pattern == rightpattern {
                return 7
            }else {
                return 6
            }
            
        case "middleAcross":
            if pattern == leftpattern {
                return 6
            }else if pattern == rightpattern {
                return 4
            }else {
                return 5
            }
            
        case "middleDown":
            if pattern == leftpattern {
                return 2
            }else if pattern == rightpattern {
                return 8
            }else {
                return 5
            }
            
        case "diagRightLeft":
            if pattern == leftpattern {
                return 1
            }else if pattern == rightpattern {
                return 9
            }else {
                return 5
            }
            
        case "diagLeftRight":
            if pattern == leftpattern {
                return 7
            }else if pattern == rightpattern {
                return 3
            }else {
                return 5
            }
            
        default: return 4

        }
    }
    
    func isOccupied(spot:Int)-> Bool {
        return plays[spot] != nil
    }
    
    func aiTurn() {
        if done {
            return
        }
        
        aiDeciding = true
        
        var result = rowCheck(Value:0)
        var whereToPlayResult = whereToPlay(result.location,pattern:result.pattern)
        
        if !isOccupied(whereToPlayResult) {
            setImageForSpot(whereToPlayResult, player:0)
            aiDeciding = false
            checkforwin()
            return
        }
        
        result = rowCheck(Value:1)
        whereToPlayResult = whereToPlay(result.location,pattern:result.pattern)
        
        if !isOccupied(whereToPlayResult) {
            setImageForSpot(whereToPlayResult, player:0)
            aiDeciding = false
            checkforwin()
            return
        }
        
        if !isOccupied(5) {
            setImageForSpot(5, player: 0)
            aiDeciding = false
            checkforwin()
            return
        }
        
        func firstAvailable(#isCorner:Bool) -> Int? {
            var spots = isCorner ? [1,3,7,9] : [2,4,6,8]
            for spot in spots {
                if !isOccupied(spot) {
                    return spot
                }
            }
            return nil
        }
        
        if let cornerAvailable = firstAvailable(isCorner: true) {
            setImageForSpot(cornerAvailable, player: 0)
            aiDeciding = false
            checkforwin()
            return
        }
        
        if let sideAvailable = firstAvailable(isCorner: false) {
            setImageForSpot(sideAvailable, player: 0)
            aiDeciding = false
            checkforwin()
            return
        }
        
        Message.hidden = false
        Message.text = "Looks like it was a tie!"
        
        reset()
        
        aiDeciding = false
    }
    

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

