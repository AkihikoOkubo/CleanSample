//
//  BookmarkViewPresenter.swift
//  CleanSample
//
//  Created by Akihko Okubo on 2016/11/17.
//  Copyright © 2016年 Akihko Okubo. All rights reserved.
//

import Foundation

class BookmarkViewPresenter : GetBookmarkOutPutDelegate, DeleteBookmarkOutPutDelegate {
    
    weak var bookmarkView:BookmarkViewOutPutDelegate?
    
    var bookmarkUseCase = CleanSmapleContainer.sharedContainer.resolve(BookmarkUseCase.self)!
    
    func loadBoolmarks() {
        bookmarkUseCase.getBookmarkOutput = self
        bookmarkUseCase.getBookmark()
    }
    
    func getBookmarkOnSuccess(_ model: BookmarksModel) {
        DispatchQueue.main.async { [weak self]() -> Void in
            self?.bookmarkView?.setBookmarkModel(model)
        }
    }
    
    func removeBookmark(_ model:BookmarkModel) {
        bookmarkUseCase.deleteBookmarkOutput = self
        bookmarkUseCase.deleteBookmark(model)
    }
    
    func deleteBookmarkOnSuccess(_ model: BookmarkModel) {
        bookmarkView?.completeRemoveBookmark(model)
    }
    
}
