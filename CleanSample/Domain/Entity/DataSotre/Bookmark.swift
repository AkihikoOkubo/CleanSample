//
//  Bookmark.swift
//  CleanSample
//
//  Created by Akihko Okubo on 2016/11/16.
//  Copyright © 2016年 Akihko Okubo. All rights reserved.
//

import Foundation
import RealmSwift

class Bookmark : Object {
    
    dynamic var id = ""
    dynamic var title = ""
    dynamic var profileImgUrl = ""
    dynamic var userName = ""
    dynamic var linkUrl = ""
    
    override class func primaryKey() -> String {
        return "id"
    }
}
