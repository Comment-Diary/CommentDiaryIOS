//
//  CalendarTableViewCell.swift
//  CommentDiary
//
//  Created by 류창휘 on 2022/02/19.
//

import UIKit
import FSCalendar

protocol selectDateDelegate : AnyObject {
    func dateString(TapDate: String)
}


class CalendarTableViewCell: UITableViewCell, FSCalendarDataSource, FSCalendarDelegate {
    //Delegate
    var delegate: selectDateDelegate?
    var selectedDate = ""
    var formatter = DateFormatter()
    
    
    
    
    //캘린더 표시 이벤트
    var mainPageResult : [diaryMainPageResult] = []
    var events = [Date()]
    lazy var diaryMainResult: [String] = []
    
    //혼자 쓴 일기 동그라미 배열
    var nDiary = [String]()
    var nDiaryDate = [Date]() {
        didSet {
            print("nDiaryDate !!!\(nDiaryDate)")
        }
    }
    //코멘트 일기 동그라미 배열
    var yDiary = [String]()
    var yDiaryDate = [Date]()
    
    
    //일기 메인 페이지 조회 API
//    let nowDate = Date()
//    var nowFormatter = DateFormatter()
    var apiDateString = ""
    
  
    
    
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
    
    lazy var apiDateFormatter: DateFormatter = {
        let df = DateFormatter()
        df.locale = Locale(identifier: "ko_KR")
        df.dateFormat = "yyyy.MM"
        return df
    }()
    
    private lazy var dfMatter : DateFormatter = {
        let formatter = DateFormatter()
        formatter.locale = Locale(identifier: "ko_KR")
        formatter.dateFormat = "yyyy.MM.dd"
        return formatter
    }()
    
    

    //MARK: - Properties
    @IBOutlet weak var calendarView: FSCalendar!
    @IBOutlet weak var calendarBackView: UIView!
    @IBOutlet weak var prevButton: UIButton!
    @IBOutlet weak var nextButton: UIButton!
    @IBOutlet weak var calendarDateLabel: UILabel!
    override func awakeFromNib() {
        super.awakeFromNib()
        //API
        // Initialization code
        calendarView.delegate = self
        calendarView.dataSource = self
        calendarSetting()
        setCalendar()
        apiSetCalendar()
        setEvents()
        
        
        
//        nowFormatter.dateFormat = "yyyy.MM"
//        apiDateString = nowFormatter.string(from: nowDate)
//        NotificationCenter.default.addObserver(self, selector: #selector(reloadCalendar), name: Notification.Name("reloadCalendar"), object: nil)
        
        
        prevButton.addTarget(self, action: #selector(didPrevTap(_:)), for: .touchUpInside)
        nextButton.addTarget(self, action: #selector(didNextTap(_:)), for: .touchUpInside)
        
    }
    
//    @objc func reloadCalendar() {
//        calendarView.reloadData()
//    }
    
    @objc func didPrevTap(_ sender: UIButton) {
        scrollCurrentPage(isPrev: true)
//        DiaryMainPageDataManager().diaryMainData(self)

    }
    @objc func didNextTap(_ sender: UIButton) {
        scrollCurrentPage(isPrev: false)
//        DiaryMainPageDataManager().diaryMainData(self)

    }

    
    func scrollCurrentPage(isPrev: Bool) {
        let calendarCurrent = Calendar.current
        var dateComponents = DateComponents()
        dateComponents.month = isPrev ? -1 : 1
        self.currentPage = calendarCurrent.date(byAdding: dateComponents, to: self.currentPage ?? self.today)
        self.calendarView.setCurrentPage(self.currentPage!, animated: true)
    }
    
    func setCalendar() {
        calendarDateLabel.text = self.dateFormatter.string(from: calendarView.currentPage)

    }
    
    func apiSetCalendar() {
        apiDateString = self.apiDateFormatter.string(from: calendarView.currentPage)

    }
    
    func calendarCurrentPageDidChange(_ calendar: FSCalendar) {
        self.calendarDateLabel.text = self.dateFormatter.string(from: calendar.currentPage)
        self.apiDateString = self.apiDateFormatter.string(from: calendar.currentPage)
        
    }
    
    
    func calendarSetting() {
        calendarBackView.layer.borderWidth = 4
        calendarBackView.layer.borderColor = UIColor.greenColor.cgColor
        calendarBackView.backgroundColor = UIColor(hex: 0xFDFDF9)
        calendarBackView.layer.maskedCorners = [.layerMinXMinYCorner, .layerMaxXMinYCorner]
        calendarBackView.layer.cornerRadius = 40

        
        calendarView.backgroundColor = UIColor(hex: 0xFDFDF9)
//        calendarView.backgroundColor = .red
        
        
//        myView.layer.borderColor = UIColor.green.cgColor
//             myView.layer.borderWidth = 10
//             myView.layer.cornerRadius = 40
//             myView.layer.maskedCorners = [.layerMaxXMaxYCorner, .layerMinXMaxYCorner]
//        calendarView.layer.borderWidth = 4
//        calendarView.layer.borderColor = UIColor.greenColor.cgColor
//        calendarView.backgroundColor = UIColor(hex: 0xFDFDF9)
//        calendarView.appearance.headerMinimumDissolvedAlpha = 0.0
//        calendarView.appearance.separators = .interRows.self

        calendarView.appearance.eventDefaultColor = .red
        
//        calendarView.appearance.headerSeparatorColor  = .green
        calendarView.appearance.titleFont = UIFont(name: "NotoSansKR-Medium", size: 15)

        //스크롤 가능 여부
        calendarView.scrollEnabled = false
        //헤더 폰트 설정
//        calendarView.appearance.headerTitleFont = UIFont(name: "NotoSansKR-Medium", size: 40)
        //헤더의 날짜 포맷 설정
        calendarView.appearance.headerDateFormat = ""
        //헤더의 폰트 색상 설정
        calendarView.appearance.headerTitleColor = UIColor(hex: 0x4E4C49)

        calendarView.appearance.headerTitleFont = UIFont.systemFont(ofSize: 20, weight: .bold)
        calendarView.appearance.weekdayFont = UIFont.systemFont(ofSize: 14, weight: .medium)
        calendarView.appearance.weekdayTextColor = UIColor(hex: 0x4E4C49)
        
        calendarView.placeholderType = .none
    }
    


    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }


    
    
    func calendar(_ calendar: FSCalendar, didSelect date: Date, at monthPosition: FSCalendarMonthPosition) {
        formatter.dateFormat = "yyyy.MM.dd"
        selectedDate = formatter.string(from: date)        
        delegate?.dateString(TapDate: selectedDate)
        
        NotificationCenter.default.post(name: NSNotification.Name(rawValue: "SelectedDate"), object: formatter.string(from: date))
        
    }
    
    func maximumDate(for calendar: FSCalendar) -> Date { 
        return Date()
        
    }

    
    func setEvents() {
        let dfMatter = DateFormatter()
        dfMatter.locale = Locale(identifier: "ko_KR")
        dfMatter.dateFormat = "yyyy.MM.dd"
        
        // events
//        let myFirstEvent = dfMatter.date(from: "2022-03-04")
//        let mySecondEvent = dfMatter.date(from: "2022-03-03")
//        let writedDate = dfMatter.date(from: diaryMainResult[IndexPath])
//
//        events = dfMatter.date(from: diaryMainPageResult.)
//        let myFirstEvent = dfMatter.date(from: "2022-02-01")
//        let mySecondEvent = dfMatter.date(from: "2022-02-31")
          
//          events = [myFirstEvent!]
        
        for nDate in nDiary {
            let nDateObject = dfMatter.date(from: nDate)
            nDiaryDate.append(nDateObject!)
            
        }
        
        for yDate in yDiary {
            let yDateObject = dfMatter.date(from: yDate)
            yDiaryDate.append(yDateObject!)
        }

    }
    
    func update(date: String, type: String) {
        if type == "Y" {
            let formattedDate = self.dfMatter.date(from: date)
            print("formattedDate !!! \(formattedDate)")
            self.yDiaryDate.append(formattedDate ?? Date())
        } else if type == "N"{
            let formattedDate = self.dfMatter.date(from: date)
            self.nDiaryDate.append(formattedDate ?? Date())
        }
        
    }
    
    func calendar(_ calendar: FSCalendar, numberOfEventsFor date: Date) -> Int {
        if self.nDiaryDate.contains(date) {
//            calendarView.appearance.eventSelectionColor = .red
            return 1
        } else if self.yDiaryDate.contains(date) {
            return 1
        } else {
            return 0
        }
    }
    
    

    
}


