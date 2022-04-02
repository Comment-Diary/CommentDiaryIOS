//
//  SendCommentViewController.swift
//  CommentDiary
//
//  Created by 류창휘 on 2022/03/10.
//

import Foundation
import UIKit

class SendCommentViewController : UIViewController, CommentLabelChangeDelegate, CommentDateChangeDelegate {
    var apiDateString = ""
    
    func onChange(data: String) {
        yearLabel.text = data
        
    }
    
    func onDateChange(data: String) {
        apiDateString = data
        DateCommentDataManager().dateCommentData(self, dateValue: apiDateString)
        if apiDateString == "전체보기" {
            AllCommentDataManager().allCommentData(self)
        }


    }
    
    //API 조회
    var commentListResult : [AllCommentResultList] = []
    var dateCommentListResult : [DateCommentResultList] = []
    //MARK: - Properties
    @IBOutlet weak var yearLabel: UILabel!
    
    
    @IBOutlet weak var backButton: UIButton!
    
    @IBOutlet weak var sendCommentLabel: UILabel!
    
    @IBOutlet weak var topBackView: UIView!
    
    @IBOutlet weak var commentBackView: UIView!
    
    @IBOutlet weak var commentTableView: UITableView!
    
    @IBOutlet weak var dateBackView: UIView!
    
    @IBOutlet weak var periodButton: UIButton!
    @IBOutlet weak var separateView: UIView!
    
    @IBOutlet weak var dateView: UIView!
    
    
    @IBOutlet weak var firstLabel: UILabel!
    
    @IBOutlet weak var secondLabel: UILabel!
    
    //MARK: - LifeCycle
    override func viewDidLoad() {
        super.viewDidLoad()
        commentTableView.delegate = self
        commentTableView.dataSource = self
        viewSetting()
        registerCell()
        labelSetting()
        commentTableView.backgroundColor = UIColor(hex: 0xF4EDE3)
        
        yearLabel.text = "전체보기"
        apiDateString = "전체보기"
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
        if apiDateString == "전체보기" {
            AllCommentDataManager().allCommentData(self)
        }
    }
    
    func labelSetting() {
        sendCommentLabel.text = "보낸 코멘트"
        sendCommentLabel.font = UIFont.AppleSDGothic(.bold, size: 21)
        sendCommentLabel.textColor = UIColor(hex: 0x4E4C49)
        yearLabel.textColor = UIColor(hex: 0x4E4C49)
        yearLabel.font = UIFont.AppleSDGothic(.medium, size: 15)
        
        firstLabel.text = "아직 보낸 코멘트가 없어요."
        secondLabel.text = "코멘트를 작성해주세요."
        firstLabel.textColor = UIColor(hex: 0x878379)
        secondLabel.textColor = UIColor(hex: 0x878379)
        firstLabel.font = UIFont.AppleSDGothic(.medium, size: 14)
        secondLabel.font = UIFont.AppleSDGothic(.medium, size: 14)
        
    }
    
    func viewSetting() {
        view.backgroundColor = UIColor(hex: 0xFDFCF9)
        topBackView.backgroundColor = UIColor(hex: 0xFDFCF9)
        commentBackView.backgroundColor = UIColor(hex: 0xF4EDE3)
        separateView.backgroundColor = UIColor(hex: 0xE2DFD7)
        dateBackView.backgroundColor = UIColor(hex: 0xF4EDE3)
        dateView.backgroundColor = UIColor(hex: 0xFDFCF9)
        dateView.layer.cornerRadius = 4
        
        
    }
    
    func registerCell() {
        let sendCommentCell = UINib(nibName: "SendCommentCell", bundle: nil)
        commentTableView.register(sendCommentCell.self, forCellReuseIdentifier: "SendCommentCell")
    }
    
    
    //MARK: - Actions
    
    @IBAction func backButtonTap(_ sender: Any) {
        self.navigationController?.popViewController(animated: true)
    }
    
    
    @IBAction func periodButtonTap(_ sender: Any) {
        let vc = UIStoryboard(name: "PeriodCommentView", bundle: nil).instantiateViewController(withIdentifier: "PeriodCommentViewController") as! PeriodCommentViewController
        vc.delegate = self
        vc.dateDelegate = self
        self.present(vc, animated: true)
    }
    
    
    
}

    //MARK: - Extensions
extension SendCommentViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
//        return commentListResult.count
        if yearLabel.text == "전체보기" {
            return commentListResult.count
        }
        else if yearLabel.text != "전체보기" {
            return dateCommentListResult.count
        }
        return 0
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 142
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "SendCommentCell", for: indexPath) as! SendCommentCell
        cell.backgroundColor = UIColor(hex: 0xF4EDE3)
        cell.selectionStyle = .none

        if yearLabel.text == "전체보기" {
            let allCommentListResult = commentListResult[indexPath.row]
            cell.dateLabel.text = allCommentListResult.date
            cell.commentLabel.text = allCommentListResult.content
        }
        else if yearLabel.text != "전체보기" {
            let dateCommentList = dateCommentListResult[indexPath.row]
            cell.dateLabel.text = dateCommentList.date
            cell.commentLabel.text = dateCommentList.content
        }
        
        return cell
        
    }
    
    
    
    
}


extension SendCommentViewController {
    func getCommentListSuccess(_ response : AllCommentResponse) {
        commentListResult = response.result
        if commentListResult.count == 0 {
            commentTableView.isHidden = true
        }
        else if commentListResult.count != 0 {
            commentTableView.isHidden = false
        }
        commentTableView.reloadData()
    }
    
//    func getCommentListDateSuccess(_ response: Se)
    func getDateCommentListSucces(_ response: DateCommentResponse) {
        dateCommentListResult = response.result
        if dateCommentListResult.count == 0 {
            commentTableView.isHidden = true
        }
        else if dateCommentListResult.count != 0 {
            commentTableView.isHidden = false
        }
        commentTableView.reloadData()
    }
}
