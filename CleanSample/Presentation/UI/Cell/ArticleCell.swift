//
//  ArticleCell.swift
//  CleanSample
//
//  Created by Akihko Okubo on 2016/11/14.
//  Copyright © 2016年 Akihko Okubo. All rights reserved.
//

import Foundation
import UIKit
import Kingfisher
import Bond

/* 
 記事セルに紐づけたクラスです。
 */
class ArticleCell : UITableViewCell {
    
    @IBOutlet weak var img: UIImageView!
    @IBOutlet weak var title: UILabel!
    @IBOutlet weak var userName: UILabel!
    @IBOutlet weak var bookmark: UIButton!
   
    func setUpCell(source:ArticleModel) {
        if let title = source.title {
            self.title.text = title
        }
        
        if let userName = source.name {
            self.userName.text = userName
        }
        
        if let urlstr = source.profileUrl {
            let url = URL(string: urlstr)
            self.img.kf.setImage(with: url)
        }
        
        //ボタンのtilteプロパティにブックマーク状態をバインドします
        source.bookmarkStatusLabel.bind(to: self.bookmark.bnd_title)
    }
}
