

import UIKit

class RepeatTableViewController: UITableViewController {

    @IBOutlet weak var FrequencyText: UIButton!
    @IBOutlet weak var ChoiceRepeat: UIPickerView!
    @IBOutlet weak var EveryText: UIButton!
    @IBOutlet weak var MonthlyPick: UIDatePicker!
    @IBOutlet weak var DailyPick: UIPickerView!
    @IBOutlet weak var choiceView: UIView!
    @IBOutlet weak var rangeTimeView: UIView!
    @IBOutlet weak var WeeklyPick: UITableView!
    
    
    
    let repeatTime = ["Daily","Weekly","Monthly"]
    let dailyChoice = ["1","2","3","4","5","6","7","8","9","10"]
    let rangeTime = ["Hari"]

    override func viewDidLoad() {
        super.viewDidLoad()
        ChoiceRepeat.delegate = self
        ChoiceRepeat.dataSource = self
        DailyPick.delegate = self
        DailyPick.dataSource = self
    }
    
    @IBAction func showPicker(_ sender: Any) {
        if (choiceView.isHidden == true){
            choiceView.isHidden = false
        } else {
            choiceView.isHidden = true
        }
    }
    @IBAction func showRangePicker(_ sender: Any) {
        if (rangeTimeView.isHidden == true){
            rangeTimeView.isHidden = false
        } else {
            rangeTimeView.isHidden = true
        }
    }
    
}



extension RepeatTableViewController: UIPickerViewDelegate{
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        if pickerView.tag == 1 {
            if component == 1 {
                return rangeTime[row]
            } else {
                return dailyChoice[row]
            }
        } else  {
            return repeatTime[row]
        }
       
    }
}
extension RepeatTableViewController: UIPickerViewDataSource {
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        if pickerView.tag == 1 {
            return 2
        } else  {
            return 1
        }
    }

    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        if pickerView.tag == 1 {
            if component == 1 {
                return rangeTime.count
            } else {
                return dailyChoice.count
            }
        } else  {
            return repeatTime.count
        }
    }
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        if pickerView.tag == 1 {
            
        } else  {
            //FrequencyText.titleLabel = repeatTime[row]
            //EveryText.titleLabel = repeatTime[row]
            if repeatTime[row] == "Monthly" {
                MonthlyPick.isHidden = false
                DailyPick.isHidden = true
                WeeklyPick.isHidden = true

            } else if repeatTime[row] == "Weekly"{
                MonthlyPick.isHidden = true
                DailyPick.isHidden = true
                WeeklyPick.isHidden = false

            } else {
                MonthlyPick.isHidden = true
                DailyPick.isHidden = false
                WeeklyPick.isHidden = true
            }
        }
        }
}








