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

    @IBOutlet weak var imagePhoto: UIImageView!
    @IBOutlet weak var labelTitle: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    
    // MARK: 設定UI
    func setupUI(model: Photo) {
        labelTitle.text = model.title
        imagePhoto.kf.setImage(with: model.imageUrl)
    }

}
