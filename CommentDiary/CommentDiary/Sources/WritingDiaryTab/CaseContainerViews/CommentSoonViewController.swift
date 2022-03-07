//
//  CommentSoonViewController.swift
//  CommentDiary
//
//  Created by 류창휘 on 2022/03/07.
//

import Foundation
import UIKit

class CommentSoonViewController:UIViewController {
    private lazy var krMonthDateFormatter: DateFormatter = {
        let df = DateFormatter()
        df.locale = Locale(identifier: "ko_KR")
        df.dateFormat = "MM월 dd일"
        return df
    }()
    
    //MARK: - Properties
    @IBOutlet weak var dateLabel: UILabel!
    
    @IBOutlet weak var myDiaryLabel: UILabel!
    
    @IBOutlet weak var titleLabel: UILabel!
    
    @IBOutlet weak var contentLabel: UILabel!
    
    @IBOutlet weak var topBackView: UIView!
    
    @IBOutlet weak var detailDiaryButton: UIButton!
    
    @IBOutlet weak var separateView: UIView!
    
    @IBOutlet weak var backView: UIView!
    @IBOutlet weak var bottomBackView: UIView!
    
    @IBOutlet weak var waitLabel: UILabel!
    
    
    //MARK: LifeCycle
    override func viewDidLoad() {
        super.viewDidLoad()
        dateLabelSetting()
        labelSetting()
        viewSetting()
    }
    func dateLabelSetting() {
        
    }
    
    func labelSetting() {
        
    }
    func viewSetting() {
        self.backView.backgroundColor = UIColor(hex: 0xFDFCF9)
        self.topBackView.backgroundColor = UIColor(hex: 0xFDFCF9)
    }
    
    
    //MARK: - Actions
}

    //MARK: - Extensions
