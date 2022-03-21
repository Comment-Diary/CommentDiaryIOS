//
//  YReadCommentViewController.swift
//  CommentDiary
//
//  Created by 류창휘 on 2022/03/21.
//

import Foundation
import UIKit

class YReadCommentViewController : UIViewController {
    var diaryId : Int = 0
    var completion : (() -> Void)?
    //MARK: - Properties
    
    @IBOutlet weak var topBackView: UIView!
    @IBOutlet weak var backButton: UIButton!
    
    @IBOutlet weak var allScrollView: UIScrollView!
    
    @IBOutlet weak var allView: UIView!
    
    @IBOutlet weak var dateLabel: UILabel!
    
    @IBOutlet weak var titleLabel: UILabel!
    
    @IBOutlet weak var separateView: UIView!
    
    @IBOutlet weak var contentBackView: UIView!
    
    @IBOutlet weak var contentLabel: UILabel!
    
    @IBOutlet weak var bottomBackView: UIView!
    
    @IBOutlet weak var commentReadButton: UIButton!
    
    @IBOutlet weak var bottomLabelBackView: UIView!
    
    @IBOutlet weak var infoTopLabel: UILabel!
    
    @IBOutlet weak var infoBottomLabel: UILabel!
    //MARK: - LifeCycle
    override func viewDidLoad() {
        super.viewDidLoad()
        labelSetting()
        buttonSetting()
        viewSetting()
        YReadCommentCheckDataManager().DiaryCheckData(diaryID: diaryId, self)
    }
    
    func labelSetting() {
        dateLabel.font = UIFont.AppleSDGothic(.bold, size: 15)
        dateLabel.textColor = UIColor(hex: 0xFFAC86)
        titleLabel.font = UIFont.AppleSDGothic(.bold, size: 21)
        titleLabel.textColor = UIColor(hex: 0x4E4C49)
        contentLabel.textColor = UIColor(hex: 0x4E4C49)
        contentLabel.font = UIFont.AppleSDGothic(.medium, size: 15)
        infoTopLabel.text = "'도착한 일기'의 코멘트를 작성해야"
        infoTopLabel.textColor = UIColor(hex: 0x878379)
        infoTopLabel.font = UIFont.AppleSDGothic(.medium, size: 12)
        infoBottomLabel.text = "내게 온 코멘트를 확인할 수 있어요."
        infoBottomLabel.textColor = UIColor(hex: 0x878379)
        infoBottomLabel.font = UIFont.AppleSDGothic(.medium, size: 12)
        
    }
    
    func buttonSetting() {
        commentReadButton.backgroundColor = UIColor(hex: 0x73BF90)
        commentReadButton.setTitle("도착한 코멘트 보기", for: .normal)
        commentReadButton.setTitleColor(UIColor(hex: 0xFDFCF9), for: .normal)
        commentReadButton.setTitleColor(UIColor(hex: 0xFDFCF9), for: .highlighted)
        commentReadButton.titleLabel?.font = UIFont.AppleSDGothic(.bold, size: 15)
    }
    
    func viewSetting() {
        view.backgroundColor = UIColor(hex: 0xF4EDE3)
        bottomLabelBackView.backgroundColor = UIColor(hex: 0xF4EDE3)
        bottomBackView.backgroundColor = UIColor(hex: 0xF4EDE3)
        
        topBackView.backgroundColor = UIColor(hex: 0xF4EDE3)
        separateView.backgroundColor = UIColor(hex: 0xE2DFD7)
        allScrollView.layer.cornerRadius = 10
        contentBackView.layer.cornerRadius = 10
        contentBackView.layer.maskedCorners = [.layerMaxXMaxYCorner, .layerMinXMaxYCorner]
        allView.backgroundColor = UIColor(hex: 0xF4EDE3)
        
    }
    
    //MARK: - Actions
    
    @IBAction func backButtonTap(_ sender: Any) {
        navigationController?.popViewController(animated: true)
    }
    
    
    @IBAction func lookCommentButtonTap(_ sender: Any) {
        print("클릭")
        // 분기 처리
        //코멘트 쓰기 or 텝 이동
//        self.presentBottomAlert(message: "코멘트를 작성해주세요")
//        DispatchQueue.main.asyncAfter(deadline: .now() + 1, execute: {
//            self.navigationController?.popViewController(animated: true)
//        })
        
//        GatherLookDetailViewController
//        let gatherLookDetailVC = UIStoryboard(name: "GatherLookDetail", bundle: nil).instantiateViewController(withIdentifier: "GatherLookDetailViewController") as! GatherLookDetailViewController
//        gatherLookDetailVC.diaryID = self.diaryId
//        navigationController?.pushViewController(gatherLookDetailVC, animated: true)
//        self.tabBarController?.selectedIndex = 1
//        navigationController?.popViewController(animated: true)
        self.navigationController?.popViewController(animated: true, completion: {
//            self.tabBarController?.selectedIndex = 1
            DispatchQueue.main.asyncAfter(deadline: .now() + 0.3, execute: {
                
                self.completion?()
            })
        })
    }
    
    
    
}

    //MARK: - Extensions

extension UINavigationController {
    
    func pushViewController(_ viewController: UIViewController, animated: Bool = true, completion: @escaping () -> Void) {
        CATransaction.begin()
        CATransaction.setCompletionBlock(completion)
        pushViewController(viewController, animated: animated)
        CATransaction.commit()
    }
    
    func popViewController(animated: Bool = true, completion: @escaping () -> Void) {
        CATransaction.begin()
        CATransaction.setCompletionBlock(completion)
        popViewController(animated: animated)
        CATransaction.commit()
    }
    
    func popToRootViewController(animated: Bool = true, completion: @escaping () -> Void) {
        CATransaction.begin()
        CATransaction.setCompletionBlock(completion)
        popToRootViewController(animated: animated)
        CATransaction.commit()
    }
}

extension YReadCommentViewController {
    func yReadDiarySuccessResponse(_ response: DiaryCheckResopnse) {
        titleLabel.text = response.result.title
        contentLabel.text = response.result.content
        dateLabel.text = response.result.date
        
    }
}
