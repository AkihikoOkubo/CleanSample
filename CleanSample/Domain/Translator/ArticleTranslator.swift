//
//  ArticleTranslator.swift
//  CleanSample
//
//  Created by Akihko Okubo on 2016/11/16.
//  Copyright © 2016年 Akihko Okubo. All rights reserved.
//

import Foundation

/* DataStoreから取得したEntityをModelに変化するクラスです。*/
class ArticleTranslator : NSObject {
    
    func generateArticleModels(_ jsons : [AarticleJsonEntity]) -> ArticlesModel {
        let model = ArticlesModel()
        model.setUp(jsons)
        return model
    }
    
}
