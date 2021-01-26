import UIKit

class ViewController: UIViewController {
    
    @IBOutlet weak var displayLabel: UILabel!
    
    // 一个flag，用于判断数字显示方式
    private var isFinishedTypingNum = true
    
    // 利用元组保存不同类型数据，存放操作数和操作符
    private var temp: (num: Double, oper: String)?
    
    private var displayVal: Double {
        get {
            guard let num = Double(displayLabel.text!) else {
                fatalError("解包失败/不能解包为数字")
            }
            return num
        }
    }
        
    @IBAction func calcButtonPressed(_ sender: UIButton) {
        
        isFinishedTypingNum = true
        
        if sender.currentTitle == "+/-" {
            displayLabel.text = isInteger(num: displayVal) ? String(Int(displayVal) * -1) : String(displayVal * -1)
            isFinishedTypingNum = false
        } else if sender.currentTitle == "AC" {
            displayLabel.text = "0"
        } else if sender.currentTitle == "%" {
            displayLabel.text = String(displayVal * 0.01)
        } else if sender.currentTitle == "=" {
            if let num = temp?.num, let oper = temp?.oper {
                switch oper {
                case "+":
                    displayLabel.text = isInteger(num: displayVal + num) ? String(Int(displayVal + num)) : String(displayVal + num)
                case "-":
                    displayLabel.text = isInteger(num: num - displayVal) ? String(Int(num - displayVal)) : String(num - displayVal)
                case "×":
                    displayLabel.text = isInteger(num: displayVal * num) ? String(Int(displayVal * num)) : String(displayVal * num)
                case "÷":
                    displayLabel.text = isInteger(num: num / displayVal) ? String(Int(num / displayVal)) : String(num / displayVal)
                default:
                    break
                }
            }
        } else {
            temp = (num: displayVal, oper: sender.currentTitle!)
        }
    
    }

    
    @IBAction func numButtonPressed(_ sender: UIButton) {
        
        if isFinishedTypingNum {
            displayLabel.text = sender.currentTitle
            isFinishedTypingNum = false
        } else {
            displayLabel.text = displayLabel.text! + sender.currentTitle!
        }
    }
    
    // 分开解决displayLabel显示0时输入数字或者.的情况
    @IBAction func pointNum(_ sender: UIButton) {
        if sender.currentTitle == "." {
            
            let isInt = isInteger(num: displayVal)
            
            if !isInt {
                // 浮点数则表示不能添加小数点
                return
            }
            displayLabel.text = displayLabel.text! + sender.currentTitle!
            isFinishedTypingNum = false
        }
    }
    
}

extension ViewController {
    
    func isInteger(num: Double) -> Bool {
        return floor(num) == num
    }
    
}
