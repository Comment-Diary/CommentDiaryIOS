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
    //선택된 날짜
    var selectedTapDate: String = ""
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
    
    lazy var krMonthDateFormatter: DateFormatter = {
        let df = DateFormatter()
        df.locale = Locale(identifier: "ko_KR")
        df.dateFormat = "MM월 dd일"
        return df
    }()
    
    lazy var krDayDateFormatter: DateFormatter = {
        let df = DateFormatter()
        df.locale = Locale(identifier: "ko_KR")
        df.dateFormat = "dd일"
        return df
    }()
    
    lazy var detailDayDateFormatter: DateFormatter = {
        let df = DateFormatter()
        df.locale = Locale(identifier: "ko_KR")
        df.dateFormat = "yyyy.MM.dd"
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
    //일기에 코멘트 여부
    var commentResponse : [CommentResponseList] = []
    
    //전체 배열
    var allDiaryList = [String]()
    
    //혼자쓰기 일기 배열
    var nDiaryList = [String]()
    
    //코멘트 일기 배열
    var yDiaryList = [String]()
    
    //코멘트 일기 썼지만 도착 x
    var yNoCommentDiaryList = [String]()
    //코멘트 일기 코멘트 도착
    var yArrivalCommentList = [String]()
    
    var nDiaryBool: Bool = false
    var yDiaryBool: Bool = false
    

    
    
    var formatter = DateFormatter()
    //날짜 선택 변수
    var selectedDate = ""
    
    //달력에 동그라미 그리기
    var stringEvents = [String()]
    var events = [Date()]
    var dateEvent = [Date()]
    

    //MARK: - Properties
    
    
    
    //일기 하단 경우 뷰
    @IBOutlet weak var notDiaryDayView: UIView!
    @IBOutlet weak var todayWritingDiaryView: UIView!
    @IBOutlet weak var aloneDiaryView: UIView!
    @IBOutlet weak var commentSoonView: UIView!
    @IBOutlet weak var readCommentView: UIView!
    @IBOutlet weak var notArrivalCommentView: UIView!
    @IBOutlet weak var preSaveView: UIView!
    
    
    
    @IBOutlet weak var calendarView: FSCalendar!
    

    
    
    //캘린더쪽
    @IBOutlet weak var calendarBackView: UIView!
    @IBOutlet weak var prevButton: UIButton!
    @IBOutlet weak var nextButton: UIButton!
    @IBOutlet weak var calendarDateLabel: UILabel!
    
    @IBOutlet weak var topLayerView: UIView!
    @IBOutlet weak var bottomLayerView: UIView!
    
    @IBOutlet weak var calendarTopView: UIView!
    
    @IBOutlet weak var calendarTopInnerView: UIView!
    
    //MARK: - LifeCycle
    override func viewDidLoad() {
        super.viewDidLoad()
        calendarView.formatter.timeZone = NSTimeZone(abbreviation: "GMT")! as TimeZone
        
        print(calendarView.today ?? Date(), "캘린더 날짜")

//        2022-03-10 12:13:06 +0000 캘린더 날짜 -24
//        2022-03-10 12:13:47 +0000 캘린더 날짜 - 7
//        2022-03-10 12:14:24 +0000 캘린더 날짜 Date()
        
        calendarViewSetting()
        setCalendar()
        calendarView.delegate = self
        calendarView.dataSource = self
        setEvents()
        diaryMainPageAPICalled()
        
        caseViewsSetting()
        viewSetting()
        
        formatter.dateFormat = "yyyy.MM.dd"
  
        
        
    }
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        let date = Date()
                var dateComponent = Calendar.current.dateComponents([.hour,.month,.year], from: date)
                dateComponent.hour! -= 24

     
        
        
        
        DiaryMainPageDataManager().diaryMainDate(self)
        calendarView.reloadData()
        
        //오늘의 일기
//        for i in mainPageResult {
//            if i.date == formatter.string(from: Date()) {
//                print(i.content, "오늘의 일기")
//                print(i.title, "오늘의 일기 제목")
//            }
//        }

//        for i in mainPageResult {
//            if i.date == String(formatter.string(from: today)) {
//                titleLabel.text = i.title
//                print(i.title , "오늘 일기 제목")
//                contentLabel.text = i.content
//                print(i.content, "오늘 일기 내용")
//            }
//        }
    }
    

    func viewSetting() {
        view.backgroundColor = UIColor(hex: 0xF4EDE3)
        calendarBackView.backgroundColor = UIColor(hex: 0xFDFCF9)
        calendarBackView.layer.borderWidth = 4
        calendarBackView.layer.maskedCorners = [.layerMinXMinYCorner, .layerMaxXMinYCorner]
        calendarBackView.layer.cornerRadius = 60
        calendarBackView.layer.borderColor = UIColor(hex: 0x73BF90).cgColor
        topLayerView.backgroundColor = UIColor(hex: 0xE2DFD7)
        bottomLayerView.backgroundColor = UIColor(hex: 0xE2DFD7)
    }
    
    func caseViewsSetting() {
        notDiaryDayView.isHidden = true
        todayWritingDiaryView.isHidden = false
        aloneDiaryView.isHidden = true
        commentSoonView.isHidden = true
        readCommentView.isHidden = true
        notArrivalCommentView.isHidden = true
        preSaveView.isHidden = true
        calendarTopView.layer.cornerRadius = 60
        calendarTopInnerView.layer.cornerRadius = 60
    }
    
    func diaryMainPageAPICalled() {
//        DiaryMainPageDataManager().diaryMainDate(self)
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


        formatter.dateFormat = "yyyy.MM.dd"
        
        selectedDate = formatter.string(from: date)
        //tableviewCell에 데이트값 보내주기
        print(selectedDate, "선택된 날짜")
        
        NotificationCenter.default.post(name: NSNotification.Name(rawValue: "SelectedDate"), object: krMonthDateFormatter.string(from: date))
        NotificationCenter.default.post(name: NSNotification.Name(rawValue: "SelectedDayDate"), object: krDayDateFormatter.string(from: date))
        NotificationCenter.default.post(name: NSNotification.Name(rawValue: "Date"), object: krDayDateFormatter.string(from: date)) // ??
        
        NotificationCenter.default.post(name: NSNotification.Name(rawValue: "presentDate"), object: formatter.string(from: date)) 
        


        for i in nDiaryList {
            if i == String(formatter.string(from: date)) {
                nDiaryBool = true
                self.notDiaryDayView.isHidden = true
                self.todayWritingDiaryView.isHidden = true
                self.aloneDiaryView.isHidden = false
                self.commentSoonView.isHidden = true
                self.readCommentView.isHidden = true
                self.notDiaryDayView.isHidden = true
                self.preSaveView.isHidden = true
            }
//            else {
//                nDiaryBool = false
//            }
        }
        
        for i in yDiaryList {
            if i == String(formatter.string(from: date)) {
                yDiaryBool = true
                self.notDiaryDayView.isHidden = true
                self.todayWritingDiaryView.isHidden = true
                self.aloneDiaryView.isHidden = true
                self.commentSoonView.isHidden = false
                self.readCommentView.isHidden = true
                self.notDiaryDayView.isHidden = true
                self.preSaveView.isHidden = true
            }
//            else {
//                yDiaryBool = false
//            }
        }
        
        for i in allDiaryList {
            if i != String(formatter.string(from: date)) {
                self.notDiaryDayView.isHidden = true
                self.todayWritingDiaryView.isHidden = false
                self.aloneDiaryView.isHidden = true
                self.commentSoonView.isHidden = true
                self.readCommentView.isHidden = true
                self.notDiaryDayView.isHidden = true
                self.preSaveView.isHidden = true
            }
        }
        

        
//        if yDiaryBool == false && nDiaryBool == false {
//            self.notDiaryDayView.isHidden = true
//            self.todayWritingDiaryView.isHidden = false
//            self.aloneDiaryView.isHidden = true
//            self.commentSoonView.isHidden = true
//            self.readCommentView.isHidden = true
//            self.notDiaryDayView.isHidden = true
//            self.preSaveView.isHidden = true
//        }
//

        for i in mainPageResult {
            if i.date == String(formatter.string(from: date)) {
                print(i.id, "일기 ID")
                NotificationCenter.default.post(name: Notification.Name("SelectedID"), object: i.id)
                print(i.title, "일기 제목")
                NotificationCenter.default.post(name: Notification.Name("SelectedTitle"), object: i.title)
                print(i.content, "일기 내용")
                NotificationCenter.default.post(name: Notification.Name("SelectedContent"), object: i.content)
            }
        }
        
        //calendarview reload
        calendarView.reloadData()
        
        
//        for i in mainPageResult {
//            if i.date == String(formatter.string(from: date)) {
//                print(i.title, "일기 제목")
//                titleLabel.text = i.title
//                print(i.content, "일기 내용")
//                contentLabel.text = i.content
//            }
//        }
    }





//        let myFirstEvent = formatter.date(from: "2022.01.01")
//        let mySecondEvent = formatter.date(from: "2022.01.31")
//
//        events = [myFirstEvent!, mySecondEvent!]
    
    
//    func calendar(_ calendar: FSCalendar, appearance: FSCalendarAppearance, eventDefaultColorsFor date: Date) -> [UIColor]? {
//        let dateString = date.toString(dateFormatter: "yyyy.MM.dd")
//    }
    

    func calendar(_ calendar: FSCalendar, numberOfEventsFor date: Date) -> Int {
        

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
    func calendar(_ calendar: FSCalendar, appearance: FSCalendarAppearance, eventSelectionColorsFor date: Date) -> [UIColor]? {
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
        DiaryMainPageDataManager().diaryMainDate(self)
        
    }
    
    @IBAction func nextButtonTap(_ sender: Any) {
        scrollCurrentPage(isPrev: false)
        DiaryMainPageDataManager().diaryMainDate(self)
    }
    
    
}



//
//    @objc func loadData(_ notification : NSNotification) {
//       selectedTapDate = notification.object as? String ?? ""
//        print(selectedTapDate, "selectedTapDate")
//        print(notification.object as? String ?? "" , "notification")
//    }
//
//    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
//        NotificationCenter.default.addObserver(self, selector: #selector(loadData(_:)), name: NSNotification.Name(rawValue: "SelectedDate"), object: nil)
//
//
//
//        if indexPath.section == 0 {
//            for i in mainPageResult {
//                if i.date != selectedTapDate { //일기를 쓰지 않았다면 + 일기를 안쓰고 임시저장 (해야됌)
//                    print(selectedTapDate, "셀의 날짜 데이터")
//                    let cell = tableView.dequeueReusableCell(withIdentifier: "WritingDiaryTableViewCell", for: indexPath) as! WritingDiaryTableViewCell
//                    cell.selectionStyle = UITableViewCell.SelectionStyle.none
//                    let writingTableViewCell = cell
//                    writingTableViewCell.diaryWriteButton.addTarget(self, action: #selector(TapWritingTableViewCell(_:)), for: .touchUpInside)
//
//                    let dateformatter = DateFormatter()
//                    dateformatter.dateFormat = "yyyy.MM.dd"
//                    selectedTapDate = dateformatter.string(from: Date())
//                    writingTableViewCell.diaryDateLabel.text = dateformatter.string(from: Date())
//                    return cell
//                }
//                else if i.date == selectedTapDate { //일기를 썼다면
//                    if i.deliveryYn == "Y" { //코멘트 일기를 썼다면
//
//                    } else if i.deliveryYn == "N" { //혼자보기 일기를 썼다면
//                        let cell = tableView.dequeueReusableCell(withIdentifier: "NWritedDiaryTableViewCell", for: indexPath) as! NWritedDiaryTableViewCell
//                        cell.selectionStyle = UITableViewCell.SelectionStyle.none
//                        let writingTableViewCell = cell
//                        return cell
//                    }
//
//                }
//            }
//
//
//        }


extension WritingDiaryVC {
    func diaryMainDateSuccessResponse(_ response: DiaryMainPageResponse) {

        mainPageResult = response.result
        
        calendarView.reloadData()
        

        //전체 배열
        for i in mainPageResult {
            allDiaryList.append(i.date)
        }
        
        

        for i in mainPageResult {
            if i.deliveryYn == "N" {
                nDiaryList.append(i.date)
            }
            else if i.deliveryYn == "Y" {
                yDiaryList.append(i.date)
            }
        }
        
//        for i in mainPageResult {
//            if i.deliveryYn == "Y" {
//                yDiaryList.append(i.date)
//            }
//        }
        
        
        
        
        
        
        
        
        
        for i in mainPageResult {
            if (i.commentResponseList.count != 0) && i.deliveryYn == "Y" {
                
            }
            else if (i.commentResponseList.count == 0) && i.deliveryYn == "Y" {
                
            }
        }

        
    }
}
