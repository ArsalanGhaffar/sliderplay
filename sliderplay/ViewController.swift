//
//  ViewController.swift
//  sliderplay
//
//  Created by Arsalan on 07/06/2016.
//  Copyright © 2016 Arsalan. All rights reserved.
//

import UIKit

class ViewController: UIViewController, UITextFieldDelegate {
    var numberC : Double!
    var txfielf : UITextField!
    @IBOutlet weak var celciuTxtField: UITextField!
    
    @IBOutlet weak var farenTxtField: UITextField!
    @IBOutlet weak var textField: UITextField!
    @IBOutlet weak var slider: UISlider!
    
    @IBAction func slider(sender: UISlider) {
        //        farenTxtField.text = String(slider.value)
        //        celciuTxtField.text = String(slider.value)
        
                farenTxtField.text = String(self.celsiusToFahrenheit(Double(slider.value)))
        celciuTxtField.text = String(slider.value)
    }
    
    
    func celsiusToFahrenheit(tempInC:Double) ->Double {
        let fahrenheit = (tempInC * 9.0/5.0) + 32.0
        return fahrenheit as Double
    }
    
    
    func fahrenheitToCelsius(tempInF:Double) ->Double {
        let celsius = (tempInF - 32.0) * (5.0/9.0)
        return celsius as Double
    }
    
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        farenTxtField.delegate = self
        celciuTxtField.delegate = self
        celciuTxtField.tag = 1
        farenTxtField.tag = 2
        slider .value = 0
        celciuTxtField.text = "0"
         farenTxtField.text = String(self.celsiusToFahrenheit(Double(slider.value)))
        
    }
    
    
    override func touchesBegan(touches: Set<UITouch>, withEvent event: UIEvent?) {
        self.view.endEditing(true)
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
    
    func textField(textField: UITextField, shouldChangeCharactersInRange range: NSRange, replacementString string: String) -> Bool {
//        print(celciuTxtField.text?.characters.count,"txt field ") // -1
//        print(string.characters.count,"string count") //count ie current typed char is 1
//        print(string.characters,"string character") // current typed char
//        print(celciuTxtField.text?.characters.count)
//        print(string.characters.count,"string") //0
//        print(celciuTxtField.text?.characters.count,"celciusfiled") // 1
       var updatedTextString : NSString = txfielf.text! as NSString
//        updatedTextString = updatedTextString.stringByReplacingCharactersInRange(range, withString: string)
//        print(updatedTextString)
        
        if (range.length == 1 && string.isEmpty){
            print("Used Backspace")
            return true
        }
        
        let disabledCharacters:NSCharacterSet = NSCharacterSet(charactersInString: "1234567890.")
        let disstring = String(disabledCharacters)
        var x = disstring.characters.count
        for (var i:Int = 0; i < x; i += 1) {
            let c = (string as NSString).characterAtIndex(i)
            
            if !(disabledCharacters.characterIsMember(c))  {
                print("Can't use that character dude :/")
                return false
            }
            else{
                // if allowed char then block decimal duplicatoin
                
                let existinghtext = txfielf.text?.rangeOfString(".")
                let replacementtext = string.rangeOfString(".")
                
                //        print("current text : \(existinghtext)")
                //        print("replacement text : \(replacementtext)")
                
                
                        if (existinghtext != nil && replacementtext != nil) {
                                                            return false
                    
                                                                            }
                   
                else {
                    updatedTextString = updatedTextString.stringByReplacingCharactersInRange(range, withString: string)
                         numberC = Double(updatedTextString as String)
                            
                            
                            print(updatedTextString)
                            print(numberC)
                            self.updateTemp(numberC, texfield: txfielf)
                    //                    return !(textField.text?.characters.count == 4 && string != "")
                    return true
                }
                
                                
                
                
                
            }
            
            
            
        }
        
        
        
        
        
        
        return true
    }
    
    
    
 func textFieldDidBeginEditing(textField: UITextField)  {
    if textField.tag == 1 {
        txfielf = celciuTxtField
    }else{
    txfielf = farenTxtField
    
    }
    print(txfielf.text)
    
    }
    
    func updateTemp(value:Double, texfield: UITextField){
        if texfield.tag == 1{
        let x = celsiusToFahrenheit(value)
        slider.setValue(Float(x), animated: true)
            farenTxtField.text = String(x)
        } else{
            let x = fahrenheitToCelsius(value)
            slider.setValue(Float(x), animated: true)
            celciuTxtField.text = String(x)
        }
    
    }
    
    
}

