//
//  Network.swift
//  iOS_basics
//
//  Created by Arnaud SCHEID on 10/12/2020.
//

import Foundation
import Alamofire

struct NetworkManager {
    
    func loadNews() {
        AF.request("https:/cryptopanic.com/api/v1/posts/?auth_token=2c4271824c1b7d9d8c7f0264f16222ed0c52fd8c&public=true")
            .responseData { response in
                if let data = response.data {
                    AppManager.news.news = try! JSONDecoder().decode(News.self, from: data)
                }
                
            }
    }
    
}
