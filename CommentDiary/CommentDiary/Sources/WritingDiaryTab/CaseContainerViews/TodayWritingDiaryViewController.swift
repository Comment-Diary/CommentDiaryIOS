//
//  TodayWritingDiaryViewController.swift
//  CommentDiary
//
//  Created by 류창휘 on 2022/03/07.
//

import Foundation
import UIKit

class TodayWritingDiaryViewController : UIViewController {
    private lazy var krMonthDateFormatter: DateFormatter = {
        let df = DateFormatter()
        df.locale = Locale(identifier: "ko_KR")
        df.dateFormat = "MM월 dd일"
        return df
    }()
    
    lazy var detailDayDateFormatter: DateFormatter = {
        let df = DateFormatter()
//        df.locale = Locale(identifier: "ko_KR")
//        df.timeZone = TimeZone(identifier: "UTC")
        df.dateFormat = "yyyy.MM.dd"
        return df
    }()
    
    var presentDateString = ""
    var selectedDateString = ""
    var todayDateString = ""
    
    //MARK: - Properties
    
    @IBOutlet weak var infoLabel: UILabel!
    
    @IBOutlet weak var dateLabel: UILabel!
    
    @IBOutlet weak var myDiaryLabel: UILabel!
    
    @IBOutlet weak var writingDiaryLabel: UILabel!
    
    
    
    
    @IBOutlet weak var writingDiaryBackView: UIView!
    
    @IBOutlet weak var firstNoteView: UIView!
    @IBOutlet weak var secondNoteView: UIView!
    @IBOutlet weak var thirdNoteView: UIView!
    @IBOutlet weak var fourthNoteView: UIView!
    @IBOutlet weak var fifthNoteView: UIView!
    
    @IBOutlet weak var writingDiaryButton: UIButton!
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        viewSetting()

        labelSetting()
        
//        writingDiaryButton.contentMode = .scaleToFill
    }
    
    override func viewWillAppear(_ animated: Bool) {
        dateLabelSetting()
        presentDateString = detailDayDateFormatter.string(from: Date(timeIntervalSinceNow: -25200))
        todayDateString = detailDayDateFormatter.string(from: Date(timeIntervalSinceNow: -25200))
    }
    
    func dateLabelSetting() {
        self.dateLabel.text = self.krMonthDateFormatter.string(from: Date(timeIntervalSinceNow: -25200))

        
        //MM월dd일
        NotificationCenter.default.addObserver(self, selector: #selector(loadData(_:)), name: NSNotification.Name(rawValue: "SelectedDate"), object: nil)
        
        
        
        //날짜 선택시 yyyy.MM.dd
        NotificationCenter.default.addObserver(self, selector: #selector(updateData(_:)), name: NSNotification.Name(rawValue: "presentDate"), object: nil)
        //날짜 선택 없이 yyyy.MM.dd
//        NotificationCenter.default.addObserver(self, selector: #selector(loadTodayData(_:)), name: NSNotification.Name(rawValue: "loadDate"), object: nil)
        

    }
    
    func labelSetting() {
        infoLabel.text = "오늘은 기록이 없어요. 기록을 하고 코멘트를 받아봐요 :)"
        infoLabel.textColor = UIColor(hex: 0xD3CDBD)
        infoLabel.font = UIFont.AppleSDGothic(.medium, size: 12)
        dateLabel.textColor = UIColor(hex: 0xFFAC86)
        dateLabel.font = UIFont.AppleSDGothic(.bold, size: 14)
        myDiaryLabel.textColor = UIColor(hex: 0xFFAC86)
        myDiaryLabel.font = UIFont.AppleSDGothic(.bold, size: 14)
        writingDiaryLabel.font = UIFont.AppleSDGothic(.bold, size: 21)
        writingDiaryLabel.textColor = UIColor(hex: 0x4E4C49)
    }
    
    
    func viewSetting() {
        writingDiaryBackView.layer.cornerRadius = 10
        view.backgroundColor = UIColor(hex: 0xF4EDE3)
        writingDiaryBackView.backgroundColor = UIColor(hex: 0xFDFCF9)
        firstNoteView.backgroundColor = UIColor(hex: 0xE2DFD7)
        secondNoteView.backgroundColor = UIColor(hex: 0xE2DFD7)
        thirdNoteView.backgroundColor = UIColor(hex: 0xE2DFD7)
        fourthNoteView.backgroundColor = UIColor(hex: 0xE2DFD7)
        fifthNoteView.backgroundColor = UIColor(hex: 0xE2DFD7)
    }
    
    @objc func loadData(_ notification : NSNotification) {
        dateLabel.text = notification.object as? String ?? ""
        selectedDateString = notification.object as? String ?? ""
    }
    @objc func updateData(_ notification : NSNotification) {
        presentDateString = notification.object as? String ?? ""
    }
//    @objc func loadTodayData(_ notification : NSNotification) {
//        presentDateString = notification.object as? String ?? ""
//    }

    
    @IBAction func allButtonTap(_ sender: Any) {
        let todayDiaryVC = UIStoryboard(name: "TodayDiary", bundle: nil).instantiateViewController(identifier: "TodayDiaryViewController") as! TodayDiaryViewController
        todayDiaryVC.dateText = presentDateString

        self.navigationController?.pushViewController(todayDiaryVC, animated: true)
        
    }
    
    
    @IBAction func writeDiaryButtonTap(_ sender: Any) {

//        let todayDiaryVC = UIStoryboard(name: "TodayDiary", bundle: nil).instantiateViewController(identifier: "TodayDiaryViewController") as! TodayDiaryViewController
//        todayDiaryVC.dateText = presentDateString
//
//        self.navigationController?.pushViewController(todayDiaryVC, animated: true)
    }
}
