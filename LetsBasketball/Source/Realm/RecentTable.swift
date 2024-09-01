//
//  RecentTable.swift
//  LetsBasketball
//
//  Created by 강석호 on 8/31/24.
//

import RealmSwift
import Foundation

class RecentTable: Object {
    @Persisted(primaryKey: true) var id: ObjectId
    @Persisted var title: String = ""
    @Persisted var content: String = ""
    @Persisted var viewDate: Date = Date()
    
    convenience init(title: String, content: String, viewDate: Date) {
        self.init()
        self.title = title
        self.content = content
        self.viewDate = Date()
    }
}
