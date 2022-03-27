//
//  NSaveViewController.swift
//  CommentDiary
//
//  Created by 류창휘 on 2022/03/01.
//

import Foundation
import UIKit

class NSaveViewController: UIViewController, UIScrollViewDelegate {
    var dateString = ""
    var titleString = ""
    var contentString = ""
    var diaryidInt = 0
    
    //일기 작성 후 넘어오면 false 캘린더에서 넘어오면 true
    var diaryCheckToggle: Bool = true
    
    
    //MARK: - Properties
    
    @IBOutlet weak var buttonBackView: UIView!
    
    @IBOutlet weak var backButton: UIButton!
    
    @IBOutlet weak var deleteButton: UIButton!
    
    @IBOutlet weak var editButton: UIButton!
    
    @IBOutlet weak var dateLabel: UILabel!
    
    @IBOutlet weak var titleLabel: UILabel!
    
    @IBOutlet weak var barView: UIView!
    
    
    @IBOutlet weak var contentLabel: UILabel!
    
    @IBOutlet weak var diaryScrollView: UIScrollView!
    
    @IBOutlet weak var titleBackView: UIView!
    
    @IBOutlet weak var contentBackView: UIView!
    
    //MARK: - LifeCycle
    override func viewDidLoad() {
        super.viewDidLoad()
        diaryScrollView.delegate = self
        viewSetting()
        buttonSetting()
        labelSetting()
        
        if diaryCheckToggle == false {
            //일기 작성후 넘어온 경우
            labelSetting()
        } else if diaryCheckToggle == true {
            //캘린더에서 조회할 경우
            DiaryCheckDataManager().diaryCheckData(diaryID: diaryidInt, self)
            
            print(diaryidInt, "일기 값")
        }

    }
    func scrollViewWillBeginDragging(_ scrollView: UIScrollView) {
        self.view.endEditing(true)
    }

    
    func viewSetting() {
        buttonBackView.backgroundColor = UIColor(hex: 0xF4EDE3)
        view.backgroundColor = UIColor(hex: 0xF4EDE3)
        diaryScrollView.backgroundColor = UIColor(hex: 0xFDFCF9)
        diaryScrollView.layer.cornerRadius = 10
        titleBackView.backgroundColor = UIColor(hex: 0xFDFCF9)
        contentBackView.backgroundColor = UIColor(hex: 0xFDFCF9)
        barView.backgroundColor = UIColor(hex: 0xE2DFD7)
    }
    
    func buttonSetting() {
        
    }
    
    func labelSetting() {
        dateLabel.text = dateString
        titleLabel.text = titleString
        contentLabel.text = contentString
        
        
        dateLabel.font = UIFont.AppleSDGothic(.bold, size: 15)
        dateLabel.textColor = UIColor(hex: 0xFFAC86)
        titleLabel.font = UIFont.AppleSDGothic(.bold, size: 21)
        titleLabel.textColor = UIColor(hex: 0x4E4C49)
        contentLabel.textColor = UIColor(hex: 0x4E4C49)
        contentLabel.font = UIFont.AppleSDGothic(.medium, size: 15)
    }
    
    
    
    //MARK: - Actions
    @IBAction func backButtonTap(_ sender: Any) {
        self.navigationController?.popToRootViewController(animated: true)
    }
    
    @IBAction func deleteButtonTap(_ sender: Any) {
        let deleteCheckVC = UIStoryboard(name: "DeleteCheck", bundle: nil).instantiateViewController(withIdentifier: "DeleteCheckAlertViewController") as! DeleteCheckAlertViewController
        deleteCheckVC.diaryId = self.diaryidInt
        self.present(deleteCheckVC, animated: true)
        

    }
    
    @IBAction func editButtonTap(_ sender: Any) {
        let nEditVC = UIStoryboard(name: "NEdit", bundle: nil).instantiateViewController(withIdentifier: "NEidtViewController") as! NEidtViewController
        nEditVC.dateString = dateLabel.text ?? ""
        nEditVC.titleString = titleLabel.text ?? ""
        nEditVC.contentString = contentLabel.text ?? ""
        nEditVC.diaryId = diaryidInt

        self.navigationController?.pushViewController(nEditVC, animated: true)

    }
    
}
//let viewControllers: [UIViewController] = self.navigationController!.viewControllers
//for aViewController in viewControllers {
//    if aViewController is GoodsRegisterViewController {
//        self.navigationController!.popToViewController(aViewController, animated: true)
//    }

extension NSaveViewController {
    func diaryCheckSuccessResopnse(_ response: DiaryCheckResopnse) {
        titleLabel.text = response.result.title
        contentLabel.text = response.result.content
        dateLabel.text = response.result.date
        print(titleLabel.text , "API 조회 일기 제목")
        print(contentLabel.text, "APi 조회 일기 내용")
        print(dateLabel.text, "API 조회 일기 날짜")
        
    }
}
