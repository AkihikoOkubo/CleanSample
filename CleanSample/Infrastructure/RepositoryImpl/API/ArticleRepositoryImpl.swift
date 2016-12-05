//
//  ArticleRepository.swift
//  CleanSample
//
//  Created by Akihko Okubo on 2016/11/15.
//  Copyright © 2016年 Akihko Okubo. All rights reserved.
//

import Foundation
import BoltsSwift

/* 記事一覧をロードするリポジトリです。 */
class ArticleRepositoryImpl : ArticleRepository {
    
    let request = APIRequest()
    
    /*
     非同期処理の完了を待ってから画面の描画系メソッド(このサンプルだとVCのtableView.reload)を呼び出す必要があるので、
     プロミスを返して直列処理できるようにします。
     */
    func getArticle() -> Task<[AarticleJsonEntity]>{
        let taskCompletionSource = TaskCompletionSource<[AarticleJsonEntity]>()
        
        //APIのコール処理の中でAarticleJsonEntityへのマッピングまで済ませてあります
        request.getArticle(callback: {(jsons, error) -> Void in
            
            if error != nil  {
                //APIのコール処理で適切なエラータイプが設定されているはず
                taskCompletionSource.trySet(error: error!)
            }
            
            taskCompletionSource.trySet(result:jsons!)
        })
        return taskCompletionSource.task
    }
    
}
