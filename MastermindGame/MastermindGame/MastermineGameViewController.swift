//
//  MastermineGameViewController.swift
//  MastermindGame
//
//  Created by Shen Licheng on 19/11/2021.
//

import UIKit
import CoreData

class MastermineGameViewController: UIViewController {
    
    var Mind : Mastermind = Mastermind()
    var onClickCount = 0    //計算點擊次數，點擊clean將歸0
    var singleOrMultiple:Int? = 0
    var multipleColor:[Int] = []
    
    
    @IBOutlet weak var userName: UITextField!    
    
    @IBOutlet var randomColor: [UIView]!
    @IBOutlet var colorView0: [UIView]!
    @IBOutlet var colorView1: [UIView]!
    @IBOutlet var colorView2: [UIView]!
    @IBOutlet var colorView3: [UIView]!
    @IBOutlet var colorView4: [UIView]!
    @IBOutlet var colorView5: [UIView]!
    @IBOutlet var colorView6: [UIView]!
    @IBOutlet var colorView7: [UIView]!
    @IBOutlet var colorView8: [UIView]!
    
    @IBOutlet var colorSelectView: [UIButton]!
    
    override func viewDidLoad() {
        super.viewDidLoad()
    
        reStartGlobal()
        showAlertStartGame()
    }
    
    //顯示隨機顏色答案
    func displayRandomColor() {
        for i in 0...3{
            randomColor[i].backgroundColor = getColorCode(code: Mind.randomColorCombination[i])
        }
    }
    
    
    @IBAction func redColorBtn(_ sender: Any) {
        uploadColor(colorCode: 0)
    }
    @IBAction func greenColorBtn(_ sender: Any) {
        uploadColor(colorCode: 1)
    }
    @IBAction func blueColorBtn(_ sender: Any) {
        uploadColor(colorCode: 2)
    }
    @IBAction func orangeColorBtn(_ sender: Any) {
        uploadColor(colorCode: 3)
    }
    @IBAction func brownColorBtn(_ sender: Any) {
        uploadColor(colorCode: 4)
    }
    @IBAction func purpleColorBtn(_ sender: Any) {
        uploadColor(colorCode: 5)
    }
    @IBAction func blackColorBtn(_ sender: Any) {
        uploadColor(colorCode: 6)
    }
    @IBAction func whiteColorBtn(_ sender: Any) {
        uploadColor(colorCode: 7)
    }
    
    @IBAction func cleanBtn(_ sender: Any) {
        print(Mind.randomColorCombination)
        let colorView:[UIView] = getColorViewYPosition(Position: Mind.checkCount)
        for i in 0...3{
            colorView[i].backgroundColor = getColorCode(code: -1)
        }
        reStartLocal()
    }
    
    //檢查 button
    @IBAction func checkBtn(_ sender: Any) {
        let colorView:[UIView] = getColorViewYPosition(Position: Mind.checkCount)
        for i in 0...3{
            if Mind.clickColorCombination[i] == -1{
                showAlertErrorMessage()
                return
            }
        }
        CheckingResult(colorView: colorView)
//        print(Mind.checkCount)
    }
     
    //輸出檢查結果
    func CheckingResult(colorView:[UIView]){
        colorView[onClickCount].layer.borderWidth = 0
        Mind.appenColor()
        let checkColor = Mind.checkColor
        
        for i in 0...3 {
            if checkColor[i] == 2{
                colorView[4+i].backgroundColor = getColorCode(code: 6)
            }else if checkColor[i] == 1{
                colorView[4+i].backgroundColor = getColorCode(code: -1)
            }else{
                colorView[4+i].backgroundColor = getColorCode(code: 7)
            }
        }
        
        Mind.checkCountAdd()
        if checkColor[0] == 2 && checkColor[1] == 2 && checkColor[2] == 2 && checkColor[3] == 2 {
            displayRandomColor()
            showAlertViewWin()
        }else{
            if Mind.checkCount == 9{
                displayRandomColor()
                showAlertViewFalse()
            }else{print("keep trying!")}
        }
        reStartLocal()
    }
    
    //display onClick color
    func uploadColor(colorCode:Int){
        let colorView:[UIView] = getColorViewYPosition(Position: Mind.checkCount)
        colorView[onClickCount].layer.borderWidth = 0
        colorView[onClickCount].backgroundColor = getColorCode(code: colorCode)
        onClickCount = Mind.onClickColorCombination(colorCode: colorCode, onClickCount: onClickCount)
        colorView[onClickCount].layer.borderWidth = 5
        colorView[onClickCount].layer.borderColor = getColorCode(code: -2).cgColor
    }
       
    //獲取y軸
    func getColorViewYPosition(Position : Int) -> [UIView]{
        var colorView:[UIView]?
        
        switch Position {
        case 0:
            colorView = colorView0
        case 1:
            colorView = colorView1
        case 2:
            colorView = colorView2
        case 3:
            colorView = colorView3
        case 4:
            colorView = colorView4
        case 5:
            colorView = colorView5
        case 6:
            colorView = colorView6
        case 7:
            colorView = colorView7
        default:
            colorView = colorView8
        }
        return colorView!
    }
    
    //獲取顏色數字
    func getColorCode(code: Int) -> UIColor{
        switch code {
        case -2:
            return .systemGray6
        case -1:
            return .systemGray3
        case 0:
            return .red
        case 1:
            return .green
        case 2:
            return .blue
        case 3:
            return .orange
        case 4:
            return .brown
        case 5:
            return .purple
        case 6:
            return .black
        default:
            return .white
        }
    }

    //全局清理
    func reStartGlobal(){
        for i in 0...8{
            let colorView:[UIView] = getColorViewYPosition(Position: i)
            for y in 0...7 {
                switch y {
                case 0...3:
                    colorView[y].layer.cornerRadius = 25
                default:
                    colorView[y].layer.cornerRadius = 10
                }
                colorView[y].backgroundColor = getColorCode(code: -1)
                colorView[y].layer.borderWidth = 0
            }
        }
        for i in 0...3{
            randomColor[i].layer.cornerRadius = 25
            randomColor[i].backgroundColor = getColorCode(code: -1)
        }
        Mind = Mastermind()
        if singleOrMultiple! == 1{
            Mind.randomColorCombination = multipleColor
        }
        
        reStartLocal()  //局部清理
    }
    
    //局部清理
    func reStartLocal(){
        let colorView:[UIView] = getColorViewYPosition(Position: Mind.checkCount)
        Mind.clickColorCombination = [-1,-1,-1,-1]
        colorView[onClickCount].layer.borderWidth = 0
        onClickCount = 0    //計算點擊次數，點擊clean將歸0
        colorView[0].layer.borderWidth = 5
        colorView[0].layer.borderColor = getColorCode(code: -2).cgColor
    }
    
    //開始遊戲獲取用戶名
    func showAlertStartGame(){
        let alert = UIAlertController(title: "Start Game", message: "Please Enter your player name!", preferredStyle: .alert)
        alert.addTextField{(usernameText) ->Void in
            usernameText.placeholder = "User"
        }
        
        let cancel = UIAlertAction(title: "No", style: .cancel, handler: {
            ACTION in
            self.userName.text = ("Player: \(self.Mind.userName)")
        })
        let login = UIAlertAction(title: "Enter", style: .default, handler: {
            ACTION in
            self.Mind.userName = alert.textFields?.first?.text ?? self.Mind.userName
            self.userName.text = ("Player: \(self.Mind.userName)")
        })

        alert.addAction(cancel)
        alert.addAction(login)
        self.present(alert, animated: true, completion: nil)
    }
    
    //遊戲勝利結束儲存數據
    func saveAction(YorN:String){
        let appDelegate = UIApplication.shared.delegate as! AppDelegate
        let context: NSManagedObjectContext = appDelegate.persistentContainer.viewContext
        let entity = NSEntityDescription.entity(forEntityName: "Game_History", in: context)
        let newGame_History = Game_History(entity: entity!, insertInto: context)
        
        if singleOrMultiple == 1{
            newGame_History.user_name = "\(Mind.userName) (PVP)"
        }else{
            newGame_History.user_name = "\(Mind.userName) (PVE)"
        }
        
        if YorN == "Y"{
            newGame_History.num_of_time = String(Mind.checkCount)
        }else{
            newGame_History.num_of_time = "Fail"
        }
        
        do{
            try context.save()
    
        }catch{
            print("save error!")
        }
    }
    
    //失敗顯示信息
    func showAlertViewFalse() {
        let alertController = UIAlertController(
                title: "Lose",
                message: "",
                preferredStyle: .alert)

            // 建立[ReStart]按鈕
            let okAction = UIAlertAction(
              title: "ReStart",
              style: .default,
              handler: {
                  (action: UIAlertAction!) -> Void in
                  self.saveAction(YorN: "N")
                  if self.singleOrMultiple == 1{
                      self.navigationController?.popViewController(animated:true)
                  }
                  self.viewDidLoad()
            })
            alertController.addAction(okAction)

            // 顯示提示框
        self.present(
              alertController,
              animated: true,
              completion: nil)
        }
    
    //成功顯示信息
    func showAlertViewWin() {
        let alertController = UIAlertController(
                title: "Win",
                message: "",
                preferredStyle: .alert)

            // 建立[ReStart]按鈕
            let okAction = UIAlertAction(
              title: "ReStart",
              style: .default,
              handler: {
                  (action: UIAlertAction!) -> Void in
                  self.saveAction(YorN: "Y")
                  if self.singleOrMultiple == 1{
                      self.navigationController?.popViewController(animated:true)
                  }
                  self.viewDidLoad()
              })
            alertController.addAction(okAction)

        self.present(
              alertController,
              animated: true,
              completion: nil)
        }
    
    //顏色唔夠顯示信息
    func showAlertErrorMessage(){
        let alert = UIAlertController(title: "Error", message: "Row is not complete!", preferredStyle: .alert)
                let cancel = UIAlertAction(title: "OK", style: .cancel, handler: {
                    ACTION in
                })

                alert.addAction(cancel)
                self.present(alert, animated: true, completion: nil)
    }
    
}
