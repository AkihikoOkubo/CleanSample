//
//  APIRequest.swift
//  CleanSample
//
//  Created by Akihko Okubo on 2016/11/15.
//  Copyright © 2016年 Akihko Okubo. All rights reserved.
//

import Foundation
import Alamofire
import SwiftyJSON

/* APIリクエストの実装が散らばるとメンテが面倒なので、このクラスに集積します。 */
class APIRequest : NSObject {
    
    //APIをコールして、JSONをEntityにマッピングしてから返します。
    //コールバックに保持する変数がこの関数のスコープをはみ出すので、@escapingをつけます。
    func getArticle(callback:@escaping ( [AarticleJsonEntity]?,Error?) -> Void){
        
        Alamofire.request("http://qiita.com/api/v2/items").responseJSON{response in
            
            if let object = response.result.value {
                
                switch(response.result) {
                case .success(_):
                    let result = JSON(object).map{(_, json) in
                        AarticleJsonEntity(json)
                    }
                    callback(result , nil)
                    
                    break
                case .failure(_):
                    //サンプルなので取りあえずにします。
                    callback(nil, SampleError.notAuthorized)
                    break
                }
                
            } else {
                callback(nil, SampleError.network)
            }
        }
    }
    
}
