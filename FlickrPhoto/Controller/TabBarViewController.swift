//
//  TabBarViewController.swift
//  FlickrPhoto
//
//  Created by 李御楷 on 2020/9/4.
//  Copyright © 2020 李御楷. All rights reserved.
//

import UIKit

class TabBarViewController: UITabBarController {

    override func viewDidLoad() {
        super.viewDidLoad()
        tabBar.items?[0].title = NSLocalizedString("TabBarFeaturedTitle", comment: "")
        tabBar.items?[1].title = NSLocalizedString("TabBarFavouritesTitle", comment: "")
    }

}
