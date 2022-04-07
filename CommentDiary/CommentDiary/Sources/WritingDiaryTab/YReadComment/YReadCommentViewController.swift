//
//  YReadCommentViewController.swift
//  CommentDiary
//
//  Created by 류창휘 on 2022/03/21.
//

import Foundation
import UIKit

class YReadCommentViewController : UIViewController, UIScrollViewDelegate {
    var diaryId : Int = 0
//    //true 이면 코멘트 쓰러가기 false 이면 코멘트 보러가기
//    var myCommentBool : Bool = false
//    //true이면 현재 false이면 과거
//    var pastOrNow : Bool = true
    var completion : (() -> Void)?
    
    
    
    lazy var detailDayDateFormatter: DateFormatter = {
        let df = DateFormatter()
        df.dateFormat = "yyyy.MM.dd"
        return df
    }()
    
    
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
        
        self.showIndicator()
        YReadCommentCheckDataManager().DiaryCheckData(diaryID: diaryId, self)
        allScrollView.delegate = self
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
    
    func scrollViewWillBeginDragging(_ scrollView: UIScrollView) {
        self.view.endEditing(true)
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
        commentReadButton.setTitle("코멘트 작성하기", for: .normal)
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
        
        


        
//        if myCommentBool == true { //코멘트 씀, 현재
//            //코멘트 보여주기
//
//            let gatherLookDetailVC = UIStoryboard(name: "GatherLookDetail", bundle: nil).instantiateViewController(withIdentifier: "GatherLookDetailViewController") as! GatherLookDetailViewController
//            gatherLookDetailVC.diaryID = self.diaryId
//            self.navigationController?.pushViewController(gatherLookDetailVC, animated: true)
//        }
//        else if myCommentBool == false && pastOrNow == true { //코멘트 안씀, 현재
//            //코멘트 쓰러가기
//            self.navigationController?.popViewController(animated: true, completion: {
//                DispatchQueue.main.asyncAfter(deadline: .now() + 0.1, execute: {
//
//                    self.completion?()
//                })
//            })
//
//        }
//        else if myCommentBool == false && pastOrNow == false { //코멘트 안씀, 과거
//            self.presentBottomAlert(message: "코멘트를 작성하지 않았어요.")
//        }
        
        
        
        //코멘트 쓰러가기
        self.navigationController?.popViewController(animated: true, completion: {
            DispatchQueue.main.asyncAfter(deadline: .now() + 0.1, execute: {
                
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
        self.dismissIndicator()
        titleLabel.text = response.result.title
        contentLabel.text = response.result.content
        dateLabel.text = response.result.date
        
//        let commentDate = detailDayDateFormatter.date(from: dateLabel.text!)
//
//        let datePlus = Calendar.current.date(byAdding: .day, value: 1, to: commentDate!)
//        let datePlusString = detailDayDateFormatter.string(from: datePlus!)
//        print(datePlusString, "하루 더한 날짜")
//        print(detailDayDateFormatter.string(from: Date(timeIntervalSinceNow: -25200)), "오늘")
//
//        if datePlusString == detailDayDateFormatter.string(from: Date(timeIntervalSinceNow: -25200)) {
//            pastOrNow = true //현재
//        }
//        else if datePlusString != detailDayDateFormatter.string(from: Date(timeIntervalSinceNow: -25200)) {
//            pastOrNow = false //과거
//        }
        
//        self.showIndicator()
//        CompareDataManager().dateCommentData(self, dateValue: datePlusString)
    
        
    }
}


//extension YReadCommentViewController {
//    func countMyCommentResponse(_ response: DateCommentResponse) {
//        self.dismissIndicator()
//        if response.result.count == 0 {
//            myCommentBool = false
//        }
//        else if response.result.count != 0 {
//            myCommentBool = true
//        }
//    }
//}
