//
//  PeriodCommentViewController.swift
//  CommentDiary
//
//  Created by 류창휘 on 2022/03/13.
//

import Foundation
import UIKit

protocol CommentLabelChangeDelegate {
    func onChange(data: String)
}
protocol CommentDateChangeDelegate {
    func onDateChange(data: String)
}

class PeriodCommentViewController : UIViewController {
    //delegate
    var delegate: CommentLabelChangeDelegate?
    var dateDelegate: CommentDateChangeDelegate?
    
    var yearString = "2020"
    var monthString = "01"
    var allLookString = ""
    var dateCaseString: String = ""
    var dateChangeString = ""
    
    var yearArray: [Int] = []
    var monthArray = ["01", "02", "03", "04", "05", "06", "07", "08", "09", "10", "11", "12"]
    
    var todayYear = "0"
    let todayMonth = "0"
    
    //MARK: - Preperties
    
    @IBOutlet weak var mainView: UIView!
    
    @IBOutlet weak var periodLabel: UILabel!
    
    @IBOutlet weak var pickerBackView: UIView!
    
    @IBOutlet weak var pickerStackView: UIStackView!
    
    @IBOutlet weak var yearPickerView: UIPickerView!
    
    @IBOutlet weak var monthPIckerView: UIPickerView!
    
    @IBOutlet weak var allButton: UIButton!
    
    @IBOutlet weak var saveButton: UIButton!
    
    @IBOutlet weak var bottomBackView: UIView!
    
    //MARK: - LifeCycle
    override func viewDidLoad() {
        super.viewDidLoad()
        yearPickerView.delegate = self
        monthPIckerView.delegate = self
        
        viewSetting()
        
        buttonSetting()
        setAvailableDate()
        labelSetting()
    }
    
    override func viewWillLayoutSubviews() {
        yearPickerView.subviews[1].backgroundColor = .clear
        monthPIckerView.subviews[1].backgroundColor = .clear
//        yearPickerView.subviews[1].s
    }
    
    func setAvailableDate() {
        let formatterYear = DateFormatter()
        formatterYear.dateFormat = "yyyy"
        todayYear = formatterYear.string(from: Date())
        
        for i in 2020...Int(todayYear)! {
            yearArray.append(i)
        }
    }
    func labelSetting() {
        periodLabel.text = "기간별 보기"
        periodLabel.textColor = UIColor(hex: 0x4E4C49)
        periodLabel.font = UIFont.AppleSDGothic(.bold, size: 20)
        
    }
    
    func viewSetting() {
        mainView.backgroundColor = UIColor(hex: 0xFDF8E9)
        pickerBackView.backgroundColor = UIColor(hex: 0xFDF8E9)
        yearPickerView.backgroundColor = UIColor(hex: 0xFDFCF9)
        monthPIckerView.backgroundColor = UIColor(hex: 0xFDFCF9)
        yearPickerView.layer.cornerRadius = 4
        monthPIckerView.layer.cornerRadius = 4
        mainView.layer.cornerRadius = 10
        
    }
    
    func buttonSetting() {
        allButton.setTitle("전체보기", for: .normal)
        allButton.titleLabel?.font = .AppleSDGothic(.bold, size: 14)
        allButton.setTitleColor(UIColor(hex: 0x5F5D59), for: .normal)
        allButton.setTitleColor(UIColor(hex: 0x5F5D59), for: .highlighted)
        saveButton.setTitle("저장", for: .normal)
        saveButton.titleLabel?.font = .AppleSDGothic(.bold, size: 14)
        saveButton.setTitleColor(UIColor(hex: 0x5F5D59), for: .normal)
        saveButton.setTitleColor(UIColor(hex: 0x5F5D59), for: .highlighted)
        
        allButton.backgroundColor = UIColor(hex: 0xFDF8E9)
        saveButton.backgroundColor = UIColor(hex: 0xFDF8E9)
        allButton.layer.borderColor = UIColor(hex: 0xE2DFD7).cgColor
        saveButton.layer.borderColor = UIColor(hex: 0xE2DFD7).cgColor
        allButton.layer.borderWidth = 1
        saveButton.layer.borderWidth = 1
        
        allButton.layer.cornerRadius = 10
        saveButton.layer.cornerRadius = 10
        saveButton.layer.maskedCorners = .layerMaxXMaxYCorner
        allButton.layer.maskedCorners = .layerMinXMaxYCorner
        bottomBackView.layer.cornerRadius = 10
        bottomBackView.layer.maskedCorners = [.layerMaxXMaxYCorner, .layerMinXMaxYCorner]
    }
    
    //MARK: - Actions
    
    @IBAction func allButtonTap(_ sender: Any) {
        dismiss(animated: true, completion: nil)
        dateCaseString = "전체보기"
        dateChangeString = "전체보기"
        delegate?.onChange(data: dateCaseString)
        dateDelegate?.onDateChange(data: dateChangeString)
        print(dateCaseString)
    }
    
    @IBAction func saveButtonTap(_ sender: Any) {
        dateCaseString = "\(yearString)년 \(monthString)월"
        dateChangeString = "\(yearString).\(monthString)"
        delegate?.onChange(data: dateCaseString)
        dateDelegate?.onDateChange(data: dateChangeString)
        dismiss(animated: true, completion: nil)
        print(dateCaseString)
    }
    
    
}

    //MARK: - extensions
extension PeriodCommentViewController: UIPickerViewDelegate, UIPickerViewDataSource {
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        switch pickerView {
        case yearPickerView:
            return yearArray.count
        case monthPIckerView:
            return monthArray.count
        default:
            return 0
        }
    }
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        switch pickerView {
        case yearPickerView:
            return "\(yearArray[row])년"
        case monthPIckerView:
            return "\(monthArray[row])월"
        default:
            return ""
        }
    }
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        switch pickerView {
        case yearPickerView:
            yearString = "\(yearArray[row])"
            print(yearString)
        case monthPIckerView:
            monthString = "\(monthArray[row])"
            print(monthString)
        default:
            allLookString = "전체보기"
        }
    }
    func pickerView(_ pickerView: UIPickerView, attributedTitleForRow row: Int, forComponent component: Int) -> NSAttributedString? {
        switch pickerView {
        case yearPickerView:
            return NSAttributedString(string: "\(self.yearArray[row])년", attributes: [.foregroundColor:UIColor(hex: 0x4E4C49)])
        case monthPIckerView:
            return NSAttributedString(string: "\(self.monthArray[row])월", attributes: [.foregroundColor:UIColor(hex: 0x4E4C49)])
        default:
            return NSAttributedString(string: "\(self.yearArray[row])", attributes: [.foregroundColor:UIColor(hex: 0x4E4C49)])

        }
        
    }
    
}
