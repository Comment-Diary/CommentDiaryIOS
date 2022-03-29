//
//  GatherLookDetailViewController.swift
//  CommentDiary
//
//  Created by 류창휘 on 2022/03/19.
//

import Foundation
import UIKit

class GatherLookDetailViewController : UIViewController {
    var diaryID : Int = 0
    var diaryResult : diaryCheckResult?
    var myCommentLists : [myCommentCheckResponseList] = []
    var commentID : Int = 0
    //MARK: - Properties
    
    @IBOutlet weak var commentTableView: UITableView!
//    @IBOutlet weak var tableviewHeight: NSLayoutConstraint!
    
    @IBOutlet weak var backButton: UIButton!
    
    @IBOutlet weak var topBackView: UIView!
    

    
    
    
    //MARK: - LifeCycle
    override func viewDidLoad() {
        super.viewDidLoad()
        labelSetting()
        buttonSetting()
        viewSetting()
        
        commentTableView.rowHeight = UITableView.automaticDimension
        commentTableView.delegate = self
        commentTableView.dataSource = self
        
        
        
        
        registerCell()
        
    }
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        //API 조회
        GatherLookDetailDiaryCheckDataManager().commentDiaryCheckData(diaryID: diaryID, self)

    }
    
    func labelSetting() {

    }
    
    func buttonSetting() {
        
    }
    
    func viewSetting() {
        topBackView.backgroundColor = UIColor(hex: 0xF4EDE3)
        commentTableView.backgroundColor = UIColor(hex: 0xF4EDE3)
        view.backgroundColor = UIColor(hex: 0xF4EDE3)
    }
    
    func registerCell() {
//        let someoneCell = UINib(nibName: "someoneCommentCell", bundle: nil)
//        commentTableView.register(someoneCell.self, forCellReuseIdentifier: "someoneCommentCell")
//        let myCommentCell = UINib(nibName: "myCommentDiaryCell", bundle: nil)
//        commentTableView.register(myCommentCell.self, forCellReuseIdentifier: "myCommentDiaryCell")
        commentTableView.register(someoneCommentCell.nib(), forCellReuseIdentifier: someoneCommentCell.identifier)
        commentTableView.register(myCommentDiaryCell.nib(), forCellReuseIdentifier: myCommentDiaryCell.identifier)
    }
    
    //MARK: - Actions
    @IBAction func backButtonTap(_ sender: Any) {
        navigationController?.popViewController(animated: true)
    }
    
    

    

}


    //MARK: - Extensions
extension GatherLookDetailViewController : UITableViewDelegate, UITableViewDataSource, HeartDelegate, ReportDelegate, BlockDelegate {
    
    func heartButtonTapped(_ index: Int) {
        print(index, "인덱스 값, 하트")
        //
        LikeDataManager().likePatchData(self, index)
    }
    
    
    func reportButtonTapped(_ index: Int) {
        print(index, "인덱스 값 신고")
        let vc = UIStoryboard(name: "CommentReportAlert", bundle: nil).instantiateViewController(withIdentifier: "CommentReportViewController") as! CommentReportViewController
        vc.commentIndex = index
        self.present(vc, animated: true)
    }
    func blockButtonTapped(_ index: Int) {
        print(index, "인뎃스 값, 신고")
        let vc = UIStoryboard(name: "CommentBlock", bundle: nil).instantiateViewController(withIdentifier: "CommentBlockViewController") as! CommentBlockViewController
        vc.commentID = index
        self.present(vc, animated: true)
    }
    

    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 2
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        switch section {
        case 0:
            return 1
        case 1:
            return myCommentLists.count
        default:
            return 0
        }
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {

//        let cells: UITableViewCell?
        
        if indexPath.section == 0 {
            let cell = tableView.dequeueReusableCell(withIdentifier: "myCommentDiaryCell", for: indexPath) as! myCommentDiaryCell
            
            cell.backgroundColor = UIColor(hex: 0xF4EDE3)
            cell.dateLabel.font = UIFont.AppleSDGothic(.bold, size: 15)
            cell.dateLabel.textColor = UIColor(hex: 0xFFAC86)
            cell.titleLabel.font = UIFont.AppleSDGothic(.bold, size: 21)
            cell.titleLabel.textColor = UIColor(hex: 0x4E4C49)
            cell.contentVIew.textColor = UIColor(hex: 0x4E4C49)
            cell.contentVIew.font = UIFont.AppleSDGothic(.medium, size: 15)
            cell.selectionStyle = .none
            
            
            cell.dateLabel.text = diaryResult?.date ?? ""
            cell.titleLabel.text = diaryResult?.title ?? ""
            cell.contentVIew.text = diaryResult?.content ?? ""
            
            
            return cell
        }
        else {
            let cell = tableView.dequeueReusableCell(withIdentifier: "someoneCommentCell", for: indexPath) as! someoneCommentCell
            let someoneComment = myCommentLists[indexPath.row]
            
//            cell.index = indexPath.row
            cell.index = someoneComment.id
            
            
            cell.backgroundColor = UIColor(hex: 0xF4EDE3)
            cell.someoneLabel.text = "누군가의 코멘트"
            cell.someoneLabel.font = UIFont.AppleSDGothic(.bold, size: 13)
            cell.someoneLabel.textColor = UIColor(hex: 0x73BF90)
            cell.someoneComment.font = UIFont.AppleSDGothic(.medium, size: 15)
            cell.someoneComment.textColor = UIColor(hex: 0x4E4C49)

            
            
            
            cell.selectionStyle = .none
            cell.someoneComment.text = someoneComment.content
            cell.heartButton.isSelected = someoneComment.like
            if cell.heartButton.isSelected == true {
                cell.heartButton.setImage(UIImage(named: "customHeartFill"), for: .normal)
            }
            else if cell.heartButton.isSelected == false {
                cell.heartButton.setImage(UIImage(named: "customHeart"), for: .normal)
            }
            commentID = someoneComment.id
            print(commentID)
            
            cell.reportDelegate = self
            cell.heartDelegate = self
            cell.blockDelegate = self
            
            
            return cell

           
        }
        

    }
    
//    func tableView(_ tableView: UITableView, ㅗ댜ㅎ section: Int) -> CGFloat {
//        return CGFloat(300)
//    }
//    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
//        return CGFloat(300.0)
//    }
//
    
}

extension GatherLookDetailViewController {
    func diaryGetSuccess(_ response: DiaryCheckResopnse) {
        myCommentLists = response.result.commentResponseList
        print(myCommentLists.count, "?????????????????????????")
        diaryResult = response.result

        
        
        commentTableView.reloadData()
    }
}
