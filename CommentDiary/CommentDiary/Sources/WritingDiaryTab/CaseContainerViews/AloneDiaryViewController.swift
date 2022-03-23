//
//  AloneDiaryViewController.swift
//  CommentDiary
//
//  Created by 류창휘 on 2022/03/07.
//

import Foundation
import UIKit

class AloneDiaryViewController: UIViewController {
    private lazy var krMonthDateFormatter: DateFormatter = {
        let df = DateFormatter()
//        df.locale = Locale(identifier: "ko_KR")
        df.dateFormat = "MM월 dd일"
        return df
    }()
    
    var diaryIDValue: Int = 0
    
    //MARK: - Properties
    
    @IBOutlet weak var topBackView: UIView!
    
    @IBOutlet weak var separateView: UIView!
    
    
    @IBOutlet weak var dateLabel: UILabel!
    
    @IBOutlet weak var myDiaryLabel: UILabel!
    
    @IBOutlet weak var titleLabel: UILabel!
    
    @IBOutlet weak var contentLabel: UILabel!
    
    @IBOutlet weak var entireDiaryButton: UIButton!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        dateLabelSetting()
        buttonSetting()
        viewSetting()
    }
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        loadTodayData()
    }
    
    
    func viewSetting() {
        topBackView.backgroundColor = UIColor(hex: 0xFDFCF9)
        view.backgroundColor = UIColor(hex: 0xFDFCF9)
        separateView.backgroundColor = UIColor(hex: 0xE2DFD7)
    }
    
    
    func loadTodayData() {
//        NotificationCenter.default.addObserver(self, selector: #selector(todayLoadDate(_:)), name: NSNotification.Name("loadDate"), object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(todayLoadtitle(_:)), name: NSNotification.Name(rawValue: "loadTitle"), object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(todayLoadContent(_:)), name: NSNotification.Name(rawValue: "loadContent"), object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(todayLoadID(_:)), name: NSNotification.Name(rawValue: "loadID"), object: nil)
    }
//    @objc func todayLoadDate(_ notification : NSNotification) {
//        dateLabel.text = notification.object as? String ?? ""
//    }
    @objc func todayLoadtitle(_ notification : NSNotification) {
        titleLabel.text = notification.object as? String ?? ""
    }
    @objc func todayLoadContent(_ notification : NSNotification) {
        contentLabel.text = notification.object as? String ?? ""
    }
    //아이디값 적기
    @objc func todayLoadID(_ notification : NSNotification) {
        diaryIDValue = notification.object as? Int ?? 0
    }
    
    
    
    
    
    
    func buttonSetting() {
        entireDiaryButton.setTitle("전체보기", for: .normal)
        entireDiaryButton.setTitleColor(UIColor(hex: 0x878379), for: .normal)
        entireDiaryButton.titleLabel?.font = UIFont.AppleSDGothic(.medium, size: 12)
    }
    
    func dateLabelSetting() {
        self.dateLabel.text = self.krMonthDateFormatter.string(from: Date(timeIntervalSinceNow: -25200))
        dateLabel.textColor = UIColor(hex: 0xFFAC86)
        myDiaryLabel.textColor = UIColor(hex: 0xFFAC86)
        dateLabel.font = UIFont.AppleSDGothic(.bold, size: 15)
        myDiaryLabel.font = UIFont.AppleSDGothic(.bold, size: 15)
        titleLabel.textColor = UIColor(hex: 0x4E4C49)
        titleLabel.font = UIFont.AppleSDGothic(.bold, size: 18)
        contentLabel.textColor = UIColor(hex: 0x4E4C49)
        contentLabel.font = UIFont.AppleSDGothic(.medium, size: 15)
        

        
        NotificationCenter.default.addObserver(self, selector: #selector(loadData(_:)), name: NSNotification.Name(rawValue: "SelectedDate"), object: nil)
        
        NotificationCenter.default.addObserver(self, selector: #selector(loadTitle(_:)), name: NSNotification.Name(rawValue: "SelectedTitle"), object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(loadContent(_:)), name: NSNotification.Name(rawValue: "SelectedContent"), object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(loadID(_:)), name: NSNotification.Name(rawValue: "SelectedID"), object: nil)
    }
    
    @objc func loadData(_ notification : NSNotification) {
        dateLabel.text = notification.object as? String ?? ""
    }
    
    @objc func loadTitle(_ notification: NSNotification) {
        titleLabel.text = notification.object as? String ?? ""
    }
    @objc func loadContent(_ notification: NSNotification) {
        contentLabel.text = notification.object as? String ?? ""
    }
    @objc func loadID(_ notification: NSNotification) {
        diaryIDValue = notification.object as? Int ?? 0
    }
    
    
    @IBAction func entireDiaryButtonTap(_ sender: Any) {
        let nSaveVC = UIStoryboard(name: "NSave", bundle: nil).instantiateViewController(withIdentifier: "NSaveViewController") as! NSaveViewController
        nSaveVC.diaryCheckToggle = true
        nSaveVC.diaryidInt = diaryIDValue
        print(diaryIDValue, "보낸 아이디 값")
        self.navigationController?.pushViewController(nSaveVC, animated: true)

    }
    
}
