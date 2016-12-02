//
//  AddBookmark.swift
//  CleanSample
//
//  Created by Akihko Okubo on 2016/11/17.
//  Copyright © 2016年 Akihko Okubo. All rights reserved.
//

import Foundation

protocol BookmarkUseCase :class {
    
    //ブックマークを追加します
    func addBookmark(_ input:ArticleModel)
    weak var addBookmarkOutput : AddBookmarkOutPutDelegate?{get set}
    
    //ブックマークを削除します
    func deleteBookmark(_ model:BookmarkModel)
    weak var deleteBookmarkOutput : DeleteBookmarkOutPutDelegate?{get set}
    
    //ブックマークのリストを取得します
    func getBookmark()
    weak var getBookmarkOutput : GetBookmarkOutPutDelegate?{get set}
}

protocol AddBookmarkOutPutDelegate :class {
    
    /*
     実行中を通知します。
     */
    func addBookmarkOnExecution()
    
    /*
     処理失敗を通知します。
     */
    func addBookmarkOnFail(error:Error)
    
    /*
     処理成功を通知します。
     */
    func addBookmarkOnSuccess()
    
}

extension AddBookmarkOutPutDelegate {
    
    func addBookmarkOnFail(error:Error) {}
    
    func addBookmarkOnExecution() {}
}

protocol DeleteBookmarkOutPutDelegate :class {
    
    /*
     実行中を通知します。
     */
    func deleteBookmarkOnExecution()
    
    /*
     処理失敗を通知します。
     */
    func deleteBookmarkOnFail(error:Error)
    
    /*
     処理成功を通知します。
     */
    func deleteBookmarkOnSuccess(_ :BookmarkModel)
}


extension DeleteBookmarkOutPutDelegate {
    
    func deleteBookmarkOnFail(error:Error) {}
    
    func deleteBookmarkOnExecution() {}
}


protocol GetBookmarkOutPutDelegate :class {
    
    /*
     実行中を通知します。
     */
    func getBookmarkOnExecution()
    
    /*
     処理失敗を通知します。
     */
    func getBookmarkOnFail(error:Error)
    
    /*
     処理成功を通知します。
     */
    func getBookmarkOnSuccess(_ model:BookmarksModel)
    
}

extension GetBookmarkOutPutDelegate {
    
    func getBookmarkOnFail(error:Error) {}
    
    func getBookmarkOnExecution() {}
}
