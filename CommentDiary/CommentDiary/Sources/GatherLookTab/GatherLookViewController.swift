//
//  GatherLookViewController.swift
//  CommentDiary
//
//  Created by 류창휘 on 2022/03/11.
//

import Foundation
import UIKit

class GatherLookViewController : UIViewController, LabelChangeDelegate, DateChangeDelegate {
    
    lazy var detailDayDateFormatter: DateFormatter = {
        let df = DateFormatter()
        df.dateFormat = "yyyy.MM.dd"
        return df
    }()
    
    //클릭한 셀의 코멘트 달렸는지
    var hadCommentBool : Bool = false
    
    //선택된 날짜
    var selectedDateString : String = ""
    
    //이틀 넘어가는지 bool
    var twodaysBool : Bool = false
    //true이면 현재 false이면 과거
    var pastOrNow : Bool = true
    
    //true 이면 코멘트 쓰러가기 false 이면 코멘트 보러가기
    var myCommentBool : Bool = false

    var SelectedDiaryID : Int = 0
    
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
        if apiDateString != "전체보기" {
            GatherDiaryDateDataManager().gatherDiaryDateData(self, dateValue: apiDateString)
        }
        else if apiDateString == "전체보기" {
            GatherDiaryAllDataManager().gahterDiaryAllData(self)
        }
    }
    
    //당겨서 리프레쉬
    private var refreshControl = UIRefreshControl()
    
    
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
        

        
        //당겨서 리프레시
        sortTableView.refreshControl = refreshControl
        refreshControl.addTarget(self, action: #selector(refresh), for: .valueChanged)
    }
    
    @objc func refresh() {
    
        DispatchQueue.main.asyncAfter(deadline: .now() + 1) {
            if self.apiDateString == "전체보기" {
                GatherDiaryAllDataManager().gahterDiaryAllData(self)
            }
            else if self.apiDateString != "전체보기" {
                GatherDiaryDateDataManager().gatherDiaryDateData(self, dateValue: self.apiDateString)
            }
            
            self.sortTableView.reloadData()
            self.refreshControl.endRefreshing()
        }

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
        dateButtonView.backgroundColor = UIColor(hex: 0xFDFCF9)
    }
    func LabelSetting() {
        noDiaryLabel.text = "아직 작성된 일기가 없어요! 일기를 작성해주세요 :)"
        noDiaryLabel.font = UIFont.AppleSDGothic(.medium, size: 14)
        noDiaryLabel.textColor = UIColor(hex: 0x878379)
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
            //혼자 쓴 일기일 경우 이미지 숨기기
            if gatherDiaryAllResult.deliveryYn == "N" {
                cell.commentCountBackView.isHidden = true
            }
            else if gatherDiaryAllResult.deliveryYn == "Y" {
                cell.commentCountBackView.isHidden = false
            }
            cell.selectedId = gatherDiaryAllResult.id ?? 0
//            allSelectedDiaryID = gatherDiaryAllResult.id ?? 0
        } else if yearLabel.text != "전체보기" {
            let gatherDiaryDateResult = gatherDiaryDateList[indexPath.row]
            cell.dateLabel.text = gatherDiaryDateResult.date ?? ""
            cell.titleLabel.text = gatherDiaryDateResult.title ?? ""
            cell.contentLabel.text = gatherDiaryDateResult.content ?? ""
            cell.commentCountLabel.text = "\(gatherDiaryDateResult.commentCnt ?? 0)"
            //혼자 쓴 일기일 경우 이미지 숨기기
            if gatherDiaryDateResult.deliveryYn == "N" {
                cell.commentCountBackView.isHidden = true
            }
            else if gatherDiaryDateResult.deliveryYn == "Y" {
                cell.commentCountBackView.isHidden = false
            }
            cell.selectedId = gatherDiaryDateResult.id ?? 0
//            dateSelectedDiaryID = gatherDiaryDateResult.id ?? 0
            
        }

        
        //API
    

        return cell
    }

    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 142
    }

    
    
    
    
    
    
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {

//        print(gatherDiaryDateList[indexPath.row].id, "선택한 일기의 id값")
        
        if yearLabel.text == "전체보기" {
            let gatherDiaryAllListResult = gatherDiaryAllList[indexPath.row]
            SelectedDiaryID = gatherDiaryAllListResult.id ?? 0
        }
        else if yearLabel.text != "전체보기" {
            let gatherDiaryDateListResult = gatherDiaryDateList[indexPath.row]
            SelectedDiaryID = gatherDiaryDateListResult.id ?? 0
        }
        
        self.showIndicator()
        SortationDataManager().gatherLookDetailSortData(diaryID: SelectedDiaryID, self)
        
        
        
        
        
        

    }
}

extension GatherLookViewController {
    func selectedDiaryGet(_ response: DiaryCheckResopnse) {
        self.dismissIndicator()
        
        if response.result.commentResponseList.count == 0 {
            //코멘트 없음
            hadCommentBool = false
        }
        else if response.result.commentResponseList.count != 0 {
            //코멘트 있음
            hadCommentBool = true
        }
    
        
        //혼자 쓴 일기
        if response.result.deliveryYn == "N" {
            print("혼자쓴 일기로 이동")
            let gatherLookDetailVC = UIStoryboard(name: "GatherLookDetail", bundle: nil).instantiateViewController(withIdentifier: "GatherLookDetailViewController") as! GatherLookDetailViewController
            gatherLookDetailVC.diaryID = self.SelectedDiaryID
            self.navigationController?.pushViewController(gatherLookDetailVC, animated: true)
        }
        
        else if response.result.deliveryYn == "Y" {
            //일기 날짜
            let diaryDateString = response.result.date
            
            let diaryDateValue = detailDayDateFormatter.date(from: diaryDateString)
            
            let datePlus = Calendar.current.date(byAdding: .day, value: 1, to: diaryDateValue!)
            
            let datePlusString = detailDayDateFormatter.string(from: datePlus!)
            print("하루 더한 날짜")
            
            print(detailDayDateFormatter.string(from: Date(timeIntervalSinceNow: -25200)), "오늘")
            
            if datePlusString == detailDayDateFormatter.string(from: Date(timeIntervalSinceNow: -25200)) {
                pastOrNow = true
            }
            else if datePlusString != detailDayDateFormatter.string(from: Date(timeIntervalSinceNow: -25200)) {
                pastOrNow = false
            }
            
            
            
            //오늘 날짜
            let todayDateString = detailDayDateFormatter.string(from: Date(timeIntervalSinceNow: -25200))
            let todayDateValue = detailDayDateFormatter.date(from: todayDateString)
            
            //날짜 비교
            let interval = todayDateValue!.timeIntervalSince(diaryDateValue!)
            
            let days = Int(interval / 86400)
            
            if days >= 2 {
                twodaysBool = true
            }
            else if days < 2 {
                twodaysBool = false
            }
            
            
            self.showIndicator()
            CompareDateDataManager().commentDiaryDateData(self, dateValue: datePlusString)
        }
        
        
    }
}


extension GatherLookViewController {
    func countCommentResponse(_ response: DateCommentResponse) {
        self.dismissIndicator()
        if response.result.count == 0 {
            //유저가 코멘트 안씀
            myCommentBool = false
        }
        else if response.result.count != 0 {
            myCommentBool = true
        }
        
        
        if hadCommentBool == true {
            if myCommentBool == true {
                print("코멘트 보러가기")
                let gatherLookDetailVC = UIStoryboard(name: "GatherLookDetail", bundle: nil).instantiateViewController(withIdentifier: "GatherLookDetailViewController") as! GatherLookDetailViewController
                gatherLookDetailVC.diaryID = self.SelectedDiaryID
                self.navigationController?.pushViewController(gatherLookDetailVC, animated: true)
            }
            else if myCommentBool == false {
                if twodaysBool == true {
                    print("내가 코멘트 안씀")
                    let yNotWriteCommentVC = UIStoryboard(name: "YNotWriteComment", bundle: nil).instantiateViewController(withIdentifier: "YNotWriteCommentViewController") as! YNotWriteCommentViewController
                    yNotWriteCommentVC.diaryID = self.SelectedDiaryID
                    self.navigationController?.pushViewController(yNotWriteCommentVC, animated: true)
                }
                else if twodaysBool == false {
                    print("코멘트 작성하기")
                    let yReadCommentVC = UIStoryboard(name: "YReadComment", bundle: nil).instantiateViewController(withIdentifier: "YReadCommentViewController") as! YReadCommentViewController
                    yReadCommentVC.diaryId = self.SelectedDiaryID
                    yReadCommentVC.completion = {
                        self.tabBarController?.selectedIndex = 1
                    }
                    self.navigationController?.pushViewController(yReadCommentVC, animated: true)
                }
               
                
                
            }
        }
        
        else if hadCommentBool == false {
            if twodaysBool == true {
                print("코멘트 오지 않음")
                let notArrivalCommentDiaryVC = UIStoryboard(name: "NotArrivalCommentDiary", bundle: nil).instantiateViewController(withIdentifier: "NotArrivalCommentDiaryViewController") as! NotArrivalCommentDiaryViewController
                notArrivalCommentDiaryVC.diaryID = self.SelectedDiaryID
                self.navigationController?.pushViewController(notArrivalCommentDiaryVC, animated: true)
                
            }
            else if twodaysBool == false {
                print("코멘트 기다리기")
                let detailCommentDiaryVC = UIStoryboard(name: "DetailCommentDiary", bundle: nil).instantiateViewController(withIdentifier: "DetailCommentDiaryViewController") as! DetailCommentDiaryViewController
                detailCommentDiaryVC.diaryInt = self.SelectedDiaryID
                detailCommentDiaryVC.transToggle = true
                self.navigationController?.pushViewController(detailCommentDiaryVC, animated: true)
                
            }
        }
        
        //코멘트 보러가기
        //myCommentBool = true, myCommentBool = true

    }
}




//코멘트 보러가기
//delivery Y




//코멘트 기다리기
//delivery Y
//코멘트 cnt 0


//코멘트 오지 않음



//코멘트 작성 해야함


//
////오늘 날짜
//let todayDateString = detailDayDateFormatter.string(from: Date(timeIntervalSinceNow: -25200))
//let todayDateValue = detailDayDateFormatter.date(from: todayDateString)
//
//
//
//
//
//
//
//let gatherLookDetailVC = UIStoryboard(name: "GatherLookDetail", bundle: nil).instantiateViewController(withIdentifier: "GatherLookDetailViewController") as! GatherLookDetailViewController
//self.navigationController?.pushViewController(gatherLookDetailVC, animated: true)
//
//if yearLabel.text == "전체보기" {
//    let gatherDiaryAllListResult = gatherDiaryAllList[indexPath.row]
//    //선택된 날짜
////            selectedDateString = gatherDiaryAllListResult.date ?? ""
//    print(selectedDateString, "cell 중에 선택된 날짜")
//
//
//    //선택된 날짜 Date
//    let selectedDateValueAll = detailDayDateFormatter.date(from: selectedDateString)!
//    //날짜 비교
//    let intervalAll = todayDateValue!.timeIntervalSince(selectedDateValueAll)
//
//    let daysAll = Int(intervalAll / 86400)
//
//    if daysAll >= 2 {
//        //이틀 이상 넘어감
//        twodaysBool = true
//    }
//    else if daysAll < 2 {
//        twodaysBool = false
//    }
//
//
//    if gatherDiaryAllListResult.commentCnt == 0 && gatherDiaryAllListResult.deliveryYn == "Y" && twodaysBool == true {
//        print("코멘트 없는 일기")
//
//    }
//    else if gatherDiaryAllListResult.commentCnt == 0 && gatherDiaryAllListResult.deliveryYn == "Y" && twodaysBool == false {
//        print("전송완료 - 조금만 기다려주세요.")
//
//    }
//
//    else if gatherDiaryAllListResult.commentCnt != 0 && gatherDiaryAllListResult.deliveryYn == "Y" &&
//
//
//
//
//    gatherLookDetailVC.diaryID = gatherDiaryAllList[indexPath.row].id ?? 0
//    print(gatherLookDetailVC.diaryID, "id값???????")
//
//
//
//
//}
//
//
//
////        let gatherLookDetailVC = UIStoryboard(name: "GatherLookDetail", bundle: nil).instantiateViewController(withIdentifier: "GatherLookDetailViewController") as! GatherLookDetailViewController
////        self.navigationController?.pushViewController(gatherLookDetailVC, animated: true)
////
////        if yearLabel.text == "전체보기" {
//////            gatherLookDetailVC.diaryID = allSelectedDiaryID
//////            print(gatherLookDetailVC.diaryID, "id값?????????")
////            gatherLookDetailVC.diaryID = gatherDiaryAllList[indexPath.row].id ?? 0
////            print(gatherLookDetailVC.diaryID, "id값???????")
////        }
////        else if yearLabel.text != "전체보기" {
//////            gatherLookDetailVC.diaryID = dateSelectedDiaryID
//////            print(gatherLookDetailVC.diaryID, "id값??????????")
////            gatherLookDetailVC.diaryID = gatherDiaryDateList[indexPath.row].id ?? 0
////            print(gatherLookDetailVC.diaryID, "id값????????/0")
////        }
//
//
//
//}
