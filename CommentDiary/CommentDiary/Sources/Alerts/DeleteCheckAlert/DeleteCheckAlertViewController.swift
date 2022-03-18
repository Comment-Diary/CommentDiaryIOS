//
//  DeleteCheckAlertViewController.swift
//  CommentDiary
//
//  Created by 류창휘 on 2022/03/01.
//

import Foundation
import UIKit

class DeleteCheckAlertViewController :UIViewController {
    var diaryId : Int = 0
    //MARK: - Properties
    
    @IBOutlet weak var alertView: UIView!
    
    
    @IBOutlet weak var labelBackVIew: UIView!
    
    @IBOutlet weak var topTextLabel: UILabel!
    
    @IBOutlet weak var bottomTextLabel: UILabel!
    
    @IBOutlet weak var cancelButton: UIButton!
    
    @IBOutlet weak var okayButton: UIButton!
    
    //MARK: - LifeCycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        viewSetting()
        labelSetting()
        buttonSetting()

    }
    
    
    
    func viewSetting() {
        alertView.clipsToBounds = true
        alertView.layer.cornerRadius = 10
        
        alertView.backgroundColor = UIColor(hex: 0xFDFCF9)
        labelBackVIew.backgroundColor = UIColor(hex: 0xFDFCF9)
        
    }
    
    func labelSetting() {
        topTextLabel.textColor = UIColor(hex: 0x5F5D59)
        topTextLabel.font = UIFont.AppleSDGothic(.bold, size: 14)
        bottomTextLabel.textColor = UIColor(hex: 0x5F5D59)
        bottomTextLabel.font = UIFont.AppleSDGothic(.bold, size: 14)
    }
    
    func buttonSetting() {
        cancelButton.setTitle("취소", for: .normal)
        cancelButton.setTitleColor(UIColor(hex: 0x878379), for: .highlighted)
        cancelButton.setTitleColor(UIColor(hex: 0x878379), for: .normal)
        cancelButton.titleLabel?.font = UIFont.AppleSDGothic(.bold, size: 14)
        cancelButton.backgroundColor = UIColor(hex: 0xE2DFD7)
        okayButton.setTitle("확인", for: .normal)
        okayButton.setTitleColor(UIColor(hex: 0xFDFCF9), for: .normal)
        okayButton.setTitleColor(UIColor(hex: 0xFDFCF9), for: .highlighted)
        okayButton.titleLabel?.font = UIFont.AppleSDGothic(.bold, size: 14)
        okayButton.backgroundColor = UIColor(hex: 0x73BF90)
        

        okayButton.isHighlighted = false
        cancelButton.isHighlighted = false
    }
    
    
    //MARK: - Actions
    
    @IBAction func okButtonTap(_ sender: Any) {
        self.showIndicator()
        DeleteDiaryDataManater().deleteDiaryDeleteData(diaryInt: diaryId, self)
        
        print(diaryId, "삭제할 id 값")

//        self.dismiss(animated: true) {
//            let viewController: [UIViewController] = self.navigationController!.viewControllers
//            for aViewController in viewController {
//                if aViewController is WritingDiaryViewController {
//
//            }
            
            

    }
    
    
    @IBAction func cancelButtonTap(_ sender: Any) {
        dismiss(animated: true, completion: nil)
    }
    
    
}
    //MARK: - Extensions
extension DeleteCheckAlertViewController {
    func deleteSuccessResponse() {
        self.dismissIndicator()
        
        self.presentBottomAlert(message: "일기가 삭제되었어요.")
        DispatchQueue.main.asyncAfter(deadline: .now() + 1, execute: {
            let mainTabBarController = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "MainTabBarController")
            self.changeRootViewController(mainTabBarController)
//            guard let presentingVC = self.presentingViewController as? UINavigationController else { return }
//            self.dismiss(animated: true) {
//                presentingVC.popToRootViewController(animated: true)
//            }
            UserDefaults.standard.removeObject(forKey: "DiaryID")
            
        })
    }
}

extension DeleteCheckAlertViewController {
    func delteFailResponse() {
        
    }
}
//guard let presentingVC = self.presentingViewController as? UINavigationController else { return }
//dismiss(animated: true) {
//    presentingVC.popViewController(animated: true)
