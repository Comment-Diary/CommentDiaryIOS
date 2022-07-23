//
//  TopSheetViewController.swift
//  CommentDiary
//
//  Created by 류창휘 on 2022/07/18.
//

import Foundation
import UIKit

class TopSheetViewController : UIViewController {
    enum hexColor {
        case backgroundColor
        case commentDiaryMainColor
        case aloneDiaryMainColor
        case diaryTypeButtonBackgroundColor
        case diaryTypeLabelColor
        case navigationLabelColor
        case navigationSeparateColor
        case diaryTypeSeparateColor
        case buttonSeledtedColor
        
        func getHexColor() -> UIColor {
            switch self {
            case .backgroundColor:
                return UIColor(hex: 0xFDFCF9)
            case .commentDiaryMainColor:
                return UIColor(hex: 0x5ABD80)
            case .aloneDiaryMainColor:
                return UIColor(hex: 0xFFA665)
            case .diaryTypeButtonBackgroundColor:
                return UIColor(hex: 0xE2DFD7)
            case .diaryTypeLabelColor:
                return UIColor(hex: 0x4E4C49)
            case .navigationSeparateColor:
                return UIColor(hex: 0xF4F1EB)
            case .navigationLabelColor:
                return UIColor(hex: 0x4E4C49)
            case .diaryTypeSeparateColor:
                return UIColor(hex: 0xE2DFD7)
            case .buttonSeledtedColor:
                return UIColor(hex: 0x5F5D59)
            }
        }
    }
    
    
    
    
    // MARK: - PROPERTIES
    
    @IBOutlet weak var typeCommentbuttonSelectedView: UIView!
    @IBOutlet weak var typeAloneButtonSelectedView: UIView!
    @IBOutlet weak var typeBackView: UIView!
    @IBOutlet weak var typeSeparateView: UIView!
    @IBOutlet weak var typeCommentLabel: UILabel!
    @IBOutlet weak var typeCommentButtonView: UIView!
    @IBOutlet weak var typeCommentDiaryView: UIView!
    @IBOutlet weak var typeCommentCircleView: UIView!
    @IBOutlet weak var typeAloneDiaryVIew: UIView!
    @IBOutlet weak var typeAloneCircleView: UIView!
    @IBOutlet weak var typeAloneLabel: UILabel!
    @IBOutlet weak var typeAloneButtonView: UIView!
    @IBOutlet weak var navigationBackView: UIView!
    @IBOutlet weak var navigationSeparateVIew: UIView!
    @IBOutlet weak var navigationLabel: UILabel!
    @IBOutlet weak var topsheetView: UIView!
    @IBOutlet weak var topsheetViewHeightConstraint: NSLayoutConstraint!
    @IBOutlet weak var topsheetViewLeadingConstraint: NSLayoutConstraint!
    @IBOutlet weak var topsheetViewTopConstraint: NSLayoutConstraint!
    @IBOutlet weak var topsheetViewTrailingConstraint: NSLayoutConstraint!
    
    @IBOutlet weak var commentDiaryButton: UIButton!
    
    @IBOutlet weak var aloneDiaryButton: UIButton!
    
    private var isTopSheetShown = false
    private var selectedCommentDiaryButton = true
    
    
    // MARK: - LIFECYCLE
    override func viewDidLoad() {
        super.viewDidLoad()
        viewSetting()
        labelSetting()
        diaryTypeUpdateUI()
    }
    override func viewWillAppear(_ animated: Bool) {
        topsheetShown()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
//        diaryTypeUpdateUI()
    }
    
    func viewSetting() {
        topsheetView.backgroundColor = hexColor.backgroundColor.getHexColor()
        typeBackView.backgroundColor = hexColor.backgroundColor.getHexColor()
        typeSeparateView.backgroundColor = hexColor.diaryTypeSeparateColor.getHexColor()
        typeCommentDiaryView.backgroundColor = hexColor.backgroundColor.getHexColor()
        typeAloneDiaryVIew.backgroundColor = hexColor.backgroundColor.getHexColor()
        navigationBackView.backgroundColor = hexColor.backgroundColor.getHexColor()
        navigationSeparateVIew.backgroundColor = hexColor.navigationSeparateColor.getHexColor()
        typeCommentCircleView.backgroundColor = hexColor.commentDiaryMainColor.getHexColor()
        typeAloneCircleView.backgroundColor = hexColor.aloneDiaryMainColor.getHexColor()
        typeCommentButtonView.backgroundColor = hexColor.diaryTypeButtonBackgroundColor.getHexColor()
        typeAloneButtonView.backgroundColor = hexColor.diaryTypeButtonBackgroundColor.getHexColor()
        typeCommentbuttonSelectedView.backgroundColor = hexColor.buttonSeledtedColor.getHexColor()
        typeAloneButtonSelectedView.backgroundColor = hexColor.buttonSeledtedColor.getHexColor()
        
        typeCommentCircleView.layer.cornerRadius = typeCommentCircleView.frame.width / 2
        typeAloneCircleView.layer.cornerRadius = typeAloneCircleView.frame.width / 2
        typeCommentButtonView.layer.cornerRadius = typeCommentButtonView.frame.width / 2
        typeAloneButtonView.layer.cornerRadius = typeAloneButtonView.frame.width / 2
        typeCommentbuttonSelectedView.layer.cornerRadius = typeCommentbuttonSelectedView.frame.width / 2
        typeAloneButtonSelectedView.layer.cornerRadius = typeAloneButtonSelectedView.frame.width / 2
    }
    
    func labelSetting() {
        navigationLabel.font = UIFont.AppleSDGothic(.bold, size: 14)
        typeCommentLabel.font = UIFont.AppleSDGothic(.medium, size: 14)
        typeAloneLabel.font = UIFont.AppleSDGothic(.medium, size: 14)
    }

    
    
    func topsheetShown() {
        UIView.animate(withDuration: 0.3, animations: {
            self.topsheetViewHeightConstraint.constant = 180
            self.view.layoutIfNeeded()
        }) { (status) in
            self.isTopSheetShown = true
            UIView.animate(withDuration: 0.3, animations: {
                self.topsheetViewHeightConstraint.constant = 166
            }) { (status) in
                
            }
        }
    }
    
    func diaryTypeUpdateUI() {
        if selectedCommentDiaryButton == true {
            typeCommentbuttonSelectedView.isHidden = false
            typeAloneButtonSelectedView.isHidden = true
        }
        else {
            typeCommentbuttonSelectedView.isHidden = true
            typeAloneButtonSelectedView.isHidden = false
        }
    }
    
    // MARK: - ACTIONS
    func dismissTopsheet() {
        UIView.animate(withDuration: 0.3, animations: {
            self.topsheetViewHeightConstraint.constant = 0
            self.view.layoutIfNeeded()
        }) { (status) in
            self.isTopSheetShown = false
            self.dismiss(animated: true, completion: nil)
        }
    }
    
    @IBAction func backButtonClicked(_ sender: Any) {
        dismissTopsheet()
    }
    
    @IBAction func diaryTypeButtonClicked(_ sender: UIButton) {

        switch sender.tag {
        case 1:
            selectedCommentDiaryButton = true
            print("코멘트 받는 일기")
            print(selectedCommentDiaryButton)
            typeCommentbuttonSelectedView.isHidden = false
            typeAloneButtonSelectedView.isHidden = true

        case 2:
            selectedCommentDiaryButton = false
            print("혼자 쓰는 일기")
            print(selectedCommentDiaryButton)
            typeCommentbuttonSelectedView.isHidden = true
            typeAloneButtonSelectedView.isHidden = false
        default:
            break
        }
        
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.2, execute: {
            self.dismissTopsheet()
        })
        
    }
    
}


    // MARK: - EXTENSIONS
