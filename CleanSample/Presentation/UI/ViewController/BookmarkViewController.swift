//
//  BookmarkViewController.swift
//  CleanSample
//
//  Created by U4900C14257 on 2016/11/17.
//  Copyright © 2016年 Akihko Okubo. All rights reserved.
//

import Foundation
import UIKit

/*
 Presenter側の処理の結果を用いてViewを書き換える関数を定義したプロトコルです。
 */
protocol BookmarkViewOutPutDelegate :class {
    func setBookmarkModel(_ :BookmarksModel)
    func completeRemoveBookmark(_ model:BookmarkModel)
}

class BookmarkViewController : UIViewController, BookmarkViewOutPutDelegate {
    
    @IBOutlet weak var tableView: UITableView!
    
    var presenter = BookmarkViewPresenter()
    var model:BookmarksModel?
    override func viewDidLoad() {}
    
    override func viewWillAppear(_ animated: Bool) {
        presenter.bookmarkView = self
        presenter.loadBoolmarks()
    }
    
    func setBookmarkModel(_ model : BookmarksModel) {
        self.model = model
        tableView.reloadData()
    }
    
    func removeBookmark(sender: UIButton) {
        let cell = sender.superview?.superview as! BookmarkCell
        let rowIndex = cell.removeBookmark.tag
        let model = self.model?.bookmarks[rowIndex]
        model?.rowIndex = rowIndex
        presenter.removeBookmark(model!)
    }
    
    func completeRemoveBookmark(_ model:BookmarkModel) {
        
        self.tableView.beginUpdates()
        
        self.model?.bookmarks.remove(at: model.rowIndex!)
        let indexPath = IndexPath(row: model.rowIndex!, section: 0)
        tableView.deleteRows(at: [indexPath], with: UITableViewRowAnimation.automatic)
        self.tableView.endUpdates()
        self.tableView.reloadData()
    }
    
}


extension BookmarkViewController: UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if let bookmarks = self.model?.bookmarks {
            return bookmarks.count
        } else {
            return 0
        }
    }
    
    func tableView(_ table: UITableView, didSelectRowAt indexPath:IndexPath) {
        let model  = self.model?.bookmarks[indexPath.row]
        
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

extension BookmarkViewController: UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "BookmarkCell", for: indexPath as IndexPath) as! BookmarkCell
        cell.setUpCell(source: (self.model?.bookmarks[indexPath.row])!)
        cell.removeBookmark.addTarget(self, action: #selector(BookmarkViewController.removeBookmark), for: UIControlEvents.touchUpInside)
        cell.removeBookmark.tag = indexPath.row
        return cell
        
    }
}
