//
//  ArticleViewPresenter.swift
//  CleanSample
//
//  Created by Akihko Okubo on 2016/11/15.
//  Copyright © 2016年 Akihko Okubo. All rights reserved.
//

import Foundation
import Swinject

/*
 プレゼンターです。
 使用するユースケースのアウトプット処理を引き受けるdelegateプロトコル(~OutPutDelegate)を適用しています。
 */
class ArticleViewPresenter {

    //VCとPresentereとの循環参照を防ぐためにweakを付与して弱参照にします
    weak var articleView:ArticleViewOutPutDelegate?
    
    var articleUseCase = CleanSmapleContainer.sharedContainer.resolve(ArticleUseCase.self)!
    var bookmarkUseCase = CleanSmapleContainer.sharedContainer.resolve(BookmarkUseCase.self)!
    
    /*　記事一覧を表示したい時にVCが呼び出す関数です。 */
    func loadArticle() {
        
        //ユースケースのアウトプット処理が委譲されるGetArticlesOutPutDelegate型インスタンスとして、自分自身を登録します。
        articleUseCase.getArticlesOutput = self
        articleUseCase.getArticles()
    }
    
    /*　ブックマークを追加する時にVCが呼び出す関数です。 */
    func addBookmark(_ input:ArticleModel) {
        bookmarkUseCase.addBookmarkOutput = self
        bookmarkUseCase.addBookmark(input)
    }
    
}

//記事一覧取得ユースケースの実行結果を処理する拡張です
extension ArticleViewPresenter: GetArticlesOutPutDelegate {
    
    //ArticleUseCaseの処理の中でこのメソッドを呼び出します。
    func getArticlesOnSuccess(_ articlesModel : ArticlesModel) {
        
        DispatchQueue.main.async { [weak self]() -> Void in
            
            //VCに実装した記事一覧表示処理に委譲
            self?.articleView?.setArticlesModel(articlesModel)
        }
    }
}

//ブックマーク追加ユースケースの実行結果を処理する拡張です。
extension ArticleViewPresenter: AddBookmarkOutPutDelegate {
    
    func addBookmarkOnSuccess(){
        articleView?.completeBookmark()
    }
    
}
