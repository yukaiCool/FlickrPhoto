//
//  Photos.swift
//  FlickrPhoto
//
//  Created by 李御楷 on 2020/9/2.
//  Copyright © 2020 李御楷. All rights reserved.
//

import Foundation

struct Photos {
    var page: Int = 0
    var pages: Int = 0
    var perpage: Int = 0
    var total: String = ""
    var photo: [Photo] = [Photo]()
}

struct Photo {
    var id: String = ""
    var owner: String = ""
    var secret: String = ""
    var server: String = ""
    var farm: Int = 0
    var title: String = ""
    var ispublic: Bool = true
    var isfriend: Bool = true
    var isfamily: Bool = true
    var imageUrl: URL {
        return URL(string: "https://farm\(farm).staticflickr.com/\(server)/\(id)_\(secret)_m.jpg")!
    }
}
