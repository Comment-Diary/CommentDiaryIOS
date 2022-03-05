//
//  WritingDiaryVC.swift
//  CommentDiary
//
//  Created by 류창휘 on 2022/03/05.
//

import Foundation
import UIKit
import FSCalendar

class WritingDiaryVC: UIViewController, FSCalendarDelegate, FSCalendarDataSource, FSCalendarDelegateAppearance {
    //달력 년월 표시
    private var currentPage: Date?
    lazy var today: Date = {
        return Date()
    }()
    private lazy var dateFormatter: DateFormatter = {
        let df = DateFormatter()
        df.locale = Locale(identifier: "ko_KR")
        df.dateFormat = "yyyy년 M월"
        return df
    }()
    
    //API
    //메인페이지 조회 파라미터
    var monthDateString = ""
    private lazy var monthDateFormatter: DateFormatter = {
        let df = DateFormatter()
        df.locale = Locale(identifier: "ko_KR")
        df.dateFormat = "yyyy.MM"
        return df
    }()
    
    //캘린더 표시 이벤트
    var mainPageResult : [diaryMainPageResult] = []
    //혼자쓰기 일기 배열
    var nDiaryList = [String]()
    
    //코멘트 일기 배열
    var yDiaryList = [String]()

    
    
    var formatter = DateFormatter()
    //날짜 선택 변수
    var selectedDate = Date()
    
    //달력에 동그라미 그리기
    var stringEvents = [String()]
    var events = [Date()]
    var dateEvent = [Date()]
    

    //MARK: - Properties
    @IBOutlet weak var calendarView: FSCalendar!
    
    @IBOutlet weak var prevButton: UIButton!
    
    @IBOutlet weak var nextButton: UIButton!
    
    @IBOutlet weak var calendarDateLabel: UILabel!
    
    //MARK: - LifeCycle
    override func viewDidLoad() {
        super.viewDidLoad()
        
        calendarViewSetting()
        setCalendar()
        calendarView.delegate = self
        calendarView.dataSource = self
        setEvents()
        diaryMainPageAPICalled()
        formatter.dateFormat = "yyyy.MM.dd"
    }
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        calendarView.reloadData()
    }
    
    func diaryMainPageAPICalled() {
        DiaryMainPageDataManager().diaryMainDate(self)
    }
    
    func setEvents() {
        let dfMatter = DateFormatter()
        dfMatter.locale = Locale(identifier: "ko_KR")
        dfMatter.dateFormat = "yyyy.MM.dd"
        

        

    }
    
    
    func calendarViewSetting() {
        calendarView.scrollEnabled = false
        calendarView.headerHeight = 0
        calendarView.placeholderType = .none
        calendarView.weekdayHeight = 0
    }
    
    //전달 다음달 액션 함수
    func scrollCurrentPage(isPrev: Bool) {
        let calendarCurrent = Calendar.current
        var dateComponents = DateComponents()
        dateComponents.month = isPrev ? -1 : 1
        self.currentPage = calendarCurrent.date(byAdding: dateComponents, to: self.currentPage ?? self.today)
        self.calendarView.setCurrentPage(self.currentPage!, animated: true)
    }
    // 년월 label 설정
    func setCalendar() {
        calendarDateLabel.text = self.dateFormatter.string(from: calendarView.currentPage)
        monthDateString = self.monthDateFormatter.string(from: calendarView.currentPage)

    }
    
    func calendarCurrentPageDidChange(_ calendar: FSCalendar) {
        self.calendarDateLabel.text = self.dateFormatter.string(from: calendarView.currentPage)
        monthDateString = self.monthDateFormatter.string(from: calendarView.currentPage)
    }
    
    //캘린더 선택 함수
    func calendar(_ calendar: FSCalendar, didSelect date: Date, at monthPosition: FSCalendarMonthPosition) {

        print(formatter.string(from: date) + "선택된 날짜")
    }





//        let myFirstEvent = formatter.date(from: "2022.01.01")
//        let mySecondEvent = formatter.date(from: "2022.01.31")
//
//        events = [myFirstEvent!, mySecondEvent!]
    
    
//    func calendar(_ calendar: FSCalendar, appearance: FSCalendarAppearance, eventDefaultColorsFor date: Date) -> [UIColor]? {
//        let dateString = date.toString(dateFormatter: "yyyy.MM.dd")
//    }
    
    //캘린더 동그라미 갯수 함수
//    func calendar(_ calendar: FSCalendar, numberOfEventsFor date: Date) -> Int {
//        switch stringEvents.formatter.string(from: date) {
//        case "2022.03.03":
//            return 1
//        default:
//            return 0
//        }
//    }
    func calendar(_ calendar: FSCalendar, numberOfEventsFor date: Date) -> Int {
        
        for i in mainPageResult {
            if i.deliveryYn == "Y" {
                nDiaryList.append(i.date)
            }
        }
        for i in mainPageResult {
            if i.deliveryYn == "N" {
                yDiaryList.append(i.date)
            }
        }
        if nDiaryList.contains(formatter.string(from: date)) {
            return 1
        } else if yDiaryList.contains(formatter.string(from: date)) {
            return 2
        }
        return 0

    }
    
    //이벤트 dot동그라미 색상 함수
    func calendar(_ calendar: FSCalendar, appearance: FSCalendarAppearance, eventDefaultColorsFor date: Date) -> [UIColor]?{
        if self.nDiaryList.contains(formatter.string(from: date)) {
            return [UIColor.red]
        }
        if self.yDiaryList.contains(formatter.string(from: date)) {
            return [UIColor.blue]
        }
        return nil

    }
    




    
    //MARK: - Actions
    
    @IBAction func prevButtonTap(_ sender: Any) {
        scrollCurrentPage(isPrev: true)
    }
    
    @IBAction func nextButtonTap(_ sender: Any) {
        scrollCurrentPage(isPrev: false)
    }
    
    
}


    //MARK: - Extensions
extension WritingDiaryVC {
    func diaryMainDateSuccessResponse(_ response: DiaryMainPageResponse) {

        mainPageResult = response.result
        calendarView.reloadData()
    }
}
