//
//  FilckrPhotoAPI.swift
//  FlickrPhoto
//
//  Created by 李御楷 on 2020/9/2.
//  Copyright © 2020 李御楷. All rights reserved.
//

import Foundation

class FilckrPhotpAPI {
    // get photo
    class func getPhoto(searchName: String, page: Int, perPage: Int, competion: @escaping(_ model: Photos) -> Void){
        //API
        let apiUrl = "https://api.flickr.com/services/rest/?method=flickr.photos.search&api_key=6984564584b66299131263b59efcfe7f&text=\(searchName)&page=\(page)&per_page=\(perPage)&format=json&nojsoncallback=1"
        guard let url = apiUrl.getCleanedURL() else { return }
        let body = [:] as [String:Any]
        let header = [:] as [String:String]
        HttpTask.dataTask(url: url, body: body, header: header, httpMethod: .Get) { (resultArray) in
            let result = resultArray["photos"] as? [String:Any] ?? [String:Any]()
            competion(ConvertResult.photoToModel(result: result))
        }
    }
}
