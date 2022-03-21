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

    }
    
    //API 조회
    var commentListResult : [sentCommentListResult] = []
    //MARK: - Properties
    @IBOutlet weak var yearLabel: UILabel!
    
    
    @IBOutlet weak var backButton: UIButton!
    
    @IBOutlet weak var sendCommentLabel: UILabel!
    
    @IBOutlet weak var topBackView: UIView!
    
    @IBOutlet weak var commentBackView: UIView!
    
    @IBOutlet weak var commentTableView: UITableView!
    
    
    @IBOutlet weak var periodButton: UIButton!
    
    //MARK: - LifeCycle
    override func viewDidLoad() {
        super.viewDidLoad()
        commentTableView.delegate = self
        commentTableView.dataSource = self
        viewSetting()
        registerCell()
        
    }
    
    func viewSetting() {
        view.backgroundColor = UIColor(hex: 0xFDFCF9)
        topBackView.backgroundColor = UIColor(hex: 0xFDFCF9)
        commentBackView.backgroundColor = UIColor(hex: 0xF4EDE3)
        
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
//        vc.delegate = self
//        vc.dateDelegate = self
        self.present(vc, animated: true)
    }
    
    
    
}

    //MARK: - Extensions
extension SendCommentViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return commentListResult.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "SendCommentCell", for: indexPath) as! SendCommentCell
        
        let allCommentListResult = commentListResult[indexPath.row]
        
        cell.backgroundColor = UIColor(hex: 0xFDFCF9)
        cell.selectionStyle = .none
        cell.dateLabel.text = allCommentListResult.date
        cell.commentLabel.text = allCommentListResult.content
        
        return cell
        
    }
    
    
    
    
}


extension SendCommentViewController {
    func getCommentListSuccess(_ response : SentCommentListResponse) {
        commentListResult = response.result!
        commentTableView.reloadData()
    }
    
//    func getCommentListDateSuccess(_ response: Se)
}
