//
//  CleanSmapleContainer.swift
//  CleanSample
//
//  Created by Akihko Okubo on 2016/11/18.
//  Copyright © 2016年 Akihko Okubo. All rights reserved.
//

import Foundation
import Swinject

/* DIコンテナです。 */
class CleanSmapleContainer  {
    
    /* シングルトンにします */
    class var sharedContainer : Container {
        struct Static {
            static let instance = CleanSmapleContainer()
        }
        return Static.instance.container
    }
    
    /* DIコンテナ */
    private let container = Container()
    
    private init () {
        container.register(ArticleUseCase.self) { _ in ArticleUseCaseImpl() }
        container.register(BookmarkUseCase.self) { _ in BookmarkUseCaseImpl() }
        container.register(ArticleRepository.self) { _ in ArticleRepositoryImpl() }
        container.register(BookmarkRepository.self) { _ in BookmarkRepositoryImpl() }
    }
    
}
