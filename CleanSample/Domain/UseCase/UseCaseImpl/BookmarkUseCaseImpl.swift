
//
//  AddBookmarkUseCase.swift
//  CleanSample
//
//  Created by Akihko Okubo on 2016/11/16.
//  Copyright © 2016年 Akihko Okubo. All rights reserved.
//

import Foundation

/* ブックマークに関するユースケースです。 */
class BookmarkUseCaseImpl : BookmarkUseCase {
    
    weak var addBookmarkOutput : AddBookmarkOutPutDelegate?
    weak var deleteBookmarkOutput : DeleteBookmarkOutPutDelegate?
    weak var getBookmarkOutput : GetBookmarkOutPutDelegate?
    
    //repository
    lazy var bookmarkRepository = CleanSmapleContainer.sharedContainer.resolve(BookmarkRepository.self)!
    
    //Translator
    lazy var translator = BookmarkTranslator()
    
    func addBookmark(_ input:ArticleModel) {
        
        let bookmark = translator.generateBookmark(articleModel: input)
        
        //TODO:SwiftBondの実験。試しにBindしている値を書き換える
        input.state.value = BookmarkState.Already
        
        bookmarkRepository.addBookmark(bookmark)
        addBookmarkOutput?.addBookmarkOnSuccess()
    }
    
    func deleteBookmark(_ model:BookmarkModel) {
        
        bookmarkRepository.removeBookmark(translator.generateBookmark(model))
        deleteBookmarkOutput?.deleteBookmarkOnSuccess(model)
    }
    
    func getBookmark() {
        let results = bookmarkRepository.loadBookmarks()
        
        let modle = BookmarksModel()
        results?.forEach{ resultBookmark in
            let b = BookmarkModel()
            b.name = resultBookmark.userName
            b.title = resultBookmark.title
            b.profileUrl = resultBookmark.profileImgUrl
            b.url = resultBookmark.linkUrl
            b.id = resultBookmark.id
            modle.bookmarks.append(b)
        }
        
        getBookmarkOutput?.getBookmarkOnSuccess(modle)
    }

}
