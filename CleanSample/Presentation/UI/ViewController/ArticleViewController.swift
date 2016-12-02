//
//  ArticleViewController.swift
//  CleanSample
//
//  Created by Akihko Okubo on 2016/11/14.
//  Copyright © 2016年 Akihko Okubo. All rights reserved.
//

import Foundation
import UIKit
import NVActivityIndicatorView

/*
 Presenter側の処理の結果を用いてViewを書き換える関数を定義したプロトコルです。
 VCに適用し、Presenter側の本プロトコル型プロパティに保持することで、Presenter内からVCへメソッド実行を委譲します。
 */
protocol ArticleViewOutPutDelegate :class {
    
    //記事一覧を表示します
    func setArticlesModel(_ :ArticlesModel)
    
    //ブックマーク追加の完了を通知します
    func completeBookmark()
}

/*
 記事一覧画面のVCです。
 */
class ArticleViewController : UIViewController {
    
    /* TableView */
    @IBOutlet weak var tableView: UITableView!
    
    //TableViewに表示するモデル
    var model:ArticlesModel?
    
    /* UI系インスタンス */
    var indicator:NVActivityIndicatorView?
    var successView = UIView(frame: CGRect(x: 0, y: 0, width: 150, height: 150))
    var successLabel = UILabel(frame: CGRect(x: 0, y: 0, width: 80, height: 80))
    
    /* プレゼンター */
    var presenter = ArticleViewPresenter()
    
    override func viewDidLoad() {}
    
    override func viewWillAppear(_ animated: Bool) {
        
        //プレゼンターのdelegateプロトコル型プロパティにVCを格納します
        presenter.articleView = self
        
        //インジケータの追加
        self.tableView.tableFooterView = UIView()
        let rect = CGRect(x: 0, y: 0, width: 50, height: 50)
        indicator = NVActivityIndicatorView(frame: rect, type: NVActivityIndicatorType.ballSpinFadeLoader, color: UIColor.gray, padding: nil)
        indicator?.startAnimating()
        indicator?.center = self.view.center
        self.view.addSubview(indicator!)
        
        //ブックマーク登録時の通知部品
        setUpSuccessView()
        
        //プレゼンターの関数を呼び出し
        presenter.loadArticle()
        
    }
    
    /* Cellのブックマークボタン押下時のAction*/
    func addBookmark(sender: UIButton) {
        let cell = sender.superview?.superview as! ArticleCell
        let rowIndex = cell.bookmark.tag
        let model  = self.model?.articles[rowIndex]
        presenter.addBookmark(model!)
    }
    
    //ブックマーク完了通知のセットアップ。subViewしてhideしておく。
    func setUpSuccessView() {
        self.successView = UIView(frame: CGRect(x: 0, y: 0, width: 150, height: 150))
        self.successView.tag = 1
        self.successView.backgroundColor = UIColor.black
        self.successView.alpha = 0.5
        self.successView.layer.cornerRadius = 10
        self.successView.center = self.view.center
        
        self.successLabel = UILabel(frame: CGRect(x: 0, y: 0, width: 80, height: 80))
        self.successLabel.tag = 2
        self.successLabel.center = successView.center
        self.successLabel.text = "SUCCESS"
        self.successLabel.textColor = UIColor.white
        
        self.view.addSubview(successView)
        self.view.addSubview(successLabel)
        successView.isHidden = true
        successLabel.isHidden = true
    }
    
}

//Presenterから移譲されます
extension ArticleViewController: ArticleViewOutPutDelegate {
    
    //ArticleViewOutPutDelegateの実装部分。記事をセットしてリロード
    func setArticlesModel(_ model:ArticlesModel) {
        self.model = model
        self.tableView.reloadData()
        indicator?.stopAnimating()
    }
    
    //ブックマーク完了通知を表示する
    func completeBookmark() {
        self.successView.alpha = 0.5
        self.successView.isHidden = false
        self.successLabel.isHidden = false
        
        UIView.animate( withDuration: TimeInterval(1.0), animations: {
            self.successView.alpha = 0
        }, completion: { (finished: Bool) in
            self.successView.isHidden = true
            self.successLabel.isHidden = true
        })
    }
    
}

//UITableViewDelegate
extension ArticleViewController: UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if let articles = self.model?.articles {
            return articles.count
        } else {
            return 0
        }
    }

    func tableView(_ table: UITableView, didSelectRowAt indexPath:IndexPath) {
        let model  = self.model?.articles[indexPath.row]
        
        //ブラウザで開く
        if let urlStr = model?.url {
            if let url = NSURL(string: urlStr) as? URL {
                if UIApplication.shared.canOpenURL(url){
                    UIApplication.shared.open(url, options: [:], completionHandler: nil)
                }
            }
        }
    }
}

//UITableViewDataSource
extension ArticleViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "ArticleCell", for: indexPath as IndexPath) as! ArticleCell
        cell.setUpCell(source: (self.model!.articles[indexPath.row]))
        cell.bookmark.addTarget(self, action: #selector(ArticleViewController.addBookmark), for: UIControlEvents.touchUpInside)
        cell.bookmark.tag = indexPath.row
        return cell
        
    }
}
