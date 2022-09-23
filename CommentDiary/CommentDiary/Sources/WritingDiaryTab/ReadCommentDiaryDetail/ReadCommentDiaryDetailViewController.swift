//
//  ReadCommentDiaryDetailViewController.swift
//  CommentDiary
//
//  Created by 류창휘 on 2022/08/12.
//

import Foundation
import UIKit

class ReadCommentDiaryDetailViewController : UIViewController {
    var userCommentStatus = false
    var myCommentLists : [myCommentCheckResponseList] = []
    enum hexColor {
        case backgroundColor
        case navigationTitleColor
        case navigationSeparateViewColor
        case dateLabelColor
        case titleLabelColor
        case contentLabelColor
        case titleLabelSeparateViewColor
        case commentBackViewColor
        case someoneCommentLabelColor
        case reportButtonColor
        
        func getHexColor() -> UIColor {
            switch self {
            case .backgroundColor:
                return UIColor(hex: 0xFDFCF9)
            case .navigationTitleColor:
                return UIColor(hex: 0x4E4C49)
            case .navigationSeparateViewColor:
                return UIColor(hex: 0xF4F1EB)
            case .dateLabelColor:
                return UIColor(hex: 0x5ABD80)
            case .titleLabelColor:
                return UIColor(hex: 0x5F5D59)
            case .contentLabelColor:
                return UIColor(hex: 0x5F5D59)
            case .titleLabelSeparateViewColor:
                return UIColor(hex: 0xE2DFD7)
            case .commentBackViewColor:
                return UIColor(hex: 0xF8F4EF)
            case .someoneCommentLabelColor:
                return UIColor(hex: 0x73BF90)
            case .reportButtonColor:
                return UIColor(hex: 0x878379)
                
            }
        }
        
    }
    @IBOutlet weak var diaryTableView: UITableView!
    @IBOutlet weak var navigationBarVIew: UIView!
    @IBOutlet weak var navigationBarTItleLabel: UILabel!
    @IBOutlet weak var navigationBarSeparateView: UIView!
    
//    enum hexColor {
//        case backgroundColor
//        case navigationTitleLabelColor
//        case naviagationSeparateViewColor
//        case dateLabelColor
//        case titleLabelColor
//        case contentLabelColor
//
//        func getHexColor() -> UIColor {
//            switch self {
//            case .backgroundColor:
//                return UIColor(hex: 0xFDFCF9)
//            case .navigationTitleLabelColor:
//                return UIColor(hex: 0x4E4C49)
//            case .naviagationSeparateViewColor:
//                return
//            case .dateLabelColor:
//                return
//            case .titleLabelColor:
//                return
//            case .contentLabelColor:
//                return
//            }
//        }
//    }
    
    // MARK: - Properties
    
    
    // MARK: - LifeCycle
    override func viewDidLoad() {
        super.viewDidLoad()
        diaryTableView.delegate = self
        diaryTableView.dataSource = self
    }
    // MARK: - Actions
}
extension ReadCommentDiaryDetailViewController : UITableViewDelegate, UITableViewDataSource {
    func numberOfSections(in tableView: UITableView) -> Int {
        return 2
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        switch section {
        case 0:
            return 1
        case 1:
            if userCommentStatus == false {
                return 0
            }
            else {
                return myCommentLists.count
            }

        default:
            return 0
        }
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        switch indexPath.section {
        case 0:
            let cell = tableView.dequeueReusableCell(withIdentifier: "ReadCommentDiaryCell", for: indexPath) as! ReadCommentDiaryCell
            return cell
        case 1:
            let cell = tableView.dequeueReusableCell(withIdentifier: "ReadCommentsCell", for: indexPath) as! ReadCommentsCell
            
            return cell
            
            
        default:
            let cell = tableView.dequeueReusableCell(withIdentifier: "ReadCommentDiaryCell", for: indexPath) as! ReadCommentDiaryCell
            return cell
        }
    }

    
}
