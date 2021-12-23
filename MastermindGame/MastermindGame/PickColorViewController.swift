//
//  PickColorViewController.swift
//  MastermindGame
//
//  Created by Shen Licheng on 18/12/2021.
//

import UIKit
import CloudKit

class PickColorViewController: UIViewController, UIPickerViewDelegate, UIPickerViewDataSource {
    let color = ["Red", "Green", "Blue", "Orange", "Brown", "Purple", "Black", "White"]
    var selectedType = "Red"
    var randomeColor:[Int] = [0,0,0,0]
    var Mind : Mastermind = Mastermind()

    
    @IBOutlet weak var colorPicker: UIPickerView!
    
    @IBOutlet var colorView: [UIView]!
    
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        for i in 0...3{
            colorView[i].layer.borderColor = UIColor.black.cgColor
            colorView[i].layer.borderWidth = 1
        }
        
    }
    
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        return color[row]
    }
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return color.count
    }
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        selectedType = color[row]
    }
    
    
    
    @IBAction func color1Btn(_ sender: Any) {
        colorView[0].backgroundColor = getColor(colorName: selectedType).0
        randomeColor[0] = getColor(colorName: selectedType).1
    }
    @IBAction func color2Btn(_ sender: Any) {
        colorView[1].backgroundColor = getColor(colorName: selectedType).0
        randomeColor[1] = getColor(colorName: selectedType).1
    }
    @IBAction func color3Btn(_ sender: Any) {
        colorView[2].backgroundColor = getColor(colorName: selectedType).0
        randomeColor[2] = getColor(colorName: selectedType).1
    }
    @IBAction func color4Btn(_ sender: Any) {
        colorView[3].backgroundColor = getColor(colorName: selectedType).0
        randomeColor[3] = getColor(colorName: selectedType).1
        print(randomeColor)
    }
    
    //獲取顏色String和Int
    func getColor(colorName:String) -> (UIColor,Int){
        switch colorName {
        case "Red":
            return (.red,0)
        case "Green":
            return (.green,1)
        case "Blue":
            return (.blue,2)
        case "Orange":
            return (.orange,3)
        case "Brown":
            return (.brown,4)
        case "Purple":
            return (.purple,5)
        case "Black":
            return (.black,6)
        default:
            return (.white,7)
        }
    }
 
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "multipleGame"{
            if let dest = segue.destination as? MastermineGameViewController{
                dest.singleOrMultiple = 1
                dest.multipleColor = randomeColor
            }
        }
        
    }


}
