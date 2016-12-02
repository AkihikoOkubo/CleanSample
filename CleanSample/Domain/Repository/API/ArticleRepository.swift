//
//  ArticleRepository.swift
//  CleanSample
//
//  Created by Akihko Okubo on 2016/11/18.
//  Copyright © 2016年 Akihko Okubo. All rights reserved.
//

import Foundation
import BoltsSwift

/* 
 WebAPIを使用するRepositoryの関数の戻り値は、全てBoltsSwiftのTaskでラップします。
 */
protocol ArticleRepository {
    
    func getArticle() -> Task<[AarticleJsonEntity]>
    
}
