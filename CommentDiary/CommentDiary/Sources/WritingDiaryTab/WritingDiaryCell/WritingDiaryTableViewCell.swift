//
//  WritingDiaryTableViewCell.swift
//  CommentDiary
//
//  Created by 류창휘 on 2022/02/19.
//

import UIKit

class WritingDiaryTableViewCell: UITableViewCell {
    @IBOutlet weak var diaryWriteButton: UIButton!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    


    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

    
    override func layoutSubviews() {
        super.layoutSubviews()
//        contentView.frame = contentView.frame.inset(by: UIEdgeInsets(top: 13, left: 0, bottom: 0, right: 0))
//        contentView = contentView.frame.contentInset
        contentView.frame = contentView.frame.offsetBy(dx: 0, dy: 30) //위의 셀과 얼마나 띄울지
    }
    
}
