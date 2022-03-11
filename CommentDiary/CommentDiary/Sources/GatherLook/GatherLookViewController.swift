//
//  GatherLookViewController.swift
//  CommentDiary
//
//  Created by 류창휘 on 2022/03/11.
//

import Foundation
import UIKit

class GatherLookViewController : UIViewController {
    //MARK: - Properties
    @IBOutlet weak var backgroundView: UIView!
    
    @IBOutlet weak var noDiaryLabel: UILabel!
    
    @IBOutlet weak var yearLabel: UILabel!
    @IBOutlet weak var monthLabel: UILabel!
    @IBOutlet weak var dateButton: UIButton!
    @IBOutlet weak var sortTableView: UITableView!
    
    //MARK: - LifeCycle
    override func viewDidLoad() {
        super.viewDidLoad()
        backViewSetting()
//        sortTableView.delegate = self
//        sortTableView.dataSource = self
        cellsRegister()
    }

    func backViewSetting() {
        backgroundView.backgroundColor = UIColor(hex: 0xE5E5E5)
    }
    func LabelSetting() {
        noDiaryLabel.text = "아직 작성된 일기가 없어요! 일기를 작성해주세요 :)"
    }
    
    func cellsRegister() {
        let myDiaryCell = UINib(nibName: "MyDiaryTableViewCell", bundle: nil)
        sortTableView.register(myDiaryCell, forCellReuseIdentifier: "MyDiaryTableViewCell")
        
    }
    
    
    //MARK: - Actions
    
    @IBAction func dateButtonTap(_ sender: Any) {
        let vc = UIStoryboard(name: "PeriodView", bundle: nil).instantiateViewController(withIdentifier: "PeriodViewAlertViewController") as! PeriodViewAlertViewController
        self.present(vc, animated: true)
    }
    
}

    //MARK: - Extenstions
//extension MyDiaryViewController: UITableViewDelegate, UITableViewDataSource {
//    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
//        return 5
//
//    }
//
//    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
//        let cell: UITableViewCell = tableView.dequeueReusableCell(withIdentifier: "MyDiaryTableViewCell", for: indexPath)
//        return cell
//    }
//
//    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
//        return UITableView.automaticDimension
//    }
//
//    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
//        let NDetailDiaryStoryboard = UIStoryboard(name: "NDetailDiary", bundle: nil)
//        let NDetailDiaryVC = NDetailDiaryStoryboard.instantiateViewController(withIdentifier: "NDetailDiaryViewController")
//        self.navigationController?.pushViewController(NDetailDiaryVC, animated: true)
//    }
//
//
//}
