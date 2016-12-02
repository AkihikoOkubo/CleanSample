//
//   BookmarkModel.swift
//  CleanSample
//
//  Created by Akihko Okubo on 2016/11/17.
//  Copyright © 2016年 Akihko Okubo. All rights reserved.
//

import Foundation

class BookmarksModel :NSObject {
    var bookmarks:[BookmarkModel] = []
}

class BookmarkModel :NSObject {
    
    var id:String?
    var profileUrl:String?
    var title:String?
    var name:String?
    var url:String?
    var rowIndex:Int?
}
