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
    
    //오늘 데이터 **
    var todayTitle = ""
    var todayContent = ""
    var todayDiaryId = 0
    var mainPageState = ""
    
    
    
    
    //선택된 날짜
    var selectedTapDate: String = ""
    //달력 년월 표시
    private var currentPage: Date?
    lazy var today: Date = {
        return Date(timeIntervalSinceNow: -25200)
    }()
//    private var currentPage: Date?
//    lazy var today: Date = {
//        return Date()
//    }()
    
    
    
    private lazy var dateFormatter: DateFormatter = {
        let df = DateFormatter()
//        let now = Date(timeIntervalSinceNow:  -25200)
//        df.locale = Locale(identifier: Locale.current.identifier)
        df.dateFormat = "yyyy년 M월"
        return df
    }()
    
    lazy var krMonthDateFormatter: DateFormatter = {
        let df = DateFormatter()
//        df.locale = Locale(identifier: "ko_KR")
        df.dateFormat = "MM월 dd일"
        return df
    }()
    
    lazy var krDayDateFormatter: DateFormatter = {
        let df = DateFormatter()
//        df.locale = Locale(identifier: "ko_KR")
        df.dateFormat = "dd일"
        return df
    }()
    
    lazy var detailDayDateFormatter: DateFormatter = {
        let df = DateFormatter()
//        df.locale = Locale(identifier: "ko_KR")
//        df.timeZone = TimeZone(identifier: "UTC")
        df.dateFormat = "yyyy.MM.dd"
        return df
    }()
    
    
    
    
    
    //
    
    
    ///
    
    //API
    //메인페이지 조회 파라미터
    var monthDateString = ""
    private lazy var monthDateFormatter: DateFormatter = {
        let df = DateFormatter()
//        df.locale = Locale(identifier: "ko_KR")
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
    
    //코멘트 일기 코멘트 x
    var yDiaryNoCommentList = [String]()
    //코멘트 일기 코멘트 o
    var yDiaryCommentList = [String]()
    
    //코멘트 일기 썼지만 도착 x
    var yNoCommentDiaryList = [String]()
    //코멘트 일기 코멘트 도착
    var yArrivalCommentList = [String]()
    
    
    
    //MARK: - Array
    
    //3.14 수정 반영
    
    //임시저장 상태 string
    var compareString = ""
    
    //임시저장 배열
    var tempYArray = [String]()
    //임시저장 기간 지난 배열
    var tempYDeadlineArray = [String]()
    
    //혼자 쓴 일기 배열
    var deliveryNArray = [String]()
    
    //코멘트 도착
    var commentArrivalArray = [String]()
    
    //코멘트 도착 x
    //코멘트 곧 도착 or 결국 x 해야함
    var commentNoArrivalArray = [String]()
    
    var commentSoonArray = [String]()
    
    
    
    
    
    var nDiaryBool: Bool = false
    var yDiaryBool: Bool = false
    

    
    
    var formatter = DateFormatter()
    //날짜 선택 변수
    var selectedDate = ""
    

    //MARK: - Properties
    
    
    
    //일기 하단 경우 뷰
    @IBOutlet weak var notDiaryDayView: UIView!
    @IBOutlet weak var todayWritingDiaryView: UIView!
    @IBOutlet weak var aloneDiaryView: UIView!
    @IBOutlet weak var commentSoonView: UIView!
    @IBOutlet weak var readCommentView: UIView!
    @IBOutlet weak var notArrivalCommentView: UIView!
    @IBOutlet weak var preSaveView: UIView!
    @IBOutlet weak var caseView: UIView!
    @IBOutlet weak var deadlinePreSaveView: UIView!
    
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
    
    
    @IBOutlet weak var sundayLabel: UILabel!
    
    @IBOutlet weak var monLabel: UILabel!
    
    @IBOutlet weak var tueLabel: UILabel!
    
    @IBOutlet weak var wedlabel: UILabel!
    
    @IBOutlet weak var thurLabel: UILabel!
    
    @IBOutlet weak var friLabel: UILabel!
    
    @IBOutlet weak var satLabel: UILabel!
    //MARK: - LifeCycle
    override func viewDidLoad() {
        super.viewDidLoad()
        //초기화

        
        
        calendarView.locale = Locale(identifier: Locale.current.identifier)
//        calendarView.today = Date(timeIntervalSinceNow: -25200)
        calendarView.today = Date(timeIntervalSinceNow: -25200)
        
        
        calendarViewSetting()
        setCalendar()
        calendarView.delegate = self
        calendarView.dataSource = self
        setEvents()
        diaryMainPageAPICalled()
        
        caseViewsSetting()
        viewSetting()
        
        formatter.dateFormat = "yyyy.MM.dd"
        
        //???
        
        
        
        
        
        //view radius
        caseView.layer.masksToBounds = true
        caseView.layer.cornerRadius = 10
        
        
  
        
        
    }
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        //배열 초기화
        tempYArray = []
        tempYDeadlineArray = []
        allDiaryList = []
        nDiaryList = []
        yDiaryList = []
        yDiaryCommentList = []
        yDiaryNoCommentList = []
        deliveryNArray = []
        commentNoArrivalArray = []
        commentArrivalArray = []
        commentSoonArray = []
        
        
        

        
        DiaryMainPageDataManager().diaryMainDate(self)
        calendarView.reloadData()
        
        
        

       
        
        
        //미래 날짜 화면 부르기
        NotificationCenter.default.addObserver(self, selector: #selector(compareDate(_:)), name: NSNotification.Name(rawValue: "compareDate"), object: nil)
        
        
        


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
//        notDiaryDayView.isHidden = true
//        todayWritingDiaryView.isHidden = false
//        aloneDiaryView.isHidden = true
//        commentSoonView.isHidden = true
//        readCommentView.isHidden = true
//        notArrivalCommentView.isHidden = true
//        preSaveView.isHidden = true
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
        
        calendarView.appearance.selectionColor = UIColor(hex: 0xFFAC86)
        calendarView.appearance.todayColor = UIColor(hex: 0xFFAC86)
        calendarView.allowsSelection = true
        calendarView.allowsMultipleSelection = false
        
//        calendarView.appearance.titleFont = UIFont.AppleSDGothic(.bold, size: 14)
        sundayLabel.textColor = UIColor(hex: 0x4E4C49)
        monLabel.textColor = UIColor(hex: 0x4E4C49)
        tueLabel.textColor = UIColor(hex: 0x4E4C49)
        wedlabel.textColor = UIColor(hex: 0x4E4C49)
        thurLabel.textColor = UIColor(hex: 0x4E4C49)
        friLabel.textColor = UIColor(hex: 0x4E4C49)
        satLabel.textColor = UIColor(hex: 0x4E4C49)
        
        sundayLabel.font = UIFont.AppleSDGothic(.bold, size: 12)
        monLabel.font = UIFont.AppleSDGothic(.bold, size: 12)
        tueLabel.font = UIFont.AppleSDGothic(.bold, size: 12)
        wedlabel.font = UIFont.AppleSDGothic(.bold, size: 12)
        thurLabel.font = UIFont.AppleSDGothic(.bold, size: 12)
        friLabel.font = UIFont.AppleSDGothic(.bold, size: 12)
        satLabel.font = UIFont.AppleSDGothic(.bold, size: 12)
        
        calendarDateLabel.textColor = UIColor(hex: 0x4E4C49)
        calendarDateLabel.font = UIFont.AppleSDGothic(.extraBold, size: 20)
        
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
        
        NotificationCenter.default.post(name: NSNotification.Name(rawValue: "SelectedDate"), object: krMonthDateFormatter.string(from: date))
        NotificationCenter.default.post(name: NSNotification.Name(rawValue: "SelectedDayDate"), object: krDayDateFormatter.string(from: date))
        NotificationCenter.default.post(name: NSNotification.Name(rawValue: "Date"), object: krDayDateFormatter.string(from: date)) // ??
        
        NotificationCenter.default.post(name: NSNotification.Name(rawValue: "presentDate"), object: formatter.string(from: date))
        
        
        //MARK: - 3.14
        
        let todayDateString = detailDayDateFormatter.string(from: Date(timeIntervalSinceNow: -25200))

        
        let todayDateValue = detailDayDateFormatter.date(from: todayDateString)
        
        let selectedDateString = detailDayDateFormatter.string(from: date)
        
        let selectedDateValue = detailDayDateFormatter.date(from: selectedDateString)
        //날짜 비교 메서드
        todayDateValue!.dateCompare(fromDate: selectedDateValue!)
                
        
        print(compareString, "비교 날짜 상태")
        

        
        
        //오늘 일기쓸 날이 아님
        if compareString == "미래" {
            self.notDiaryDayView.isHidden = false
            self.todayWritingDiaryView.isHidden = true
            self.aloneDiaryView.isHidden = true
            self.commentSoonView.isHidden = true
            self.readCommentView.isHidden = true
            self.notArrivalCommentView.isHidden = true
            self.preSaveView.isHidden = true
            self.deadlinePreSaveView.isHidden = true
        }
        

        
        for i in allDiaryList {
            if i != String(formatter.string(from: date)) && compareString != "미래" {
                self.notDiaryDayView.isHidden = true
                self.todayWritingDiaryView.isHidden = false
                self.aloneDiaryView.isHidden = true
                self.commentSoonView.isHidden = true
                self.readCommentView.isHidden = true
                self.notArrivalCommentView.isHidden = true
                self.preSaveView.isHidden = true
                self.deadlinePreSaveView.isHidden = true
                
                
            }
        }
        
        
            //일기를 쓸 수 있는 날
            
            //임시저장
            for i in tempYArray {
                if i == String(formatter.string(from: date)) {
                    self.notDiaryDayView.isHidden = true
                    self.todayWritingDiaryView.isHidden = true
                    self.aloneDiaryView.isHidden = true
                    self.commentSoonView.isHidden = true
                    self.readCommentView.isHidden = true
                    self.notArrivalCommentView.isHidden = true
                    self.preSaveView.isHidden = false
                    self.deadlinePreSaveView.isHidden = true
                }
            }
        for i in tempYDeadlineArray {
            if i == String(formatter.string(from: date)) {
                self.notDiaryDayView.isHidden = true
                self.todayWritingDiaryView.isHidden = true
                self.aloneDiaryView.isHidden = true
                self.commentSoonView.isHidden = true
                self.readCommentView.isHidden = true
                self.notArrivalCommentView.isHidden = true
                self.preSaveView.isHidden = true
                self.deadlinePreSaveView.isHidden = false
            }
        }
        
        
            
            //혼자 쓴 일기
            for i in deliveryNArray {
                if i == String(formatter.string(from: date)) {
                    self.notDiaryDayView.isHidden = true
                    self.todayWritingDiaryView.isHidden = true
                    self.aloneDiaryView.isHidden = false
                    self.commentSoonView.isHidden = true
                    self.readCommentView.isHidden = true
                    self.notArrivalCommentView.isHidden = true
                    self.preSaveView.isHidden = true
                    self.deadlinePreSaveView.isHidden = true
                }
            }
            //코멘트 일기, 일기 도착 x, 곧 도착
            for i in commentSoonArray {
                if i == String(formatter.string(from: date)) {
                    self.notDiaryDayView.isHidden = true
                    self.todayWritingDiaryView.isHidden = true
                    self.aloneDiaryView.isHidden = true
                    self.commentSoonView.isHidden = false
                    self.readCommentView.isHidden = true
                    self.notArrivalCommentView.isHidden = true
                    self.preSaveView.isHidden = true
                    self.deadlinePreSaveView.isHidden = true
                }
            }
        
        //코멘트 일기, 결국 도착 x
        for i in commentNoArrivalArray {
            if i == String(formatter.string(from: date)) {
                self.notDiaryDayView.isHidden = true
                self.todayWritingDiaryView.isHidden = true
                self.aloneDiaryView.isHidden = true
                self.commentSoonView.isHidden = true
                self.readCommentView.isHidden = true
                self.notArrivalCommentView.isHidden = false
                self.preSaveView.isHidden = true
                self.deadlinePreSaveView.isHidden = true
            }
        }
        
        
        //todo 일기 결국 도착 x
        //notArrivalCommentView
        //아이디어 2틀이상 차이나면 바꿔주기
        
        
            
            //코멘트 일기, 일기 도착 o
        for i in commentArrivalArray {
            if i == String(formatter.string(from: date)) {
                self.notDiaryDayView.isHidden = true
                self.todayWritingDiaryView.isHidden = true
                self.aloneDiaryView.isHidden = true
                self.commentSoonView.isHidden = true
                self.readCommentView.isHidden = false
                self.notArrivalCommentView.isHidden = true
                self.preSaveView.isHidden = true
                self.deadlinePreSaveView.isHidden = true
            }
        }
        
        
        
        
        


        //MARK: -
//       self.preSaveView.isHidden = true
   
        
  

        for i in mainPageResult {
            if i.date == String(formatter.string(from: date)) {
                print(i.id, "일기 ID")
                NotificationCenter.default.post(name: Notification.Name("SelectedID"), object: i.id)
                print(i.title, "일기 제목")
                NotificationCenter.default.post(name: Notification.Name("SelectedTitle"), object: i.title)
                print(i.content, "일기 내용")
                NotificationCenter.default.post(name: Notification.Name("SelectedContent"), object: i.content)
                print(i.date, "일기 날짜")
            }
        }

        
        

    }





    

    func calendar(_ calendar: FSCalendar, numberOfEventsFor date: Date) -> Int {
        

        if nDiaryList.contains(formatter.string(from: date)) {
            return 1
        } else if yDiaryList.contains(formatter.string(from: date)) {
            return 1
        }
        return 0

    }
    
    
    //이벤트 dot동그라미 색상 함수
    func calendar(_ calendar: FSCalendar, appearance: FSCalendarAppearance, eventDefaultColorsFor date: Date) -> [UIColor]?{
        if self.nDiaryList.contains(formatter.string(from: date)) {
            return [UIColor(hex: 0xFFAC86)]
        }
        if self.yDiaryList.contains(formatter.string(from: date)) {
            return [UIColor(hex: 0x73BF90)]
        }
        return nil

    }
    func calendar(_ calendar: FSCalendar, appearance: FSCalendarAppearance, eventSelectionColorsFor date: Date) -> [UIColor]? {
        if self.nDiaryList.contains(formatter.string(from: date)) {
            return [UIColor(hex: 0xFFAC86)]
        }
        if self.yDiaryList.contains(formatter.string(from: date)) {
            return [UIColor(hex: 0x73BF90)]
        }
        return nil
    }
    
    




    
    @objc func compareDate(_ notification: NSNotification) {
        compareString = notification.object as? String ?? ""
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
        

        
        
        for i in mainPageResult {
            if (i.commentResponseList.count != 0) && i.deliveryYn == "Y" {
                yDiaryCommentList.append(i.date)
            }
            else if (i.commentResponseList.count == 0) && i.deliveryYn == "Y" {
                yDiaryNoCommentList.append(i.date)
            }
        }
        
        
        
        

        let todayDateData = detailDayDateFormatter.string(from: Date(timeIntervalSinceNow: -25200))
        print(todayDateData, "-------------------------")
        for i in mainPageResult {
            //??
            if todayDateData == i.date {
                todayTitle = i.title
                NotificationCenter.default.post(name: Notification.Name("loadDate"), object: krMonthDateFormatter)
                
                print(todayTitle, "로드된 시점 제목")
                NotificationCenter.default.post(name: Notification.Name("loadTitle"), object: todayTitle)
                
                todayContent = i.content
                print(todayContent, "로드된 시점 내용")
                NotificationCenter.default.post(name: Notification.Name("loadContent"), object: todayContent)
                todayDiaryId = i.id
                print(todayDiaryId, "로드된 시점 ID값")
                NotificationCenter.default.post(name: Notification.Name("loadID"), object: todayDiaryId)
            }
            
            
            
            let preSaveDateString = detailDayDateFormatter.string(from: Date(timeIntervalSinceNow: -25200))
            let prepareDate = formatter.date(from: preSaveDateString)

            
            
            // tempYn = "Y" 임시저장
            // tempYn = "N" 임시저장 x
            if i.tempYn == "Y" {
                //임시저장 배열
                //임시저장 마감
                //오전 7시에 마감 7시간을 빼서 같으면 아직 임시저장 다르면 마감
                //임시저장 7시간빼기

                if i.date == preSaveDateString {
                    tempYArray.append(i.date)
                    print(tempYArray, "임시저장 배열")
                }
                else if i.date != preSaveDateString {
                    //임시저장 마감
                    tempYDeadlineArray.append(i.date)
                    print(tempYDeadlineArray, "임시저장 마감 배열")
                }
                
            }
            else if  i.tempYn == "N" {
                //임시저장 아닌 경우
                
                //혼자 쓴 일기
                if i.deliveryYn == "N" {
                    deliveryNArray.append(i.date)
                }
                //코멘트 받는 일기를 씀
                else if i.deliveryYn == "Y" {
                    //코멘트가 안온 경우
                    //기다리세요 or 코멘트 x
                    if i.commentCnt == 0 {
//                        commentNoArrivalArray.append(i.date)
                        //날짜 비교 *******
                        let arrayDate = formatter.date(from: i.date)!
                        let interval = prepareDate!.timeIntervalSince(arrayDate)
                        let days = Int(interval / 86400)
                        if days >= 2 {
                            commentNoArrivalArray.append(i.date)
                            print(commentNoArrivalArray, "코멘트 결국 오지 않음")
                        }
                        else if days < 2 {
                            commentSoonArray.append(i.date)
                            print(commentSoonArray, "코멘트 곧 도착")
                        }
                        
                        
                    }
                    
                    //코멘트가 온 경우
                    else if i.commentCnt != 0 {
                        commentArrivalArray.append(i.date)
                    }
                }
            }
        }
        
        
//
//        //오늘 날짜에 맞는 화면 넣어주기
        let todayDateValueString = detailDayDateFormatter.string(from: Date(timeIntervalSinceNow: -25200))


        for i in allDiaryList {
           if i != todayDateValueString { //일기 쓰기
                self.notDiaryDayView.isHidden = true
                self.todayWritingDiaryView.isHidden = false
                self.aloneDiaryView.isHidden = true
                self.commentSoonView.isHidden = true
                self.readCommentView.isHidden = true
                self.notArrivalCommentView.isHidden = true
                self.preSaveView.isHidden = true
               self.deadlinePreSaveView.isHidden = true
            }
            else if i == todayDateValueString {
                for j in tempYArray {
                    if j == todayDateValueString { //임시저장
                        self.notDiaryDayView.isHidden = true
                        self.todayWritingDiaryView.isHidden = true
                        self.aloneDiaryView.isHidden = true
                        self.commentSoonView.isHidden = true
                        self.readCommentView.isHidden = true
                        self.notArrivalCommentView.isHidden = true
                        self.preSaveView.isHidden = false
                        self.deadlinePreSaveView.isHidden = true
                    }
                }
                
                //*****************MARK: - 수정해야하는지 확인
                //임시저장 기간 지난 배열
                for j in tempYDeadlineArray {
                    if j == todayDateValueString { //임시저장
                        self.notDiaryDayView.isHidden = true
                        self.todayWritingDiaryView.isHidden = true
                        self.aloneDiaryView.isHidden = true
                        self.commentSoonView.isHidden = true
                        self.readCommentView.isHidden = true
                        self.notArrivalCommentView.isHidden = true
                        self.preSaveView.isHidden = true
                        self.deadlinePreSaveView.isHidden = false
                    }
                }
                
                
                for k in deliveryNArray {
                    if k == todayDateValueString { //혼자쓴일기
                        self.notDiaryDayView.isHidden = true
                        self.todayWritingDiaryView.isHidden = true
                        self.aloneDiaryView.isHidden = false
                        self.commentSoonView.isHidden = true
                        self.readCommentView.isHidden = true
                        self.notArrivalCommentView.isHidden = true
                        self.preSaveView.isHidden = true
                        self.deadlinePreSaveView.isHidden = true
                    }
                }

                for q in commentSoonArray {
                    if q == todayDateValueString { //코멘트일기
                        self.notDiaryDayView.isHidden = true
                        self.todayWritingDiaryView.isHidden = true
                        self.aloneDiaryView.isHidden = true
                        self.commentSoonView.isHidden = false
                        self.readCommentView.isHidden = true
                        self.notArrivalCommentView.isHidden = true
                        self.preSaveView.isHidden = true
                        self.deadlinePreSaveView.isHidden = true
                    }
                }
            }
        }

    }
}






