//
//  BookmarkRepository.swift
//  CleanSample
//
//  Created by Akihko Okubo on 2016/11/18.
//  Copyright © 2016年 Akihko Okubo. All rights reserved.
//

import Foundation
import RealmSwift

/* 
 
 ローカルストレージから取得するデータは同期的に処理する。 
 */
protocol BookmarkRepository {
    
    func addBookmark(_ bookmark:Bookmark)
    func loadBookmarks() -> Results<Bookmark>?
    func removeBookmark(_ bookmark:Bookmark)
    
}
