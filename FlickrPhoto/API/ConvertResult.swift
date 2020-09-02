//
//  ConvertResult.swift
//  FlickrPhoto
//
//  Created by 李御楷 on 2020/9/2.
//  Copyright © 2020 李御楷. All rights reserved.
//

import Foundation

class ConvertResult {
    // Filckr photo json to model
    class func photoToModel(result: [String:Any]) -> Photos {
        var model = Photos()
        model.page = result["page"] as? Int ?? 0
        model.pages = result["pages"] as? Int ?? 0
        model.perpage = result["perpage"] as? Int ?? 0
        model.total = result["total"] as? String ?? ""
        if let photos = result["photo"] as? [[String:Any]] {
            for photo in photos {
                var photoModel = Photo()
                photoModel.id = photo["id"] as? String ?? ""
                photoModel.owner = photo["owner"] as? String ?? ""
                photoModel.secret = photo["secret"] as? String ?? ""
                photoModel.server = photo["server"] as? String ?? ""
                photoModel.farm = photo["farm"] as? Int ?? 0
                photoModel.title = photo["title"] as? String ?? ""
                photoModel.ispublic = (photo["ispublic"] as? Int ?? 0) == 1 ? true : false
                photoModel.isfriend = (photo["isfriend"] as? Int ?? 0) == 1 ? true : false
                photoModel.isfamily = (photo["isfamily"] as? Int ?? 0) == 1 ? true : false
                
                model.photo.append(photoModel)
            }
        }
        return model
    }
}
