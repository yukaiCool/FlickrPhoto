//
//  SearchResultViewControllerViewModel.swift
//  FlickrPhoto
//
//  Created by 李御楷 on 2020/9/4.
//  Copyright © 2020 李御楷. All rights reserved.
//

import Foundation

class SearchResultViewControllerViewModel {
    
    // Model
    var photosModel: Photos = Photos()
    var searchName: String = ""
    var isDownloading: Bool = false
    
    // on completion outputs
    var onGetEnd: (() -> Void)?
    
    // MARK: get photo
    func getPhoto(model: Photos, page: Int, perPage: Int) {
        isDownloading = true
        FilckrPhotpAPI.getPhoto(model: model,searchName: searchName, page: page, perPage: perPage) { (model) in
            print("Get Photo Success...")
            self.photosModel = model
            self.isDownloading = false
            self.onGetEnd?()
        }
    }
    
    // MARK: 檢查是否需要加載圖片
    func checkDownload(indexPath: IndexPath) {
        guard !isDownloading, indexPath.row == (photosModel.photo.count - 1), photosModel.page+1 <= photosModel.pages else { return }
        getPhoto(model: photosModel, page: photosModel.page+1, perPage: photosModel.perpage)
    }
}
