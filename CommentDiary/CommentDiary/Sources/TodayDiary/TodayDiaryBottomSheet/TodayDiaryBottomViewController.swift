//
//  TodayDiaryBottomViewController.swift
//  CommentDiary
//
//  Created by 류창휘 on 2022/02/19.
//

import Foundation
import UIKit
import PanModal

protocol preSaveButtonChangeDelegate {
    func onPreSaveButtonChange(data: Bool)
}

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
  
    var preSaveButtonDelegate : preSaveButtonChangeDelegate?
    var commentViewDelegate: commentViewChangeDelegate?
    var buttonChangeDelegate: buttonChangeDelegate?
    var countLabelChangeDelegate: countLabelChangeDelegate?
    
    
    var hasLoaded = true
    
    //MARK: - Properties
    
    
    @IBOutlet weak var infoBackView: UIView!
    
    @IBOutlet weak var aloneBackView: UIView!
    
    @IBOutlet weak var commentBackView: UIView!
    
    @IBOutlet weak var okayButton: UIButton!
    @IBOutlet weak var selfButton: UIButton!
    
    @IBOutlet weak var comemtButton: UIButton!
    
    @IBOutlet weak var bottomSheetBackVIew: UIView!
    
    @IBOutlet weak var okButtonBackView: UIView!
    
    
    @IBOutlet weak var diaryOptionLabel: UILabel!
    
    //MARK: - LifeCycle
    override func viewDidLoad() {
        super.viewDidLoad()
        //test
        hasLoaded = true
        
        
        
        
        viewSetting()
        buttonSetting()
        labelSetting()
    }
    func labelSetting() {
        diaryOptionLabel.textColor = UIColor(hex: 0x4E4C49)
        diaryOptionLabel.font = UIFont.AppleSDGothic(.bold, size: 14)
    }
    
    func buttonSetting() {
        selfButton.layer.borderColor = UIColor(hex: 0x878379).cgColor
        selfButton.layer.borderWidth = 0.5
        comemtButton.layer.addBorder([.bottom], color: UIColor(hex: 0x878379), width: 0.5)
        
        selfButton.setTitle("전송하지 않고 혼자 볼게요.", for: .normal)
        selfButton.setTitleColor(UIColor(hex: 0x4E4C49), for: .normal)
        selfButton.setTitleColor(UIColor(hex: 0x4E4C49), for: .highlighted)
        selfButton.titleLabel?.font = UIFont.AppleSDGothic(.medium, size: 14)
        
        comemtButton.setTitle("다른 누군가에게 전송하고 코멘트를 받아볼게요.", for: .normal)
        comemtButton.setTitleColor(UIColor(hex: 0x4E4C49), for: .normal)
        comemtButton.setTitleColor(UIColor(hex: 0x4E4C49), for: .highlighted)
        comemtButton.titleLabel?.font = UIFont.AppleSDGothic(.medium, size: 14)
        okayButton.setTitle("확인", for: .normal)
        okayButton.setTitleColor(UIColor(hex: 0x4E4C49), for: .normal)
        okayButton.setTitleColor(UIColor(hex: 0x4E4C49), for: .highlighted)
        okayButton.titleLabel?.font = UIFont.AppleSDGothic(.bold, size: 18)
        
    }
    
    func viewSetting() {
        bottomSheetBackVIew.backgroundColor = UIColor(hex: 0xFDFCF9)
        okButtonBackView.backgroundColor = UIColor(hex: 0xFDFCF9)
        aloneBackView.backgroundColor = UIColor(hex: 0xFDFCF9)
        infoBackView.backgroundColor = UIColor(hex: 0xFDFCF9)
        commentBackView.backgroundColor = UIColor(hex: 0xFDFCF9)
        view.backgroundColor = UIColor(hex: 0xFDFCF9)
    }
    //MARK: - Actions
    @IBAction func diaryToggleTapButton(_ sender: UIButton) {
        if sender.tag == 1 { //혼자보기
            selfButton.backgroundColor = UIColor(hex: 0xABD4BB)
            comemtButton.backgroundColor = UIColor(hex: 0xFDFCF9)

            preSaveButtonDelegate?.onPreSaveButtonChange(data: true) //임시저장 숨기기
            commentViewDelegate?.onCommentViewChange(data: true) //뷰 숨기기
            buttonChangeDelegate?.onButtonChange(data: true) //버튼 초기에 활성화 가능
            countLabelChangeDelegate?.onCountLabelChange(data: true) //카운트 라벨 숨기기
        }
        else if sender.tag == 2 { //다른 사람에게 코멘트 받기
            selfButton.backgroundColor = UIColor(hex: 0xFDFCF9)
            comemtButton.backgroundColor = UIColor(hex: 0xABD4BB)

            preSaveButtonDelegate?.onPreSaveButtonChange(data: false) //임시저장 보이기
            commentViewDelegate?.onCommentViewChange(data: false) //뷰 보이게하기
            buttonChangeDelegate?.onButtonChange(data: false) //버튼 초기에 비활성화
            countLabelChangeDelegate?.onCountLabelChange(data: false) //카운트 라벨 보이기
        }
        
    }
    
    
    @IBAction func dismissTapButton(_ sender: Any) {
            dismiss(animated: true, completion: nil)
    }
    
}

    //MARK: - Extenstions
extension TodayDiaryBottomViewController: PanModalPresentable {
    var panScrollable: UIScrollView? {
        return nil
    }
    
//    var shortFormHeight: PanModalHeight {
//        if hasLoaded {
//            return .contentHeight(self.bottomSheetBackVIew.frame.size.height)
//        }
//        return .maxHeight
//    }
    
    var shortFormHeight: PanModalHeight {
        return .contentHeight(269)
    }
    var  longFormHeight: PanModalHeight {
        return .contentHeight(269)
    }
    
    
//    var longFormHeight: PanModalHeight {
//        return .maxHeightWithTopInset(self.bottomSheetBackVIew.frame.size.height)
//    }
//    var maxForHeight: PanModalHeight {
//        return .maxHeight(self.bottomSheetBackVIew.frame.size.height)
//    }
}
