//
//  WritingDiaryViewController.swift
//  CommentDiary
//
//  Created by 류창휘 on 2022/02/17.
//

import Foundation
import UIKit

class WritingDiaryViewController: UIViewController {
    //MARK: - Properties
    @IBOutlet weak var writingDiaryTableView: UITableView!
    
    //MARK: - LifeCycle
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = UIColor.mainBackgroundColor
        
        
        writingDiaryTableView.delegate = self
        writingDiaryTableView.dataSource = self
        
        cellsRegister()
        
        
    }
    
    func cellsRegister() {
        let calendarCell = UINib(nibName: "CalendarTableViewCell", bundle: nil)
        writingDiaryTableView.register(calendarCell, forCellReuseIdentifier: "CalendarTableViewCell")
        let writingDiaryCell = UINib(nibName: "WritingDiaryTableViewCell", bundle: nil)
        writingDiaryTableView.register(writingDiaryCell, forCellReuseIdentifier: "WritingDiaryTableViewCell")
    }
    
    //일기 쓰기 화면 전환
    @objc func TapWritingTableViewCell(_ sender: UIButton) {
        let todayDiaryStoryBoard = UIStoryboard(name: "TodayDiary", bundle: nil)
        if let todayDiaryVC = todayDiaryStoryBoard.instantiateViewController(withIdentifier: "TodayDiaryViewController") as? TodayDiaryViewController {
            self.navigationController?.pushViewController(todayDiaryVC, animated: true)
        }
    }

    
    
    //MARK: - Actions
}

    //MARK: - Extensions
extension WritingDiaryViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 1
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 2
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        var cell = UITableViewCell()
        cell.selectionStyle = UITableViewCell.SelectionStyle.none
        
        if indexPath.section == 0 {
            cell = tableView.dequeueReusableCell(withIdentifier: "CalendarTableViewCell", for: indexPath)
            
            
            
        }
        
        if indexPath.section == 1 {
            cell = tableView.dequeueReusableCell(withIdentifier: "WritingDiaryTableViewCell", for: indexPath)
            let writingTableViewCell = cell as! WritingDiaryTableViewCell
            writingTableViewCell.diaryWriteButton.addTarget(self, action: #selector(TapWritingTableViewCell(_:)), for: .touchUpInside)
        }
        
        return cell
    }
    
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return UITableView.automaticDimension
    }
    
    
//    func tableView(_ tableView: UITableView, estimatedHeightForFooterInSection section: Int) -> CGFloat {
//        return 100
//    }
    
//    func tableView(_ tableView: UITableView, heightForFooterInSection section: Int) -> CGFloat {
//        return 100
//    }
    
    
}
