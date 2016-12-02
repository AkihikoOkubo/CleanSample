//
//  ArticleModel.swift
//  CleanSample
//
//  Created by Akihko Okubo on 2016/11/15.
//  Copyright © 2016年 Akihko Okubo. All rights reserved.
//

import Foundation
import Bond

/*
 Viewで使うモデル。
 UseCaseのアウトプットは基本的にViewModelです。
 */
class ArticlesModel :NSObject {
    var articles:[ArticleModel] = []
    
    func setUp(_ jsons : [AarticleJsonEntity]) {
        let converted = jsons.map{ArticleModel($0)}
        articles.append(contentsOf: converted)
    }
}

/*
 ブックマークに登録済みかどうかの状態を表します。
 SwiftBondを使ってモデルの状態を動的にViewにバインドします。
 */
enum BookmarkState {
    
    case Already //登録済み
    case Yet //未登録
    
    //状態判定用のメソッド
    func isBookmarked() -> Bool {
        return self == .Already
    }
}

/*
 個別の記事を表すモデルです。
 */
class ArticleModel :NSObject {

    var id:String?
    var title:String?
    var profileUrl:String?
    var name:String?
    var url:String?
    
    //ブックマーク状態を保持します。初期値ステータスは「未登録」とします。
    var state = Observable<BookmarkState>(.Yet)
    
    /*
     SwiftBondでこのプロパティをUIViewとバインドすることで、ブックマーク状態に応じて動的にラベルを切り替えられます。
     バインド処理はArticleCellクラス内で実施しています。
     */
    var bookmarkStatusLabel = Observable<String>("ブックマークする")
    
    override init(){
        super.init()
    }
    
    init(_ entity : AarticleJsonEntity) {
        super.init()
        
        id = entity.id
        title = entity.title
        url = entity.url
        profileUrl = entity.profile_image_url
        name = entity.name
        title = entity.title
        self.addObserve()
    }
    
    /*
     ブックマーク状態によってボタンのラベルを書き換えるためのオブザーバです。
     stateが書き換えられた場合にこのオブザーバがトリガーされ、
     Bookmarkボタンのタイトルとバインドしてあるself.bookmarkBtnTitleプロパティを書き換えます。
     */
    func addObserve() {
        _ = state.observeNext{ [weak self] state in
            if (state.isBookmarked()) {
                self?.bookmarkStatusLabel.value = "ブックマーク済み"
            }else {
                self?.bookmarkStatusLabel.value = "ブックマークする"
            }
        }
    }

}
