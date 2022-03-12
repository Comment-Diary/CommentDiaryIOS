//
//  GatherLookViewController.swift
//  CommentDiary
//
//  Created by 류창휘 on 2022/03/11.
//

import Foundation
import UIKit

class GatherLookViewController : UIViewController, LabelChangeDelegate, DateChangeDelegate {

    
    //API 조회
    var gatherDiaryAllList : [GatherDiaryAllListResult] = []
    
    func onChange(data: String) {
        yearLabel.text = data
    }
    func onDateChange(data: String) {
        print(data, "API에 들어갈 값")
//        GatherDiaryDateDataManager().gatherDiaryDateData(diaryDate: data, self)
        apiDateString = data
        GatherDiaryDateDataManager().gatherDiaryDateData(self)
    }
    
    
    var apiDateString = ""
    //MARK: - Properties
    @IBOutlet weak var backgroundView: UIView!
    
    @IBOutlet weak var noDiaryLabel: UILabel!
    
    @IBOutlet weak var yearLabel: UILabel!
    
    @IBOutlet weak var dateButton: UIButton!
    @IBOutlet weak var sortTableView: UITableView!
    
    //MARK: - LifeCycle
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
        self.sortTableView!.contentInset = UIEdgeInsets(top: 13, left: 0, bottom: 0, right: 0)
//        sortTableView.isHidden = true
        
        backViewSetting()
        sortTableView.delegate = self
        sortTableView.dataSource = self
//        cellsRegister()
        
        
        yearLabel.text = "전체보기"
        apiDateString = "전체보기"
        registerCell()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        if apiDateString == "전체보기" {
            GatherDiaryAllDataManager().gahterDiaryAllData(self)
        }
        else {
            //특정 년 월 조회
            GatherDiaryDateDataManager().gatherDiaryDateData(self)
            
        }
        print(apiDateString, "?????")
    }
    
    
    
    func registerCell() {
        let diaryListCell = UINib(nibName: "MyDiaryListCell", bundle: nil)
        sortTableView.register(diaryListCell.self, forCellReuseIdentifier: "MyDiaryListCell")
    }

    func backViewSetting() {
        backgroundView.backgroundColor = UIColor(hex: 0xE5E5E5)
    }
    func LabelSetting() {
        noDiaryLabel.text = "아직 작성된 일기가 없어요! 일기를 작성해주세요 :)"
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
        gatherDiaryAllList = response.result
        sortTableView.reloadData()
    }
}
extension GatherLookViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return gatherDiaryAllList.count

    }


    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "MyDiaryListCell", for: indexPath) as! MyDiaryListCell
        if yearLabel.text == "전체보기" {
            let gatherDiaryAllResult = gatherDiaryAllList[indexPath.row]
            cell.layer.cornerRadius = 10
            cell.backgroundColor = UIColor(hex: 0xFDFCF9)
            cell.dateLabel.text = gatherDiaryAllResult.date
            cell.titleLabel.text = gatherDiaryAllResult.title
            cell.contentLabel.text = gatherDiaryAllResult.content
            cell.commentCountLabel.text = "\(gatherDiaryAllResult.commentCnt)"
        } else {
            
        }

        
        //API
    

        return cell
    }

    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 142
    }

    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
//        let NDetailDiaryStoryboard = UIStoryboard(name: "NDetailDiary", bundle: nil)
//        let NDetailDiaryVC = NDetailDiaryStoryboard.instantiateViewController(withIdentifier: "NDetailDiaryViewController")
//        self.navigationController?.pushViewController(NDetailDiaryVC, animated: true)
    }


}




