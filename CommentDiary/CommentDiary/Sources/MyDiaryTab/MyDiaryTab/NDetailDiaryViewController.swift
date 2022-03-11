//
//  NDetailDiaryViewController.swift
//  CommentDiary
//
//  Created by 류창휘 on 2022/02/25.
//

import Foundation
import UIKit

class NDetailDiaryViewController: UIViewController {
    //MARK: - Properties
    
    @IBOutlet weak var backButton: UIButton!
    @IBOutlet weak var deleteButton: UIButton!
    @IBOutlet weak var fixButton: UIButton!
    @IBOutlet weak var dateLabel: UILabel!
    
    @IBOutlet weak var diaryTItleLabel: UILabel!
    
    @IBOutlet weak var diaryContentLabel: UILabel!
    
    @IBOutlet weak var separateLineView: UIView!
    
    @IBOutlet weak var topBarView: UIView!
    
    @IBOutlet weak var diaryScrollView: UIScrollView!
    
    
    //MARK: - LifeCycle
    override func viewDidLoad() {
        super.viewDidLoad()
        backgroundSetting()
        labelSetting()
        buttonSetting()
        viewSetting()
    }
    
    
    func backgroundSetting() {
        self.view.backgroundColor = UIColor.mainBackgroundColor
    }
    func labelSetting() {
        
    }
    func buttonSetting() {
        
    }
    func viewSetting() {
        self.topBarView.backgroundColor = UIColor.mainBackgroundColor
        self.separateLineView.backgroundColor = UIColor(hex: 0xE2DFD7)
        self.diaryScrollView.layer.cornerRadius = 10
        
    }
    //MARK: - Actions
}


    //MARK: - Extentions
