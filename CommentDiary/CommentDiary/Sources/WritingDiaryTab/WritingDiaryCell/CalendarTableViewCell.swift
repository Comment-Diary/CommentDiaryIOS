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
    
    
    
    //MARK: - Properties
    @IBOutlet weak var calendarView: FSCalendar!
    @IBOutlet weak var calendarBackView: UIView!
    
    @IBOutlet weak var prevButton: UIButton!
    
    @IBOutlet weak var nextButton: UIButton!
    
    
    @IBOutlet weak var calendarDateLabel: UILabel!
    override func awakeFromNib() {
        
        
        super.awakeFromNib()
        // Initialization code
        calendarView.delegate = self
        calendarView.dataSource = self
        calendarSetting()
        setCalendar()
        

        
        
        prevButton.addTarget(self, action: #selector(didPrevTap(_:)), for: .touchUpInside)
        nextButton.addTarget(self, action: #selector(didNextTap(_:)), for: .touchUpInside)
    }
    
    @objc func didPrevTap(_ sender: UIButton) {
        scrollCurrentPage(isPrev: true)
    }
    @objc func didNextTap(_ sender: UIButton) {
        scrollCurrentPage(isPrev: false)
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
    
    func calendarCurrentPageDidChange(_ calendar: FSCalendar) {
        self.calendarDateLabel.text = self.dateFormatter.string(from: calendar.currentPage)
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
        calendarView.appearance.headerSeparatorColor = .red
        
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
        //헤더 높이 설정
//        calendarView.headerHeight = 60
//        calendarView.contentMode = .bottom
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

    
    
    
}

