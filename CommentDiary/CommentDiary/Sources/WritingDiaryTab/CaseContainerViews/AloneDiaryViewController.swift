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
    
    //MARK: - Properties
    
    @IBOutlet weak var dateLabel: UILabel!
    
    @IBOutlet weak var myDiaryLabel: UILabel!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        dateLabelSetting()
    }
    
    func dateLabelSetting() {
        self.dateLabel.text = self.krMonthDateFormatter.string(from: Date())
        
        NotificationCenter.default.addObserver(self, selector: #selector(loadData(_:)), name: NSNotification.Name(rawValue: "SelectedDayDate"), object: nil)
    }
    
    @objc func loadData(_ notification : NSNotification) {
        dateLabel.text = notification.object as? String ?? ""
    }
}
