//
//  File.swift
//  FlickrPhoto
//
//  Created by 李御楷 on 2020/9/4.
//  Copyright © 2020 李御楷. All rights reserved.
//

import Foundation

class UserDefaultsTool {
    
    // MARK: - ---- Photo Data ----
    class func getPhotos() -> [Photo] {
        guard let data = UserDefaults.standard.value(forKey: "Photos") as? Data, let decode = try? JSONDecoder().decode([Photo].self, from: data) else { return [Photo]() }
        return decode
    }
    class func setPhotos(value: [Photo]) {
        guard let encode = try? JSONEncoder().encode(value) else { return }
        UserDefaults.standard.set(encode, forKey: "Photos")
    }
    
    // MARK: - ----  ----
    //
}
