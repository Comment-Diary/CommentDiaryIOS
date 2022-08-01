//
//  TodayWritingDiaryViewController.swift
//  CommentDiary
//
//  Created by 류창휘 on 2022/03/07.
//

import Foundation
import UIKit

class TodayWritingDiaryViewController : UIViewController {
    var dateModel = DateModel()
    var presentDateString = ""
    var selectedDateString = ""
    var todayDateString = ""
    
    enum hexColor {
        case backgroundColor
        case buttonBackgroundColor
        case dateLabelColor
        case writingDiaryLabelColor
        
        func getHexColor() -> UIColor {
            switch self {
            case .backgroundColor:
                return UIColor(hex: 0xF4EDE3)
            case .buttonBackgroundColor:
                return UIColor(hex: 0xFDFCF9)
            case .dateLabelColor:
                return UIColor(hex: 0xFFA665)
            case .writingDiaryLabelColor:
                return UIColor(hex: 0x4E4C49)
            }
        }
    }
    
    //MARK: - Properties
    @IBOutlet weak var dateLabel: UILabel!
    @IBOutlet weak var myDiaryLabel: UILabel!
    @IBOutlet weak var writingDiaryLabel: UILabel!
    @IBOutlet weak var writingDiaryBackView: UIView!
    @IBOutlet weak var writingDiaryButton: UIButton!
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        viewSetting()
        labelSetting()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        dateLabelSetting()
//        presentDateString = detailDayDateFormatter.string(from: Date(timeIntervalSinceNow: -25200))
        presentDateString = dateModel.detailDayDateFormatter.string(from: Date(timeIntervalSinceNow: -25200))
        todayDateString = dateModel.detailDayDateFormatter.string(from: Date(timeIntervalSinceNow: -25200))
    }
    
    func dateLabelSetting() {
        self.dateLabel.text = dateModel.krMonthDateFormatter.string(from: Date(timeIntervalSinceNow: -25200))
        //MM월dd일
        NotificationCenter.default.addObserver(self, selector: #selector(loadData(_:)), name: NSNotification.Name(rawValue: "SelectedDate"), object: nil)
        
        
        
        //날짜 선택시 yyyy.MM.dd
        NotificationCenter.default.addObserver(self, selector: #selector(updateData(_:)), name: NSNotification.Name(rawValue: "presentDate"), object: nil)
    }
    
    func labelSetting() {
        dateLabel.textColor = hexColor.dateLabelColor.getHexColor()
        dateLabel.font = UIFont.AppleSDGothic(.bold, size: 14)
        myDiaryLabel.textColor = hexColor.dateLabelColor.getHexColor()
        myDiaryLabel.font = UIFont.AppleSDGothic(.bold, size: 14)
        writingDiaryLabel.font = UIFont.AppleSDGothic(.bold, size: 21)
        writingDiaryLabel.textColor = hexColor.writingDiaryLabelColor.getHexColor()
    }
    func viewSetting() {
        writingDiaryBackView.layer.cornerRadius = 10
        view.backgroundColor = hexColor.backgroundColor.getHexColor()
        writingDiaryBackView.backgroundColor = hexColor.buttonBackgroundColor.getHexColor()
    }
    
    @objc func loadData(_ notification : NSNotification) {
        dateLabel.text = notification.object as? String ?? ""
        selectedDateString = notification.object as? String ?? ""
    }
    @objc func updateData(_ notification : NSNotification) {
        presentDateString = notification.object as? String ?? ""
    }

    
    @IBAction func allButtonTap(_ sender: Any) {
        let todayDiary2VC = UIStoryboard(name: "TodayDiary2", bundle: nil).instantiateViewController(identifier: "TodayDiary2ViewController") as! TodayDiary2ViewController
        self.navigationController?.pushViewController(todayDiary2VC, animated: true)
        todayDiary2VC.dateString = dateLabel.text ?? ""
        
    }
    
    
    @IBAction func writeDiaryButtonTap(_ sender: Any) {

    }
}
