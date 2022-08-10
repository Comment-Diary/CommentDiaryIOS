//
//  NotDiaryDayViewController.swift
//  CommentDiary
//
//  Created by 류창휘 on 2022/03/07.
//

import Foundation
import UIKit

class NotDiaryDayViewController: UIViewController {

    @IBOutlet weak var firstView: UIView!
    @IBOutlet weak var notDiaryDayLabel: UILabel!

    @IBOutlet weak var secondView: UIView!

    @IBOutlet weak var thirdView: UIView!

    @IBOutlet weak var fourthView: UIView!

    @IBOutlet weak var fifthView: UIView!

    override func viewDidLoad() {
        super.viewDidLoad()
        viewSetting()
        labelSetting()
    }



    func viewSetting() {
        view.backgroundColor = UIColor(hex: 0xF4EDE3)
        firstView.backgroundColor = UIColor(hex: 0xE2DFD7)
        secondView.backgroundColor = UIColor(hex: 0xE2DFD7)
        thirdView.backgroundColor = UIColor(hex: 0xE2DFD7)
        fourthView.backgroundColor = UIColor(hex: 0xE2DFD7)
        fifthView.backgroundColor = UIColor(hex: 0xE2DFD7)
    }

    func labelSetting() {
        notDiaryDayLabel.font = UIFont.AppleSDGothic(.medium, size: 12)
        notDiaryDayLabel.textColor = UIColor(hex: 0xD3CDBD)
    }

}
