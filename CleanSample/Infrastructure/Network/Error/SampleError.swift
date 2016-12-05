//
//  SampleError.swift
//  CleanSample
//
//  Created by Akihko Okubo on 2016/11/15.
//  Copyright © 2016年 Akihko Okubo. All rights reserved.
//

import Foundation

/*
 Repositoryの関数の実行時に想定されるエラーを定義したEnumです。
 Errorプロトコルに準拠します。
 */
enum SampleError: Error {
    
    /*
     UseCaseからRepositoryの実装を隠蔽するために汎用的なエラーに変換します。
     例えば、web-APIの実行で404が返却された場合と、Realmの検索の結果該当行がない場合は、等しく「noData」として扱います。
     */
    
    //データなし
    case noData
    
    //疎通エラー
    case network
    
    //認証エラー
    case notAuthorized
    
    //認可エラー
    case permissionDenied
    
    //対向先のシステムエラー
    case providerError
    
    //その他のエラー
    case generic
    
}
