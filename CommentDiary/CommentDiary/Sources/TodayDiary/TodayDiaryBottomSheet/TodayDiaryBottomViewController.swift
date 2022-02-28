//
//  TodayDiaryBottomViewController.swift
//  CommentDiary
//
//  Created by 류창휘 on 2022/02/19.
//

import Foundation
import UIKit
import PanModal



protocol commentViewChangeDelegate {
    func onCommentViewChange(data: Bool)
}

protocol buttonChangeDelegate {
    func onButtonChange(data: Bool)
}
protocol countLabelChangeDelegate {
    func onCountLabelChange(data: Bool)
}

class TodayDiaryBottomViewController: UIViewController {
  
    var commentViewDelegate: commentViewChangeDelegate?
    var buttonChangeDelegate: buttonChangeDelegate?
    var countLabelChangeDelegate: countLabelChangeDelegate?
    
    
    //MARK: - Properties
    
    @IBOutlet weak var selfButton: UIButton!
    
    @IBOutlet weak var comemtButton: UIButton!
    
    @IBOutlet weak var bottomSheetBackVIew: UIView!
    
    @IBOutlet weak var okButtonBackView: UIView!
    
    
    //MARK: - LifeCycle
    override func viewDidLoad() {
        super.viewDidLoad()
        viewSetting()
    }
    
    func buttonSetting() {

    }
    
    func viewSetting() {
        bottomSheetBackVIew.backgroundColor = UIColor(hex: 0xFDFCF9)
        okButtonBackView.backgroundColor = UIColor(hex: 0xFDFCF9)
    }
    //MARK: - Actions
    @IBAction func diaryToggleTapButton(_ sender: UIButton) {
        if sender.tag == 1 { //혼자보기
            selfButton.backgroundColor = UIColor(hex: 0xABD4BB)
            comemtButton.backgroundColor = UIColor(hex: 0xFDFCF9)
            
            commentViewDelegate?.onCommentViewChange(data: true) //뷰 숨기기
            buttonChangeDelegate?.onButtonChange(data: true) //버튼 초기에 활성화 가능
            countLabelChangeDelegate?.onCountLabelChange(data: true) //카운트 라벨 숨기기
        }
        else if sender.tag == 2 { //다른 사람에게 코멘트 받기
            selfButton.backgroundColor = UIColor(hex: 0xFDFCF9)
            comemtButton.backgroundColor = UIColor(hex: 0xABD4BB)

            commentViewDelegate?.onCommentViewChange(data: false) //뷰 보이게하기
            buttonChangeDelegate?.onButtonChange(data: false) //버튼 초기에 비활성화
            countLabelChangeDelegate?.onCountLabelChange(data: false) //카운트 라벨 보이기
        }
        
    }
    
    
    @IBAction func dismissTapButton(_ sender: Any) {
        dismiss(animated: true)
    }
    
}

    //MARK: - Extenstions
extension TodayDiaryBottomViewController: PanModalPresentable {
    var panScrollable: UIScrollView? {
        return nil
    }
    
    var shortFormHeight: PanModalHeight {
        return .contentHeight(self.bottomSheetBackVIew.frame.height)
    }
}
