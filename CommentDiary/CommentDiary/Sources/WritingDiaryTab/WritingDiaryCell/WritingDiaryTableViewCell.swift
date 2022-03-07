//
//  WritingDiaryTableViewCell.swift
//  CommentDiary
//
//  Created by 류창휘 on 2022/02/19.
//

import UIKit

class WritingDiaryTableViewCell: UITableViewCell {
    @IBOutlet weak var diaryWriteButton: UIButton!
    @IBOutlet weak var diaryDateLabel: UILabel!

    
    override func awakeFromNib() {
        super.awakeFromNib()
        NotificationCenter.default.addObserver(self, selector: #selector(loadData(_:)), name: NSNotification.Name(rawValue: "SelectedDate"), object: nil)

    }

    
    @objc func loadData(_ notification : NSNotification) {
        diaryDateLabel.text = notification.object as? String ?? ""
        print(diaryDateLabel.text, "diaryDateLabel")
    }


    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

    
    override func layoutSubviews() {
        super.layoutSubviews()
//        contentView.frame = contentView.frame.inset(by: UIEdgeInsets(top: 13, left: 0, bottom: 0, right: 0))
//        contentView = contentView.frame.contentInset
        contentView.frame = contentView.frame.offsetBy(dx: 0, dy:0) //위의 셀과 얼마나 띄울지
    }
    
}
