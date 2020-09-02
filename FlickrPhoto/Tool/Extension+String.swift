//
//  Extension+String.swift
//  FlickrPhoto
//
//  Created by 李御楷 on 2020/9/2.
//  Copyright © 2020 李御楷. All rights reserved.
//

import Foundation
extension String {
    func getCleanedURL() -> URL? {
       guard self.isEmpty == false else {
           return nil
       }
       if let url = URL(string: self) {
           return url
       } else {
           if let urlEscapedString = self.addingPercentEncoding(withAllowedCharacters: CharacterSet.urlQueryAllowed) , let escapedURL = URL(string: urlEscapedString){
               return escapedURL
           }
       }
       return nil
    }
}
