//
//  MyDiaryTableViewCell.swift
//  CommentDiary
//
//  Created by 류창휘 on 2022/02/25.
//

import UIKit

class MyDiaryTableViewCell: UITableViewCell {
    
    @IBOutlet weak var diaryCommentCountLabel: UILabel!
    @IBOutlet weak var diaryTitleLabel: UILabel!
    @IBOutlet weak var diaryContentLabel: UILabel!
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    override func layoutSubviews() {
        // 테이블 뷰 셀 사이의 간격
        super.layoutSubviews()

        contentView.frame = contentView.frame.inset(by: UIEdgeInsets(top: 0, left: 0, bottom: 8, right: 0))
    }
    

}
