//
//  ArticleViewControllerTest.swift
//  CleanSample
//
//  Created by Akihiko Okubo on 2016/11/22.
//  Copyright © 2016年 Akihiko Okubo. All rights reserved.
//

import Foundation
import Quick
import Nimble

//Target名を指定してimportすることで、Prodctionのクラスを使用できるようになります
@testable import CleanSample

/* 
 ArticleViewControllerのテストクラスです。
 Product -> test を選択するテストが実行できます。
 左ペインの「Test Navigator」で結果が確認できます(「cmd + 5」で開きます)
 */
class ArticleViewControllerTests : QuickSpec {
    
    var subject : ArticleViewController!

    override func spec() {
        
        describe("記事一覧画面の表示"){
            
            //このdescribeグループのitの実行前に毎回実行されるセットアップメソッドです
            beforeEach {
                
                //Outletを触るケースの場合、ストーリーボードからVCのインスタンスを作成する必要があります。
                let storyboard = UIStoryboard(name: "Main", bundle: nil)
                self.subject = storyboard.instantiateViewController(withIdentifier: "ArticleView") as! ArticleViewController
                
                //VCからのエントリーポイントとなる関数を空実装で上書きしたMock。
                self.subject.presenter = presenterMock()

                //画面遷移を起こしてライフサイクルメソッドをviewDidAppearまで実行します
                self.subject.beginAppearanceTransition(true, animated: false)
                self.subject.endAppearanceTransition()
                
            }
            
            //TODO:振る舞い単位でケースを作成するべきらしい。こんな感じであってる？
            it ("画面を0初期表示する(記事のロード前)") {
                //Nimbleの機能でアサートします
                expect(self.subject.indicator?.animating).to(beTrue())
            }
            
            it("記事一覧を表示する") {
                let models = ArticlesModel()
                models.articles.append(ArticleModel())
                self.subject.setArticlesModel(models)
                expect(self.subject).notTo(beNil())
                expect(self.subject.indicator?.animating).to(beFalse())
            }
            
        }
    }
    
    /*
     Swiftでは「Manual Mock」と言って、対象のサブクラスを作って愚直にMock化するのが一般的らしいです。
     VC→Presenter→UseCaseの間は一方通行でcallしていくだけなので、境界となる関数は全てVoidです。
     VC、Presenter、UseCaseのMockは空実装で十分だと思われます。
     */
    class presenterMock : ArticleViewPresenter {
        override func loadArticle() {
            print("Mock Call")
        }
    }
    
}
