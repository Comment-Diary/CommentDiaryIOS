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
    
    var presentDateString = ""
    //MARK: - Properties
    
    
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
    }
    
    func dateLabelSetting() {
        self.dateLabel.text = self.krMonthDateFormatter.string(from: Date(timeIntervalSinceNow: -25200))
//        self.dateLabel.text = self.krMonthDateFormatter.string(from: Date())
        
        NotificationCenter.default.addObserver(self, selector: #selector(loadData(_:)), name: NSNotification.Name(rawValue: "SelectedDate"), object: nil)
        
        NotificationCenter.default.addObserver(self, selector: #selector(updateData(_:)), name: NSNotification.Name(rawValue: "presentDate"), object: nil)
        
        
        

    }
    
    func labelSetting() {
        dateLabel.textColor = UIColor(hex: 0xFFAC86)
        dateLabel.font = UIFont.AppleSDGothic(.bold, size: 14)
        myDiaryLabel.textColor = UIColor(hex: 0xFFAC86)
        myDiaryLabel.font = UIFont.AppleSDGothic(.bold, size: 14)
        writingDiaryLabel.font = UIFont.AppleSDGothic(.bold, size: 21)
        writingDiaryLabel.textColor = UIColor(hex: 0x4E4C49)
    }
    
    
    func viewSetting() {
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
    }
    @objc func updateData(_ notification : NSNotification) {
        presentDateString = notification.object as? String ?? ""
    }

    
    @IBAction func writeDiaryButtonTap(_ sender: Any) {
        let todayDiaryVC = UIStoryboard(name: "TodayDiary", bundle: nil).instantiateViewController(identifier: "TodayDiaryViewController") as! TodayDiaryViewController
        todayDiaryVC.dateText = presentDateString
        self.navigationController?.pushViewController(todayDiaryVC, animated: true)
    }
}
