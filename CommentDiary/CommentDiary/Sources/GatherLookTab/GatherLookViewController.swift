//
//  GatherLookViewController.swift
//  CommentDiary
//
//  Created by 류창휘 on 2022/03/11.
//

import Foundation
import UIKit

class GatherLookViewController : UIViewController, LabelChangeDelegate, DateChangeDelegate {

    var allSelectedDiaryID : Int = 0
    var dateSelectedDiaryID : Int = 0
    
    //API 조회
    var gatherDiaryAllList : [GatherDiaryAllListResult] = []
    var gatherDiaryDateList : [GatherDiaryDateListResult] = []
    
    func onChange(data: String) {
        yearLabel.text = data
    }
    func onDateChange(data: String) {
        print(data, "API에 들어갈 값")
//        GatherDiaryDateDataManager().gatherDiaryDateData(diaryDate: data, self)
        apiDateString = data
        GatherDiaryDateDataManager().gatherDiaryDateData(self, dateValue: apiDateString)
        if apiDateString == "전체보기" {
            GatherDiaryAllDataManager().gahterDiaryAllData(self)
        }
    }
    
    
    var apiDateString = ""
    //MARK: - Properties
    @IBOutlet weak var backgroundView: UIView!
    
    @IBOutlet weak var noDiaryLabel: UILabel!
    
    @IBOutlet weak var yearLabel: UILabel!
    
    @IBOutlet weak var dateButton: UIButton!
    @IBOutlet weak var sortTableView: UITableView!
    
    @IBOutlet weak var topBackView: UIView!
    
    
    @IBOutlet weak var dateButtonView: UIView!
    
    
    //MARK: - LifeCycle
    override func viewDidLoad() {
        super.viewDidLoad()
        
        

//        sortTableView.isHidden = true
        
        backViewSetting()
        sortTableView.delegate = self
        sortTableView.dataSource = self

        buttonSetting()
        
        yearLabel.text = "전체보기"
        apiDateString = "전체보기"
        registerCell()
        buttonSetting()
        

    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        if apiDateString == "전체보기" {
            GatherDiaryAllDataManager().gahterDiaryAllData(self)
        }
        else {
            //특정 년 월 조회
//            GatherDiaryDateDataManager().gatherDiaryDateData(self)
            
        }
        print(apiDateString, "?????")
    }
    
    
    
    func registerCell() {
        let diaryListCell = UINib(nibName: "MyDiaryListCell", bundle: nil)
        sortTableView.register(diaryListCell.self, forCellReuseIdentifier: "MyDiaryListCell")
    }

    func backViewSetting() {

//        sortTableView.backgroundColor = UIColor(hex: 0xF4EDE3)
        sortTableView.backgroundColor = UIColor(hex: 0xF4EDE3)
        view.backgroundColor = UIColor(hex: 0xE2DFD7)
        backgroundView.backgroundColor = UIColor(hex: 0xF4EDE3)
        topBackView.backgroundColor = UIColor(hex: 0xE2DFD7)
        dateButtonView.layer.cornerRadius = 4
    }
    func LabelSetting() {
        noDiaryLabel.text = "아직 작성된 일기가 없어요! 일기를 작성해주세요 :)"
    }
    

    func buttonSetting() {
        dateButton.layer.cornerRadius = 4
    }
    
    
    //MARK: - Actions
    
    @IBAction func dateButtonTap(_ sender: Any) {
        let vc = UIStoryboard(name: "PeriodView", bundle: nil).instantiateViewController(withIdentifier: "PeriodViewAlertViewController") as! PeriodViewAlertViewController
        vc.delegate = self
        vc.dateDelegate = self
        self.present(vc, animated: true)
    }
    
    
    

    
}

    //MARK: - Extenstions
extension GatherLookViewController {
    func gatehrDiaryAllSuccess(_ response : GatherDiaryAllResponse) {
        gatherDiaryAllList = response.result!
        if gatherDiaryAllList.count == 0 {
            sortTableView.isHidden = true
        } else if gatherDiaryAllList.count != 0 {
            sortTableView.isHidden = false
        }
        sortTableView.reloadData()
    }
    
    func gatehrDiaryDateSuccess(_ response : GatherDiaryDateResponse) {
        gatherDiaryDateList = response.result!
        if gatherDiaryDateList.count == 0 {
            sortTableView.isHidden = true
        }
        else if gatherDiaryDateList.count != 0 {
            sortTableView.isHidden = false
        }
        sortTableView.reloadData()
    }
}
extension GatherLookViewController: UITableViewDelegate, UITableViewDataSource {
    

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if yearLabel.text == "전체보기" {
            return gatherDiaryAllList.count

        }
        else if yearLabel.text != "전체보기" {
            return gatherDiaryDateList.count

        }

        return 0
    }


    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "MyDiaryListCell", for: indexPath) as! MyDiaryListCell
        cell.backgroundColor = UIColor(hex: 0xF4EDE3)
        cell.selectionStyle = .none
        if yearLabel.text == "전체보기" {
            let gatherDiaryAllResult = gatherDiaryAllList[indexPath.row]
            cell.dateLabel.text = gatherDiaryAllResult.date ?? ""
            cell.titleLabel.text = gatherDiaryAllResult.title ?? ""
            cell.contentLabel.text = gatherDiaryAllResult.content ?? ""
            cell.commentCountLabel.text = "\(gatherDiaryAllResult.commentCnt ?? 0)"
            cell.selectedId = gatherDiaryAllResult.id ?? 0
            allSelectedDiaryID = gatherDiaryAllResult.id ?? 0
        } else if yearLabel.text != "전체보기" {
            let gatherDiaryDateResult = gatherDiaryDateList[indexPath.row]
            cell.dateLabel.text = gatherDiaryDateResult.date ?? ""
            cell.titleLabel.text = gatherDiaryDateResult.title ?? ""
            cell.contentLabel.text = gatherDiaryDateResult.content ?? ""
            cell.commentCountLabel.text = "\(gatherDiaryDateResult.commentCnt ?? 0)"
            cell.selectedId = gatherDiaryDateResult.id ?? 0
            dateSelectedDiaryID = gatherDiaryDateResult.id ?? 0
            
        }

        
        //API
    

        return cell
    }

    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 142
    }

    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let gatherLookDetailVC = UIStoryboard(name: "GatherLookDetail", bundle: nil).instantiateViewController(withIdentifier: "GatherLookDetailViewController") as! GatherLookDetailViewController
        
        self.navigationController?.pushViewController(gatherLookDetailVC, animated: true)
        
        if yearLabel.text == "전체보기" {
//            gatherLookDetailVC.diaryID = allSelectedDiaryID
//            print(gatherLookDetailVC.diaryID, "id값?????????")
            gatherLookDetailVC.diaryID = gatherDiaryAllList[indexPath.row].id ?? 0
            print(gatherLookDetailVC.diaryID, "id값???????")
        }
        else if yearLabel.text != "전체보기" {
//            gatherLookDetailVC.diaryID = dateSelectedDiaryID
//            print(gatherLookDetailVC.diaryID, "id값??????????")
            gatherLookDetailVC.diaryID = gatherDiaryDateList[indexPath.row].id ?? 0
            print(gatherLookDetailVC.diaryID, "id값????????/0")
        }
    }
    


}




