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
        df.locale = Locale(identifier: "ko_KR")
        df.dateFormat = "dd일"
        return df
    }()
    
    var diaryIDValue: Int = 0
    
    //MARK: - Properties
    
    @IBOutlet weak var dateLabel: UILabel!
    
    @IBOutlet weak var myDiaryLabel: UILabel!
    
    @IBOutlet weak var titleLabel: UILabel!
    
    @IBOutlet weak var contentLabel: UILabel!
    
    @IBOutlet weak var entireDiaryButton: UIButton!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        dateLabelSetting()
    }
    
    func dateLabelSetting() {
        self.dateLabel.text = self.krMonthDateFormatter.string(from: Date())
        
        NotificationCenter.default.addObserver(self, selector: #selector(loadData(_:)), name: NSNotification.Name(rawValue: "SelectedDayDate"), object: nil)
        
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
        self.navigationController?.pushViewController(nSaveVC, animated: true)
        nSaveVC.diaryCheckToggle = true
        nSaveVC.diaryidInt = diaryIDValue
        print(diaryIDValue, "보낸 아이디 값")
    }
    
}
