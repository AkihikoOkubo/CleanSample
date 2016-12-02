//
//  GetArticleList.swift
//  CleanSample
//
//  Created by Akihko Okubo on 2016/11/17.
//  Copyright © 2016年 Akihko Okubo. All rights reserved.
//

import Foundation

/* 記事に関するユースケースを定義したプロトコルです。*/
protocol ArticleUseCase : class {
    
    /* 記事一覧を取得する*/
    func getArticles()
    
    //PresenterとUseCaseは相互に参照することになるので、弱参照にしないと循環してメモリリークします
    weak var getArticlesOutput : GetArticlesOutPutDelegate?{get set}
    
    /*
     ユースケースを追加する場合は下記作業を行なってください。
     1.ArticleUseCaseにユースケースを表すfunctionを追加する
     2.追加したユースケースに対応する~OutPutDelegateプロトコルを追加する
     3.必要に応じて~OutPutDelegateプロトコルをデフォルト実装でextensionする
     4.~OutPutDelegateプロトコル型のプロパティ(~OutPut)をArticleUseCaseに定義する
     */
}

/*
 記事一覧表示で、Presentation層へ委譲する処理を定義します。
 */
protocol GetArticlesOutPutDelegate : class {
    
    /*
     実行中を通知します。
     このメソッドでは、例えば、通知バーにインジケータを表示するメソッドに処理を委譲する処理を実装します。
     */
    func getArticlesOnExecution()
    
    /*
     処理失敗を通知します。
     このメソッドには、例えば、エラーの種類を判別したのち、画面にAlertを出して再実行を促すメソッドに処理を委譲する処理を実装します。
     */
    func getArticlesOnFail(error:SampleError)
    
    /*
     処理成功を通知します。
     このメソッドには、例えば、読み込んだ記事一覧をtableViewに描画するメソッドに処理を委譲する処理を実装します。
     */
    func getArticlesOnSuccess(_ :ArticlesModel)
}

/*
 プロトコルを拡張して空実装を提供し、必須ではない関数の実装をオプションにします。
 */
extension GetArticlesOutPutDelegate {
    
    func getArticlesOnFail(error:SampleError) {
        print(error)
    }
    
    func getArticlesOnExecution() {}
}
