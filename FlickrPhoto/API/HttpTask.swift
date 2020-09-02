//
//  HttpTask.swift
//  FlickrPhoto
//
//  Created by 李御楷 on 2020/9/2.
//  Copyright © 2020 李御楷. All rights reserved.
//

import Foundation

enum HttpMethod: String {
    case Post = "POST"
    case Get = "GET"
    case Delete = "DELETE"
    case Put = "PUT"
}

class HttpTask {
    // 建立Request
    class func setupRequest(url: URL, body: [String:Any], header: [String:String], httpMethod: HttpMethod) -> URLRequest {
        
        // API
        var request = URLRequest(url: url)
        // Body
        if body.count > 0 {
             let data = try! JSONSerialization.data(withJSONObject: body, options: .prettyPrinted)
             request.httpBody = data
         }
        
        // Header
        if header.count > 0 {
            for header in header {
                request.addValue(header.value, forHTTPHeaderField: header.key)
            }
        }
        
        // Http Method
        request.httpMethod = httpMethod.rawValue
        
        return request
    }
    
    // Https 任務
    class func dataTask(url: URL, body: [String:Any], header: [String:String], httpMethod: HttpMethod, competion: @escaping(_ resultArray: [String:Any]) -> Void) {
        
        // request
        let request = setupRequest(url: url, body: body, header: header, httpMethod: httpMethod)
        
        //設定委任對象為自己
        let session = URLSession.shared
        //設定下載網址
        let dataTask = session.dataTask(with: request){(data, response, error) in
            if error == nil{
                if let resultArray = try? (JSONSerialization.jsonObject(with: data!, options: .allowFragments)) as? [String:Any]{
                    
                    competion(resultArray)
                    
                }else{
                    print("No resultArray...")
                }
            }else{
                competion([String:Any]())
                print("Error \(url.lastPathComponent) :\(String(describing: error))")
            }
        }
        //啟動或重新啟動下載動作
        dataTask.resume()
    }
}
