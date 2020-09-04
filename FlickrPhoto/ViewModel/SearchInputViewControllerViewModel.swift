//
//  SearchInputViewControllerViewModel.swift
//  FlickrPhoto
//
//  Created by 李御楷 on 2020/9/4.
//  Copyright © 2020 李御楷. All rights reserved.
//

import Foundation

class SearchInputViewControllerViewModel {
    
    // on completion outputs
    var onGetEnd: ((Photos) -> Void)?
    
    // MARK: get photo
    func getPhoto(searchName: String, perPage: Int) {
        FilckrPhotpAPI.getPhoto(model: Photos(),searchName: searchName, page: 1, perPage: perPage) { (model) in
            print("Get Photo Success...")
            self.onGetEnd?(model)
        }
    }
    
}
