//
//  WritingDiaryViewController.swift
//  CommentDiary
//
//  Created by 류창휘 on 2022/02/17.
//

import Foundation
import UIKit



//
//class WritingDiaryViewController: UIViewController {
//
//    var selectedTapDate: String = ""   //선택된 날짜
//    var selectedMonDate: String = ""
//
//    //캘린더 표시 이벤트
//    var mainPageResult : [diaryMainPageResult] = []
//    //MARK: - Properties
//    @IBOutlet weak var writingDiaryTableView: UITableView!
//
//    //MARK: - LifeCycle
//    override func viewDidLoad() {
//        super.viewDidLoad()
//        view.backgroundColor = UIColor.mainBackgroundColor
//        writingDiaryTableView.delegate = self
//        writingDiaryTableView.dataSource = self
//        cellsRegister()
//
//
//        //일기 메인 페이지 조회
//        let manager = DiaryMainPageDataManager()
//        manager.delegate = self
//        manager.diaryMainData(self)
//
//
//    }
//
//    func cellsRegister() {
//        let calendarCell = UINib(nibName: "CalendarTableViewCell", bundle: nil)
//        writingDiaryTableView.register(calendarCell.self, forCellReuseIdentifier: "CalendarTableViewCell")
//
//        let writingDiaryCell = UINib(nibName: "WritingDiaryTableViewCell", bundle: nil)
//        writingDiaryTableView.register(writingDiaryCell.self, forCellReuseIdentifier: "WritingDiaryTableViewCell")
//    }
//
//    //일기 쓰기 화면 전환
//    @objc func TapWritingTableViewCell(_ sender: UIButton) {
//        let todayDiaryStoryBoard = UIStoryboard(name: "TodayDiary", bundle: nil)
//        guard let todayDiaryVC = todayDiaryStoryBoard.instantiateViewController(withIdentifier: "TodayDiaryViewController") as? TodayDiaryViewController else { return }
//        todayDiaryVC.dateText = selectedTapDate
//            self.navigationController?.pushViewController(todayDiaryVC, animated: true)
//
//    }
//
//
//
//    //MARK: - Actions
//}
//
//    //MARK: - Extensions
//extension WritingDiaryViewController: UITableViewDelegate, UITableViewDataSource {
//    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
//        return 1
//    }
//
//    func numberOfSections(in tableView: UITableView) -> Int {
//        return 2
//    }
//
//    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
//
//        if indexPath.section == 0 {
//            let cell = tableView.dequeueReusableCell(withIdentifier: "CalendarTableViewCell", for: indexPath) as! CalendarTableViewCell
//            cell.delegate = self
//            cell.selectionStyle = UITableViewCell.SelectionStyle.none
//            selectedMonDate = cell.apiDateString
//
//
//
//
//            func diaryMainPageSuccess(_ response: DiaryMainPageResponse) {
//                print("실행")
//                for selectedDiary in mainPageResult {
//                    if selectedDiary.deliveryYn == "Y" {
//                        cell.nDiary.append(selectedDiary.date)
//                        cell.calendarView.appearance.eventDefaultColor = UIColor.red
//                        print(cell.nDiary, "혼자쓰기 배열")
//                    } else if selectedDiary.deliveryYn == "N" {
//                        cell.yDiary.append(selectedDiary.date)
//                        cell.calendarView.appearance.eventDefaultColor = UIColor.blue
//                    }
//                }
//                tableView.reloadData()
//                NotificationCenter.default.post(name: Notification.Name("reloadCalendar"), object: nil)
//            }
//
//
//
//
//
//
//            return cell
//        }
////
//        if indexPath.section == 1 {
//            let cell = tableView.dequeueReusableCell(withIdentifier: "WritingDiaryTableViewCell", for: indexPath) as! WritingDiaryTableViewCell
//            cell.selectionStyle = UITableViewCell.SelectionStyle.none
//            let writingTableViewCell = cell
//            writingTableViewCell.diaryWriteButton.addTarget(self, action: #selector(TapWritingTableViewCell(_:)), for: .touchUpInside)
//            let dateformatter = DateFormatter()
//            dateformatter.dateFormat = "yyyy.MM.dd"
//            selectedTapDate = dateformatter.string(from: Date())
//            writingTableViewCell.diaryDateLabel.text = dateformatter.string(from: Date())
//            return cell
//        }
//        return UITableViewCell()
//
//    }
//
//
//    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
//        return UITableView.automaticDimension
//    }
//
//}
//
////Delegate
//extension WritingDiaryViewController: selectDateDelegate {
//    func dateString(TapDate: String) {
//        selectedTapDate = TapDate
//    }
//
//
//}
//
//
//extension WritingDiaryViewController: delegatable {
//    func diaryMainPageSuccess(_ response: DiaryMainPageResponse) {
//        let cell = self.writingDiaryTableView.cellForRow(at: IndexPath(row: 0, section: 0)) as! CalendarTableViewCell
//        for selectedDiary in mainPageResult {
//            if selectedDiary.deliveryYn == "Y" {
//                cell.update(date: selectedDiary.date, type: "Y")
//                cell.calendarView.appearance.eventDefaultColor = UIColor.red
//                print(cell.nDiary, "혼자쓰기 배열")
//            } else if selectedDiary.deliveryYn == "N" {
//                cell.update(date: selectedDiary.date, type: "N")
//                cell.calendarView.appearance.eventDefaultColor = UIColor.blue
//            }
//        }
//        self.writingDiaryTableView.reloadData()
//    }
//}
//
//
//
//
//
