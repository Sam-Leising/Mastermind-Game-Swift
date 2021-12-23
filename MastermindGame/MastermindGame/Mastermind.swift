//
//  Mastermind.swift
//  MastermindGame
//
//  Created by Shen Licheng on 18/12/2021.
//

import Foundation
import UIKit

class Mastermind{
    var colorCombination:Set<Int> = [0,1,2,3,4,5,6,7]       //auto random
    var randomColorCombination:[Int] = []       //get 0-3 random color
    var checkColor:[Int] = []       //判斷顏色
    var userName:String = "UserName"    //默認用戶名
    var checkCount:Int = 0          //計算成功點擊check次數
    var clickColorCombination:[Int] = [-1,-1,-1,-1]
    
    
    init(){
        for i in 0...3{
            let color = colorCombination[colorCombination.index(colorCombination.startIndex, offsetBy: i)]
            randomColorCombination.insert(color, at: i)
        }
    }
    
    //獲取顏色結果，2:位置正確 1:有，但位置不正確 0:沒有
    func appenColor(){
        checkColor = []
        for i in 0...3{
            if randomColorCombination.contains(clickColorCombination[i]){
                if randomColorCombination[i] == clickColorCombination[i]{
                    checkColor.append(2)
                }else{
                    checkColor.append(1)
                }
            }else{
                checkColor.append(0)
            }
        }
        checkColor = checkColor.sorted(by:>)
    }
    
    //Y軸+1
    func checkCountAdd(){
        checkCount += 1
    }
    
    //判斷顏色位置
    func onClickColorCombination(colorCode:Int, onClickCount:Int) -> Int{
        var clickPosition = onClickCount
        clickColorCombination[clickPosition] = colorCode
        if clickPosition != 3{
            clickPosition += 1
        }else{
            clickPosition = 0
        }
        return clickPosition
    }
    
    //多人遊戲獲取隨機顏色
    func mutipleRandomColor(randomColor:[Int]){
        randomColorCombination = randomColor
    }
    
}
