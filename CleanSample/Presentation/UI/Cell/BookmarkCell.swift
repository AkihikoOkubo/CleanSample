
//
//  BookmarkCell.swift
//  CleanSample
//
//  Created by Akihko Okubo on 2016/11/17.
//  Copyright © 2016年 Akihko Okubo. All rights reserved.
//

import Foundation
import UIKit

class BookmarkCell : UITableViewCell {
    
    @IBOutlet weak var profileImg: UIImageView!
    @IBOutlet weak var title: UILabel!
    @IBOutlet weak var name: UILabel!
    @IBOutlet weak var removeBookmark: UIButton!
    
    func setUpCell(source:BookmarkModel) {
        
        if let title = source.title {
            self.title.text = title
        }
        
        if let userName = source.name {
            self.name.text = userName
        }
        
        if let urlstr = source.profileUrl {
            let url = URL(string: urlstr)
            self.profileImg.kf.setImage(with: url)
        }
        
        
    }
    
    
}
