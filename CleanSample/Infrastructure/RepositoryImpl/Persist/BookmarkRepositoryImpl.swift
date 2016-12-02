//
//  BookmarkRepository.swift
//  CleanSample
//
//  Created by Akihko Okubo on 2016/11/16.
//  Copyright © 2016年 Akihko Okubo. All rights reserved.
//

import Foundation
import RealmSwift

class BookmarkRepositoryImpl : BookmarkRepository {
    
    func addBookmark(_ bookmark:Bookmark) {
     
        do {
            let r = try Realm()
            try r.write {
                r.add(bookmark, update: true)
            }
            
        } catch {
            print("Realm Error")
        }
        
    }
    
    func loadBookmarks() -> Results<Bookmark>? {
        
        do {
            let r = try Realm()
            let dataContent = r.objects(Bookmark.self)
            return dataContent
            
        } catch {
            print("Realm Error")
        }
        
        return nil
    }
    
    func removeBookmark(_ bookmark:Bookmark) {
        
        do {
            let r = try Realm()
            let dataContent = r.object(ofType: Bookmark.self, forPrimaryKey: bookmark.id)
            if dataContent != nil {
                try r.write {
                    r.delete(dataContent!)
                }
            }
        } catch {
            print("Realm Error")
        }
    }
    
    
    
}
