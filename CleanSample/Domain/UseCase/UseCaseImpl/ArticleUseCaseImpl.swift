
//
//  ArticleUseCase.swift
//  CleanSample
//
//  Created by Akihko Okubo on 2016/11/15.
//  Copyright © 2016年 Akihko Okubo. All rights reserved.
//

import Foundation
import BoltsSwift

/* 記事に関するユースケースです。 */
class ArticleUseCaseImpl : ArticleUseCase {
    
    //OutPutには基本的にPresenterの参照が入ります。Presenter側もuseCaseへの参照を持つので、循環しないようにoutputは弱参照にします。
    weak var getArticlesOutput : GetArticlesOutPutDelegate?
    
    lazy var articleRepository = CleanSmapleContainer.sharedContainer.resolve(ArticleRepository.self)!
    
    //translatorです。Entity→Modelの変換を受け持ちます
    lazy var translator = ArticleTranslator()
    
    /* リポジトリからデータをロードし、結果の処理はGetArticlesOutPutDelegateプロトコルを実装したクラスに移譲します */
    func getArticles() {

        articleRepository.getArticle().continueWith{ [weak self] task in
            
            guard let myself = self else {
                return
            }
            
            if let error = task.error {
                
                //エラータイプによってdelegateするメソッドを変えます
                switch error {
                case SampleError.notAuthorized:
                    //し
                    myself.getArticlesOutput?.getArticlesOnFail(error: SampleError.notAuthorized)
                    print("notAuthorized")
                case SampleError.network:
                    myself.getArticlesOutput?.getArticlesOnFail(error: SampleError.network)
                    print("network")
                default:
                    throw error
                }
            }
            
            if let jsons = task.result {
                //成功時のdelegateメソッドを呼び出します。
                myself.getArticlesOutput?.getArticlesOnSuccess(myself.translator.generateArticleModels(jsons))
            }
        }
    }
    
}
