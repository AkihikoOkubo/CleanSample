//
//  BookmarkTranslator.swift
//  CleanSample
//
//  Created by Akihko Okubo on 2016/11/17.
//  Copyright © 2016年 Akihko Okubo. All rights reserved.
//

import Foundation

class BookmarkTranslator : NSObject {
    
    func generateBookmark(_ model:BookmarkModel) -> Bookmark {
        
        //TODO:Entityに変換を突っ込むのは違和感があるのでTransに実装
        let bookmark = Bookmark()
        
        if let id = model.id {
            bookmark.id = id
        }
        
        if let link = model.url {
            bookmark.linkUrl = link
        }
        
        if let title = model.title {
            bookmark.title = title
        }
        
        if let name = model.name {
            bookmark.userName = name
        }
        
        if let prfile = model.profileUrl {
            bookmark.profileImgUrl = prfile
        }
        return bookmark
    }
    
    func generateBookmark(articleModel:ArticleModel) -> Bookmark {
        
        let b = Bookmark()
        
        if let url = articleModel.url {
            b.linkUrl = url
        }
        
        if let name = articleModel.name {
            b.userName = name
        }
        
        if let title = articleModel.title {
            b.title = title
        }
        
        if let profile = articleModel.profileUrl {
            b.profileImgUrl = profile
        }
        
        if let id = articleModel.id {
            b.id = id
        }
        
        return b
    }
    
    
}
