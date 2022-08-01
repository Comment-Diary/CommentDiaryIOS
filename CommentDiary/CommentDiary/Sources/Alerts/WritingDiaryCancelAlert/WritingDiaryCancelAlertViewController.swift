//
//  WritingDiaryCancelViewController.swift
//  CommentDiary
//
//  Created by 류창휘 on 2022/06/29.
//

import Foundation
import UIKit

class WritingDiaryCancelAlertViewController : UIViewController {
    
    enum StringCase : String {
        case cancel
        case exit
        case alert
        func getString() -> String {
            switch self {
            case .cancel:
                return "취소"
            case .exit:
                return "나가기"
            case .alert:
                return "지금 나가면 쓴 일기가 날아가요. \n나가시겠어요?"
            }
        }
    }
    enum hexColor {
        case stringColor
        case separateColor
        case backgroundColor
        
        func getHexColor() -> UIColor {
            switch self {
            case .stringColor:
                return UIColor(hex: 0x5F5D59)
            case .separateColor:
                return UIColor(hex: 0xE2DFD7)
            case .backgroundColor:
                return UIColor(hex: 0xFDFCF9)
            }
        }
    }
    //alertView border
    let alerViewCornerRadiusValue = 10
    
    //MARK: - Properties
    @IBOutlet weak var alertView: UIView!
    @IBOutlet weak var labelBackView: UIView!
    @IBOutlet weak var alertLabel: UILabel!
    @IBOutlet weak var cancelButton: UIButton!
    @IBOutlet weak var exitButton: UIButton!
    @IBOutlet weak var verSeparateView: UIView!
    @IBOutlet weak var horSeparateView: UIView!
    @IBOutlet weak var bottomBackView: UIView!
    

    
    
    //MARK: - LIFECYCLE
    override func viewDidLoad() {
        super.viewDidLoad()
        buttonTitle()
        buttonTitleColor()
        viewSetting()
        buttonFont()
        buttonBackground()
        labelFont()
        labelText()
        
    }
    
    func buttonTitle() {
        exitButton.setTitle(StringCase.exit.getString(), for: .normal)
        cancelButton.setTitle(StringCase.cancel.getString(), for: .normal)
        
    }
    func buttonTitleColor() {
        exitButton.setTitleColor(hexColor.stringColor.getHexColor(), for: .normal)
        exitButton.isHighlighted = false
        cancelButton.setTitleColor(hexColor.stringColor.getHexColor(), for: .normal)
        cancelButton.isHighlighted = false
    }
    func buttonBackground() {
        exitButton.backgroundColor = hexColor.backgroundColor.getHexColor()
        cancelButton.backgroundColor = hexColor.backgroundColor.getHexColor()
    }
    
    func buttonFont() {
        cancelButton.titleLabel?.font = .AppleSDGothic(.bold, size: 13)
        exitButton.titleLabel?.font = .AppleSDGothic(.bold, size: 13)
    }
    func labelText() {
        alertLabel.text = StringCase.alert.getString()
        alertLabel.setLineSpacing(spacing: 12)
        alertLabel.textAlignment = .center
    }
    func labelFont() {
        alertLabel.font = .AppleSDGothic(.bold, size: 13)
    }
    func viewSetting() {
        alertView.backgroundColor = hexColor.backgroundColor.getHexColor()
        labelBackView.backgroundColor = hexColor.backgroundColor.getHexColor()
        bottomBackView.backgroundColor = hexColor.backgroundColor.getHexColor()
        verSeparateView.backgroundColor = hexColor.separateColor.getHexColor()
        horSeparateView.backgroundColor = hexColor.separateColor.getHexColor()
        alertView.clipsToBounds = true
        alertView.layer.cornerRadius = CGFloat(alerViewCornerRadiusValue)
    }
    
    
    //MARK: - ACTIONS
    @IBAction func cancelButtonClicked(_ sender: UIButton) {
        dismiss(animated: true, completion: nil)
    }
    @IBAction func exitButtonClicked(_ sender: UIButton) {
        
            guard let presentingVC = self.presentingViewController as? UINavigationController else { return }
            self.dismiss(animated: true) {
                presentingVC.popToRootViewController(animated: true)
            }
    }
    
    
}

    //MARK: - EXTENSIONS
