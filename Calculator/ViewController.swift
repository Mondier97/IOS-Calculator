//
//  ViewController.swift
//  Calculator
//
//  Created by Samuel Mondier on 7/12/17.
//  Copyright © 2017 Samuel Mondier. All rights reserved.
//

import UIKit



class ViewController: UIViewController {
    enum _buttonState {
        case none
        case add
        case sub
        case mult
        case div
    }
    
    @IBOutlet var display: UILabel!
    @IBOutlet var div: UIButton?
    @IBOutlet var mult: UIButton?
    @IBOutlet var sub: UIButton?
    @IBOutlet var add: UIButton?
    
    //this variable keeps track of which button(addition, subtraction, etc.) is being toggled, if any
    var whichButton = _buttonState.none
    
    //keeps track of if the diplay is cleared or not
    var isClear = true
    
    //keeps track of when the second arguement for the four functions was started so it can grow like normal
    var newNum = false
    
    //keeps the previous numbered entered before one of the four functions is toggled
    var prevNum: Double? = nil
    
    //color of tiles on the far right
    let _color = UIColor(colorLiteralRed: 249.0/255, green: 212.0/255, blue: 120.0/255, alpha: 1)
    
    //number tags are one higher than their value
    @IBAction func numbers(_ sender: UIButton) {
        if whichButton == _buttonState.none || newNum == true {
            //remove the zero if it is currently clear
            if (display.text?.characters.count)! == 1 || (display.text?.characters.count)! == 2 && isClear == true{
                display.text = display.text?.replacingOccurrences(of: "0", with: "")
                isClear = false
            }
        
            //limit the size of the number to 9
            if (display.text?.characters.count)! < 9 {
                display.text = display.text! + String(describing: sender.tag - 1)
            }
        }
        //if one of the four buttons is toggled, put the old number in memory and begin the new one
        else {
            newNum = true
            prevNum = Double(display.text!)
            display.text = String(describing: sender.tag - 1)
        }
    }
    
    //Tags for other buttons:
    //
    //    C : 11
    //  +/- : 12
    //    % : 13
    //    ÷ : 14
    //    x : 15
    //    - : 16
    //    + : 17
    //    = : 18
    //    . : 19
    @IBAction func other_buttons(_ sender: UIButton) {
        switch sender.tag {
            
        //clear the screen
        case 11:
            display.text = "0"
            isClear = true
            newNum = false
            prevNum = nil
            switch whichButton {
          
            case _buttonState.div:
                div?.backgroundColor = _color
                whichButton = _buttonState.none
            
            case _buttonState.mult:
                mult?.backgroundColor = _color
                whichButton = _buttonState.none
            
            case _buttonState.sub:
                sub?.backgroundColor = _color
                whichButton = _buttonState.none
            
            case _buttonState.add:
                add?.backgroundColor = _color
                whichButton = _buttonState.none
                
            default:
                break
            }
            
        //toggle the negative sign
        case 12:
            let index = display.text?.startIndex
            if (display.text?.characters.count)! != 0 && (display.text?[index!])! == "-" {
                display.text = display.text?.replacingOccurrences(of: "-", with: "")
            }
            else {
                display.text = "-" + display.text!
            }
       
        //convert to percent
        case 13:
            if (display.text?.characters.count)! != 0 {
                var num = Double(display.text!)
                num = num! * 0.01
                display.text = String(describing: num!)
            }
            switch whichButton {
            
            case _buttonState.div:
                div?.backgroundColor = _color
                whichButton = _buttonState.none
            
            case _buttonState.mult:
                mult?.backgroundColor = _color
                whichButton = _buttonState.none
          
            case _buttonState.sub:
                sub?.backgroundColor = _color
                whichButton = _buttonState.none
           
            case _buttonState.add:
                add?.backgroundColor = _color
                whichButton = _buttonState.none
            default:
                break
            }
            break
            
        //division
        case 14:
            switch whichButton {
            case _buttonState.div:
                whichButton = _buttonState.none
                div?.backgroundColor = _color
            
            case _buttonState.mult:
                whichButton = _buttonState.div
                mult?.backgroundColor = _color
                div?.backgroundColor = UIColor.orange
            
            case _buttonState.sub:
                whichButton = _buttonState.div
                sub?.backgroundColor = _color
                div?.backgroundColor = UIColor.orange
            
            case _buttonState.add:
                whichButton = _buttonState.div
                add?.backgroundColor = _color
                div?.backgroundColor = UIColor.orange
           
            case _buttonState.none:
                whichButton = _buttonState.div
                div?.backgroundColor = UIColor.orange
            }
            
        //multiplication
        case 15:
            switch whichButton {
           
            case _buttonState.div:
                whichButton = _buttonState.mult
                div?.backgroundColor = _color
                mult?.backgroundColor = UIColor.orange
         
            case _buttonState.mult:
                whichButton = _buttonState.none
                mult?.backgroundColor = _color
         
            case _buttonState.sub:
                whichButton = _buttonState.mult
                sub?.backgroundColor = _color
                mult?.backgroundColor = UIColor.orange
        
            case _buttonState.add:
                whichButton = _buttonState.mult
                add?.backgroundColor = _color
                mult?.backgroundColor = UIColor.orange
        
            case _buttonState.none:
                whichButton = _buttonState.mult
                mult?.backgroundColor = UIColor.orange
            }
            
        //subtraction
        case 16:
            switch whichButton {
          
            case _buttonState.div:
                whichButton = _buttonState.sub
                div?.backgroundColor = _color
                sub?.backgroundColor = UIColor.orange
            
            case _buttonState.mult:
                whichButton = _buttonState.sub
                mult?.backgroundColor = _color
                sub?.backgroundColor = UIColor.orange
                
            case _buttonState.sub:
                whichButton = _buttonState.none
                sub?.backgroundColor = _color
              
            case _buttonState.add:
                whichButton = _buttonState.sub
                add?.backgroundColor = _color
                sub?.backgroundColor = UIColor.orange
                
            case _buttonState.none:
                whichButton = _buttonState.sub
                sub?.backgroundColor = UIColor.orange
            }
            
        //addition
        case 17:
            switch whichButton {
            case _buttonState.div:
                whichButton = _buttonState.add
                div?.backgroundColor = _color
                add?.backgroundColor = UIColor.orange
            case _buttonState.mult:
                whichButton = _buttonState.add
                mult?.backgroundColor = _color
                add?.backgroundColor = UIColor.orange
             
            case _buttonState.sub:
                whichButton = _buttonState.add
                sub?.backgroundColor = _color
                add?.backgroundColor = UIColor.orange
            
            case _buttonState.add:
                whichButton = _buttonState.none
                add?.backgroundColor = _color
              
            case _buttonState.none:
                whichButton = _buttonState.add
                add?.backgroundColor = UIColor.orange
               
            }
            
        //equals
        case 18:
            if prevNum != nil {
                let currNum = Double(display.text!)
                switch whichButton {
                case _buttonState.div:
                    newNum = false
                    if currNum == 0 {
                        display.text = "Error"
                    }
                    else {
                        display.text = String(prevNum! / currNum!)
                    }
                    prevNum = Double(display.text!)
        
                case _buttonState.mult:
                    newNum = false
                    display.text = String(prevNum! * currNum!)
                   
                case _buttonState.sub:
                    newNum = false
                    display.text = String(prevNum! - currNum!)
                    
                case _buttonState.add:
                    newNum = false
                    display.text = String(prevNum! + currNum!)
                    
                default:
                    break
                }
            }
            
        //decimal
        case 19:
            if display.text?.contains(".") != true {
                display.text = display.text! + "."
                isClear = false
            }
            
        default:
            break
        }
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

