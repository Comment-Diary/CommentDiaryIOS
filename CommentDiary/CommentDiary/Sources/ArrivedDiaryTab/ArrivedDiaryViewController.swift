//
//  ArrivedDiaryViewController.swift
//  CommentDiary
//
//  Created by 류창휘 on 2022/02/17.
//

import Foundation
import UIKit

//스크롤뷰 키보드 내리기
//https://zeddios.tistory.com/309

//키보드 높이만큼 올리고 내리기
//https://icksw.tistory.com/87

class ArrivedDiaryViewController: UIViewController, UITextViewDelegate, CallAPIDelegate {
    func callAPI(data: String) {
        ReceivedDiaryDataManager().receivedDiaryGetData(self, dateValue: data)
    }
    
    //당겨서 리프레쉬
    private var refreshControl = UIRefreshControl()
    

    //api
    var myCommentResponseList : [myCommentResponse] = []
    
    //도착한 일기 id 값
    var arrivedDiaryId: Int = 0
    //코멘트 작성 여부
    var writedCommentCount : Int = 0
    
    //오늘 날짜
    var todayDateString : String = ""
    //내가 쓴 코멘트 카운트
    var commentCount : Int = 0
    
    lazy var detailDayDateFormatter: DateFormatter = {
        let df = DateFormatter()
//        df.locale = Locale(identifier: "ko_KR")
//        df.timeZone = TimeZone(identifier: "UTC")
        df.dateFormat = "yyyy.MM.dd"
        return df
    }()
    
    //앱 초기화 bool
    var viewload : Bool = false
    //MARK: - Properties
    
    
    @IBOutlet weak var blockButton: UIButton!
    
    @IBOutlet weak var notArrivedDiaryLabel: UILabel!
    
    @IBOutlet weak var separateView: UIView!
    
    @IBOutlet weak var topBackView: UIView!
    
    @IBOutlet weak var dateLabel: UILabel!
    @IBOutlet weak var arrivalDiaryLabel: UILabel!
    
    @IBOutlet weak var arrivalBackView: UIView!
    
    @IBOutlet weak var commentScrollView: UIScrollView!
    @IBOutlet weak var diaryTitleLabel: UILabel!

    @IBOutlet weak var diaryContentTextView: UITextView!
    
    
    @IBOutlet weak var sendCommentButton: UIButton!
    
    @IBOutlet weak var myCommentTextView: UITextView!
    
    
    @IBOutlet weak var mySendCommentLabel: UILabel!
    
    
    @IBOutlet weak var commentBackView: UIView!
    
    @IBOutlet weak var commentCountLabel: UILabel!
    
    @IBOutlet weak var entireView: UIView!
    
    
    @IBOutlet weak var reportButton: UIButton!
    
    
    //MARK: - LifeCycle
    override func viewDidLoad() {
        super.viewDidLoad()
        self.showIndicator()
        todayDateString = detailDayDateFormatter.string(from: Date(timeIntervalSinceNow: -25200))
        print(todayDateString, "받을 날짜")

        
        
        
        commentScrollView.refreshControl = refreshControl
        refreshControl.addTarget(self, action: #selector(refresh), for: .valueChanged)
        
        
        
        myCommentTextView.delegate = self
        commentScrollView.delegate = self
//        textLineSpacing()
        viewSetting()
        labelSetting()
        buttonSetting()
        textViewPlaceholdeerSetting()
//        scrollViewDismissKeyboard()

    }
    
    @objc func refresh() {
        DispatchQueue.main.asyncAfter(deadline: .now() + 1) {
            ReceivedDiaryDataManager().receivedDiaryGetData(self, dateValue: self.todayDateString)
            self.refreshControl.endRefreshing()
        }
    }
    
    
    
    
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        //API 조회
        ReceivedDiaryDataManager().receivedDiaryGetData(self, dateValue: todayDateString)
        
        print(viewload, "false라면 초기화 된것")
        viewload = false
        
        
        commentCountLabel.text = "0/20자 이상 작성"
        commentCountLabel.isHidden = true

    }
    

    
    func viewSetting() {
        arrivalBackView.layer.cornerRadius = 10
        arrivalBackView.layer.borderWidth = 3
        arrivalBackView.layer.borderColor = UIColor(hex: 0xE2DFD7).cgColor
        commentBackView.layer.cornerRadius = 10
        myCommentTextView.backgroundColor = UIColor(hex: 0xFDFCF9)
        topBackView.backgroundColor = UIColor(hex: 0xF4EDE3)
        view.backgroundColor = UIColor(hex: 0xF4EDE3)
        commentBackView.backgroundColor = UIColor(hex: 0xFDFCF9)
        arrivalBackView.backgroundColor = UIColor(hex: 0xFDFCF9)
        diaryContentTextView.backgroundColor = UIColor(hex: 0xFDFCF9)
        separateView.backgroundColor = UIColor(hex: 0xE2DFD7)
        entireView.backgroundColor = UIColor(hex: 0xF4EDE3)
        
        
    }
    func labelSetting() {
        notArrivedDiaryLabel.font = UIFont.AppleSDGothic(.medium, size: 13)
        notArrivedDiaryLabel.textColor = UIColor(hex: 0x878379)
        mySendCommentLabel.text = "내가 보내는 코멘트"
        mySendCommentLabel.font = UIFont.AppleSDGothic(.bold, size: 15)
        mySendCommentLabel.textColor = UIColor(hex: 0x73BF90)
        arrivalDiaryLabel.textColor = UIColor(hex: 0x4E4C49)
        arrivalDiaryLabel.font = UIFont.AppleSDGothic(.bold, size: 15)
        arrivalDiaryLabel.text = "도착한 일기"
        dateLabel.textColor = UIColor(hex: 0xFFAC86)
        dateLabel.font = UIFont.AppleSDGothic(.bold, size: 15)
        diaryTitleLabel.textColor = UIColor(hex: 0x4E4C49)
        diaryTitleLabel.font = UIFont.AppleSDGothic(.bold, size: 21)
        diaryContentTextView.font = UIFont.AppleSDGothic(.medium, size: 15)
        diaryContentTextView.textColor = UIColor(hex: 0x4E4C49)
        myCommentTextView.font = UIFont.AppleSDGothic(.medium, size: 14)
        

    }
    func buttonSetting() {
//        self.sendCommentButton.isEnabled = false
        sendCommentButton.layer.opacity = 0.4
        self.sendCommentButton.backgroundColor = UIColor(hex: 0x73BF90)
        sendCommentButton.setTitle("보내기", for: .normal)
        sendCommentButton.setTitleColor(UIColor(hex: 0xFDFCF9), for: .normal)
        sendCommentButton.setTitleColor(UIColor(hex: 0xFDFCF9), for: .highlighted)
        sendCommentButton.titleLabel?.font = UIFont.AppleSDGothic(.bold, size: 13)
        
        reportButton.setTitle("신고하기", for: .normal)
        reportButton.setTitleColor(UIColor(hex: 0x878379), for: .normal)
        reportButton.setTitleColor(UIColor(hex: 0x878379), for: .highlighted)
        reportButton.titleLabel?.font = UIFont.AppleSDGothic(.medium, size: 12)
        
        
        blockButton.setTitle("차단하기", for: .normal)
        blockButton.setTitleColor(UIColor(hex: 0x878379), for: .normal)
        blockButton.setTitleColor(UIColor(hex: 0x878379), for: .highlighted)
        blockButton.titleLabel?.font = UIFont.AppleSDGothic(.medium, size: 12)
    }
    
    func textViewPlaceholdeerSetting() {
//        myCommentTextView.text = "일기를 읽고 따뜻한 코멘트를 달아주세요."
//        myCommentTextView.textColor = UIColor(hex: 0xD2D2D2)
    }

    
//    func scrollViewDismissKeyboard() {
//        let singleTapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(MyTapMethod))
//        singleTapGestureRecognizer.numberOfTapsRequired = 1
//        singleTapGestureRecognizer.isEnabled = true
//        singleTapGestureRecognizer.cancelsTouchesInView = false
////        commentScrollView.addGestureRecognizer(singleTapGestureRecognizer)
//
//    }
//    @objc func MyTapMethod(sender: UITapGestureRecognizer) {
//        self.view.endEditing(true)
//
//    }
    func scrollViewWillBeginDragging(_ scrollView: UIScrollView) {
        self.view.endEditing(true)
    }
    

    
    //텍스트 간 간격 조정
//    func textLineSpacing() {
//        let attrString = NSMutableAttributedString(string: diaryTitleLabel.text!)
//        let paragraphStyle = NSMutableParagraphStyle()
//        paragraphStyle.lineSpacing = 10
//        attrString.addAttribute(NSAttributedString.Key.paragraphStyle, value: paragraphStyle, range: NSMakeRange(0, attrString.length))
//        diaryTitleLabel.attributedText = attrString
//    }
    
    func textViewDidEndEditing(_ textView: UITextView) {
        if myCommentTextView.text.isEmpty {
            myCommentTextView.text = "일기를 읽고 따뜻한 코멘트를 달아주세요."
            myCommentTextView.textColor = UIColor(hex: 0xD2D2D2)
        }
    }
    
    func textViewDidBeginEditing(_ textView: UITextView) {
        if myCommentTextView.textColor == UIColor(hex: 0xD2D2D2) {
            myCommentTextView.text = nil
            myCommentTextView.textColor = UIColor(hex: 0x4E4C49)
        }
    }
    
    
    func textView(_ textView: UITextView, shouldChangeTextIn range: NSRange, replacementText text: String) -> Bool {
        if textView == myCommentTextView {
            
            let currentText = myCommentTextView.text ?? ""
            guard let stringRange = Range(range, in: currentText) else { return false }
            let changedText = currentText.replacingCharacters(in: stringRange, with: text)
            commentCount = changedText.count
            commentCountLabel.text = "\(changedText.count)/20자 이상 작성"
            if changedText.count >= 1 {
                commentCountLabel.isHidden = false
            }
            
            if changedText.count < 20 {

//                sendCommentButton.isEnabled = false
                sendCommentButton.layer.opacity = 0.4
            } else if changedText.count >= 20 {
//                sendCommentButton.isEnabled = true
                sendCommentButton.layer.opacity = 1
            }
            return true
        }
        return true
    }
    
    
//    //코멘트 쓸 때 뷰 위로 올리기
//    //노티피케이션 추가하는 메서드
//    func addKeyboardNotification() {
//        //키보드가 나타날 때 앱에게 알리는 메서드
//        NotificationCenter.default.addObserver(self, selector: #selector(self.keyboardWillShow(_:)), name: UIResponder.keyboardWillShowNotification, object: nil)
//        //키보드가 사라질 때 앱에게 알리는 매서드
//        NotificationCenter.default.addObserver(self, selector: #selector(self.keyboardWillHide(_:)), name: UIResponder.keyboardWillHideNotification, object: nil)
//    }
//    //키보드 나타났다가는 알림을 받으면 실행할 메서드
//    @objc func keyboardWillShow(_ noti: NSNotification) {
//        //키보드의 높이만큼 화면을 올려줌
//        if let keyboardFrame: NSValue = noti.userInfo?[UIResponder.keyboardFrameEndUserInfoKey] as? NSValue {
//            let keyboardRectangle = keyboardFrame.cgRectValue
//            let keyboardHeight = keyboardRectangle.height
//            self.view.frame.origin.y -= (keyboardHeight - (self.tabBarController?.tabBar.frame.size.height)!)
//        }
//    }
//    //키보드 사라졌다는 알림을 받으면 실행할 메서드
//    @objc func keyboardWillHide(_ noti: NSNotification) {
//        //키보드의 높이만큼 화면을 내려줌
//        if let keyboardFrame: NSValue = noti.userInfo?[UIResponder.keyboardFrameEndUserInfoKey] as? NSValue {
//            let keyboardRectangle = keyboardFrame.cgRectValue
//            let keyboardHeight = keyboardRectangle.height
//            self.view.frame.origin.y += (keyboardHeight - (self.tabBarController?.tabBar.frame.size.height)!)
//        }
//    }
//    
//    //노티피케이션 제거하는 메서드
//    func removeKeyboardNotification() {
//        //키보드 나타날 때 앱에게 알리는 메서드 제거
//        NotificationCenter.default.removeObserver(self, name: UIResponder.keyboardWillShowNotification, object: nil)
//        //키보드 사라질 때 앱에게 알리는 메서드 제거
//        NotificationCenter.default.removeObserver(self, name: UIResponder.keyboardWillHideNotification, object: nil)
//    }
    
    //MARK: - Actions
    @IBAction func sendCommentButtonTap(_ sender: UIButton) {
        
        //20자 미만일 경우

        if commentCount < 20 {
            self.presentBottomAlert(message: "20자 이상 코멘트를 작성해주세요.")
        }
        else if commentCount >= 20 {
            //알람 띄우기
            let sendCommentAlertVC = UIStoryboard(name: "SendCommentAlert", bundle: nil).instantiateViewController(withIdentifier: "SendCommentAlertViewController") as! SendCommentAlertViewController
            sendCommentAlertVC.delegate = self
            sendCommentAlertVC.diaryID = arrivedDiaryId
            sendCommentAlertVC.diaryDate = todayDateString
            sendCommentAlertVC.diaryContent = myCommentTextView.text
            self.present(sendCommentAlertVC, animated: true, completion: nil)
        }

        
    }
    
    @IBAction func reportButtonTap(_ sender: Any) {
        //알람 띄우기
//        DiaryReportRequest.diaryId
//        DiaryReportRequest.content
        
//        DiaryReport
        let diaryReportVC = UIStoryboard(name: "DiaryReport", bundle: nil).instantiateViewController(withIdentifier: "DiaryReportViewController") as! DiaryReportViewController
        diaryReportVC.diaryId = arrivedDiaryId
        print(diaryReportVC.diaryId, "넘어간 일기 ID")
        //해주기
        self.present(diaryReportVC, animated: true, completion: nil)
    }
    
    
    @IBAction func blockButtonTap(_ sender: Any) {
        let diaryBlockVC = UIStoryboard(name: "DiaryBlock", bundle: nil).instantiateViewController(withIdentifier: "DiaryBlockViewController") as! DiaryBlockViewController
        diaryBlockVC.diaryID = arrivedDiaryId
        print(diaryBlockVC.diaryID, "차단할 일기 ID")
        self.present(diaryBlockVC, animated: true, completion: nil)
    }
    
    
}


    //MARK: - Extensions
extension ArrivedDiaryViewController {
    func receivedDiaryGetSuccess(_ responsse: ReceivedDiaryResponse) {
        //버튼 형태 바꾸기
        dismissIndicator()
        arrivedDiaryId = responsse.result.diaryId
        writedCommentCount = responsse.result.myCommentResponse.count
        print(writedCommentCount, "내가 작성안했으면 0 했으면 1")
        print(arrivedDiaryId, "신고할 id 값")
        dateLabel.text = responsse.result.date
        diaryTitleLabel.text = responsse.result.title
        diaryContentTextView.text = responsse.result.content
        
        
        myCommentResponseList = responsse.result.myCommentResponse
        
        
        
        print(writedCommentCount, "코멘트 썼는지 안썼는지")
        if writedCommentCount != 0 {
            
            myCommentTextView.text = myCommentResponseList[0].content
            myCommentTextView.textColor = UIColor(hex: 0x4E4C49)
            myCommentTextView.isEditable = false
            sendCommentButton.isHidden = false
            sendCommentButton.isEnabled = false
            sendCommentButton.layer.borderColor = UIColor(hex: 0x878379).cgColor
            sendCommentButton.setTitle("전송완료", for: .normal)
            sendCommentButton.setTitleColor(UIColor(hex: 0x878379), for: .normal)
            sendCommentButton.backgroundColor = UIColor(hex: 0xFDFCF9)
            sendCommentButton.layer.borderWidth = 1
            sendCommentButton.layer.opacity = 1
        }
        else if writedCommentCount == 0 {
            myCommentTextView.text = "일기를 읽고 따뜻한 코멘트를 달아주세요."
            myCommentTextView.textColor = UIColor(hex: 0xD2D2D2)
            myCommentTextView.isEditable = true
            myCommentTextView.isEditable = true
            sendCommentButton.layer.borderWidth = 0
            sendCommentButton.isEnabled = true
            sendCommentButton.layer.opacity = 0.4
            sendCommentButton.backgroundColor = UIColor(hex: 0x73BF90)
            sendCommentButton.setTitle("보내기", for: .normal)
            sendCommentButton.setTitleColor(UIColor(hex: 0xFDFCF9), for: .normal)
            sendCommentButton.setTitleColor(UIColor(hex: 0xFDFCF9), for: .highlighted)
            
        }
    }
}


////코멘트 전송 여부에 따라 버튼 바꿔주기 코멘트 작성안했으면 0
//if writedCommentCount == 0 {
//
//}
//else if writedCommentCount != 0 {
//
//}
