//
//  CalendarTImeZoneCustom.swift
//  CommentDiary
//
//  Created by 류창휘 on 2022/02/21.
//

import Foundation
import FSCalendar

class CalendarTimeZoneCustom: FSCalendar {

   override init(frame: CGRect) {
      super.init(frame: frame)
   }

   required init?(coder aDecoder: NSCoder) {

       super.init(coder: aDecoder)

       if let projectTimeZone = TimeZone(identifier: "he_IL") {
          self.setValue(projectTimeZone, forKey: "timeZone")
          self.perform(Selector(("invalidateDateTools")))
       }
   }
}
