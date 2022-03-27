//
//  TabBarVC.swift
//  CommentDiary
//
//  Created by 류창휘 on 2022/03/19.
//

import Foundation
import UIKit

class TabBarVC : UITabBarController, UITabBarControllerDelegate {
    let writingDiaryVC = WritingDiaryVC()
    let arrivalDiaryVC = ArrivedDiaryViewController()
    let gatherLookVC = GatherLookViewController()
    let myPageVC = MyPageViewController()
    
//    let writingTabBarItem = UITabBarItem(title: "내 일기", image: UIImage(named: ""), tag: 0)
//    let arrivalTabBarItem = UITabBarItem(title: "??", image: UIImage(named: ""), tag: 1)
    
    var index : Int = 0
    
    override func viewDidLoad() {
        super.viewDidLoad()
//        self.navigationController?.interactivePopGestureRecognizer?.delegate = nil
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
//        let nextVC = TabBarVC()
//        nextVC.index = 0
//        self.changeRootViewController(nextVC)
//        self.selectedIndex = index
        
    }
}
