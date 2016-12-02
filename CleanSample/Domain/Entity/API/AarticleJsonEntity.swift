//
//  AarticleJsonModel.swift
//  CleanSample
//
//  Created by Akihko Okubo on 2016/11/14.
//  Copyright © 2016年 Akihko Okubo. All rights reserved.
//

import Foundation
import SwiftyJSON

/* 記事JSONをマッピングするEntityです。 */
class AarticleJsonEntity {
    
    var id:String?
    var title:String?
    var profile_image_url:String?
    var name:String?
    var url:String?
    
    init() {}
    
    init(_ json :JSON) {
        self.id = json["id"].string
        self.title = json["title"].string
        self.name = json["user"]["name"].string
        self.url = json["url"].string
        self.profile_image_url = json["user"]["profile_image_url"].string
    }

}
