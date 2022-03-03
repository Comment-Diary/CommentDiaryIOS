//
//  DeleteCheckAlertViewController.swift
//  CommentDiary
//
//  Created by 류창휘 on 2022/03/01.
//

import Foundation
import UIKit

class DeleteCheckAlertViewController :UIViewController {
    //MARK: - Properties
    
    @IBOutlet weak var labelBackVIew: UIView!
    
    @IBOutlet weak var topTextLabel: UILabel!
    
    @IBOutlet weak var bottomTextLabel: UILabel!
    
    //MARK: - LifeCycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    //MARK: - Actions
    
    @IBAction func okButtonTap(_ sender: Any) {
        self.showIndicator()
        DeleteDiaryDataManater().deleteDiaryDeleteData(self)

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
        self.presentBottomAlert(message: "일기가 삭제되었습니다.")
        DispatchQueue.main.asyncAfter(deadline: .now() + 1, execute: {
            let mainTabBarController = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "MainTabBarController")
            self.changeRootViewController(mainTabBarController)
        })
    }
}

extension DeleteCheckAlertViewController {
    func delteFailResponse() {
        
    }
}
