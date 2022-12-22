//
//  MemberOutViewController.swift
//  CommentDiary
//
//  Created by 류창휘 on 2022/03/13.
//

import Foundation
import UIKit

class MemberOutViewController : UIViewController {
    //MARK: - Properties
    
    @IBOutlet weak var memberOutLabel: UILabel!
    
    @IBOutlet weak var backButton: UIButton!
    @IBOutlet weak var memberOutButton: UIButton!
    
    @IBOutlet weak var separateView: UIView!
    
    
    @IBOutlet weak var topBackView: UIView!
    
    
    @IBOutlet weak var firstLabel: UILabel!
    @IBOutlet weak var secondLabel: UILabel!
    @IBOutlet weak var thirdLabel: UILabel!
    
    //MARK: - LifeCycle
    override func viewDidLoad() {
        super.viewDidLoad()
        viewSetting()
        buttonSetting()
        labelSetting()
        swipeRecognizer()
        navigationBackSwipeMotion()
        
    }
    func navigationBackSwipeMotion() {
        let swipeRecognizer = UISwipeGestureRecognizer(target: self, action: #selector(swipeAction(_:)))
        swipeRecognizer.direction = .right
        self.view.addGestureRecognizer(swipeRecognizer)
    }
    @objc func swipeAction(_ sender: UISwipeGestureRecognizer) {
        navigationController?.popViewController(animated: true)
    }
    
    
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        memberOutButton.layer.cornerRadius = memberOutButton.frame.height / 2
    }
    
    
    func swipeRecognizer() {
        let swipeRight = UISwipeGestureRecognizer(target: self, action: #selector(self.respondToSwipeGesture(_:)))
        swipeRight.direction = UISwipeGestureRecognizer.Direction.right
        self.view.addGestureRecognizer(swipeRight)
        
    }
    
    @objc func respondToSwipeGesture(_ gesture: UIGestureRecognizer){
        if let swipeGesture = gesture as? UISwipeGestureRecognizer {
            switch swipeGesture.direction{
            case UISwipeGestureRecognizer.Direction.right:
                // 스와이프 시, 원하는 기능 구현.
                self.dismiss(animated: true, completion: nil)
            default: break
            }
        }
    }


    
    func viewSetting() {
        view.backgroundColor = UIColor(hex: 0xFDFCF9)
        topBackView.backgroundColor = UIColor(hex: 0xFDFCF9)
        separateView.backgroundColor = UIColor(hex: 0xE2DFD7)
    }
    
    func labelSetting() {
        memberOutLabel.textColor = UIColor(hex: 0x4E4C49)
        memberOutLabel.font = UIFont.AppleSDGothic(.bold, size: 21)
        firstLabel.textColor = UIColor(hex: 0x4E4C49)
        secondLabel.textColor = UIColor(hex: 0x4E4C49)
        thirdLabel.textColor = UIColor(hex: 0x4E4C49)
        firstLabel.font = UIFont.AppleSDGothic(.medium, size: 15)
        secondLabel.font = UIFont.AppleSDGothic(.medium, size: 15)
        thirdLabel.font = UIFont.AppleSDGothic(.medium, size: 15)
        
        
    }
    
    func buttonSetting() {
        self.memberOutButton.setTitleColor(UIColor(hex: 0xFDFCF9), for: .normal)
        self.memberOutButton.setTitle("탈퇴하기", for: .normal)
        self.memberOutButton.titleLabel?.font = .AppleSDGothic(.bold, size: 18)
        self.memberOutButton.backgroundColor = UIColor(hex: 0x878379)
    }
    
    
    @IBAction func backButtonTap(_ sender: Any) {
        navigationController?.popViewController(animated: true)
    }
    
    @IBAction func memberOutButtonTap(_ sender: Any) {
        MemberOutDataManager().deleteMemberData(self)
        showIndicator()
    }
    
    
}


extension MemberOutViewController {
    func memberOutSuccess(_ response : MemberOutResponse) {
        dismissIndicator()
        let splashVC = UIStoryboard(name: "Onboarding", bundle: nil).instantiateViewController(withIdentifier: "splashNavigation")
        self.changeRootViewController(splashVC)
//        UserDefaults.standard.removeObject(forKey: "AccessToken")
//        UserDefaults.standard.removeObject(forKey: "RefreshToken")
//        UserDefaults.standard.set(false, forKey: "login_save")

        
    }
}
