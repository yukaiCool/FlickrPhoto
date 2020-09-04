//
//  SearchResultCollectionViewCell.swift
//  FlickrPhoto
//
//  Created by 李御楷 on 2020/9/4.
//  Copyright © 2020 李御楷. All rights reserved.
//

import UIKit
import Kingfisher

class SearchResultCollectionViewCell: UICollectionViewCell {
    
    enum FavoriteType: String {
        case Open = "FavoriteOpen"
        case Close = "FavoriteClose"
    }

    @IBOutlet weak var imagePhoto: UIImageView!
    @IBOutlet weak var labelTitle: UILabel!
    @IBOutlet weak var imageFavorite: UIButton!
    
    var model: Photo!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    
    // MARK: 設定UI
    func setupUI(model: Photo) {
        labelTitle.text = model.title
        
        if let url = URL(string: model.imageUrl) {
            imagePhoto.kf.setImage(with: url)
        }
        
        self.model = model
        
        if isExist() {
            imageFavorite.setImage(UIImage(named: FavoriteType.Open.rawValue), for: .normal)
        } else {
            imageFavorite.setImage(UIImage(named: FavoriteType.Close.rawValue), for: .normal)
        }
    }
    
    // MARK: 檢查是否有此筆資料
    func isExist() -> Bool {
        let localPhotos = UserDefaultsTool.getPhotos()
        let isExist = localPhotos.contains(where: { (local) -> Bool in
            local.id == model.id
        })
        return isExist
    }
    
    // MARK: 儲存資料
    func saveData() {
        var localPhotos = UserDefaultsTool.getPhotos()
        localPhotos.append(model)
        UserDefaultsTool.setPhotos(value: localPhotos)
    }
    
    // MARK: 刪除資料
    func deleteData() {
        var localPhotos = UserDefaultsTool.getPhotos()
        let index = localPhotos.firstIndex { (local) -> Bool in
            local.id == model.id
        }
        guard let deleteIndex = index else { return }
        localPhotos.remove(at: deleteIndex)
        UserDefaultsTool.setPhotos(value: localPhotos)
    }
    
    // MARK: - ---- Button ----
    @IBAction func clickFavorite(_ sender: UIButton) {
        if isExist() {
            imageFavorite.setImage(UIImage(named: FavoriteType.Close.rawValue), for: .normal)
            deleteData() // 刪除資料
        } else {
            imageFavorite.setImage(UIImage(named: FavoriteType.Open.rawValue), for: .normal)
            saveData() // 儲存資料
        }
        NotificationCenter.default.post(Notification(name: .updateFavorite))
    }
}
