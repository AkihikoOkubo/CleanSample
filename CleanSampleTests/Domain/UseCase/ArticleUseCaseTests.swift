//
//  ArticleUseCase.swift
//  CleanSample
//
//  Created by Akihiko Okubo on 2016/11/22.
//  Copyright © 2016年 Akihiko Okubo. All rights reserved.
//

import Foundation
import Quick
import Nimble
import BoltsSwift

@testable import CleanSample

class ArticleUseCaseTests :  QuickSpec {
    
    var subject : ArticleUseCaseImpl?
    
    override func spec() {
        
        describe("リポジトリから記事リストをロードする"){
            
            //このdescribeグループのitの実行前に毎回実行されるセットアップメソッドです
            beforeEach {
                
                self.subject = ArticleUseCaseImpl()
                self.subject?.articleRepository = ArticleRepositoryMock()
            }
            
            it("データを1件取得する") {
                
                let mock = delegateMock()
                self.subject?.getArticlesOutput = mock
                self.subject?.getArticles()
                
                expect(mock.isInvokedGetArticlesOnSuccess).to(beTrue())
                
                //比較演算子でアサートできます
                expect(mock.getArticleSuccessArg!.articles.count) == 1
                
            }
            
            it("エラー発生！"){
                
                class articleRepositoryMock : ArticleRepositoryMock {
                    
                    //エラーが発生するようにoverride
                    override func getArticle() -> Task<[AarticleJsonEntity]> {
                        
                        let taskCompletionSource = TaskCompletionSource<[AarticleJsonEntity]>()
                        taskCompletionSource.trySet(error: SampleError.notAuthorized)
                        return taskCompletionSource.task
                    }
                }
                
                self.subject?.articleRepository = articleRepositoryMock()
                let mock = delegateMock()
                self.subject?.getArticlesOutput = mock
                self.subject?.getArticles()
                
                expect(mock.isInvoledGetArticlesOnFail).to(beTrue())
                expect(mock.getArticleFailArg) == SampleError.notAuthorized
            }
            
        }
        
    }
    
    /* ArticleRepositoryのMockクラスです。 */
    class ArticleRepositoryMock: ArticleRepository {
        
        func getArticle() -> Task<[AarticleJsonEntity]> {
            
            let taskCompletionSource = TaskCompletionSource<[AarticleJsonEntity]>()
            var data:[AarticleJsonEntity] = []
            data.append(AarticleJsonEntity())
            taskCompletionSource.trySet(result: data)
            return taskCompletionSource.task
        }
    }
    
    
    /*
     GetArticlesOutPutDelegateのMockクラスです。
     期待通りのdelegateメソッドが起動されたかどうかを検証するためのプロパティを定義しています。
     やや無理やりですが、Quick/Nimbleに"isInvoked"的なassertionがないので仕方がない・・・
     */
    class delegateMock : GetArticlesOutPutDelegate {
        
        //成功
        var isInvokedGetArticlesOnSuccess = false
        var getArticleSuccessArg:ArticlesModel?
        
        //実行中
        var isInvokedGetArticlesOnExecution = false
        
        //失敗
        var isInvoledGetArticlesOnFail = false
        var getArticleFailArg:SampleError?
        
        
        func getArticlesOnSuccess(_ model : ArticlesModel) {
            getArticleSuccessArg = model
            isInvokedGetArticlesOnSuccess = true
        }
        
        func getArticlesOnExecution() {
            isInvokedGetArticlesOnExecution = true
        }
        
        func getArticlesOnFail(error:SampleError) {
            getArticleFailArg = error
            isInvoledGetArticlesOnFail = true
        }
    }
    
}
