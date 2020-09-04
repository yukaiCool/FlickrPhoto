//
//  FavouritesViewController.swift
//  FlickrPhoto
//
//  Created by 李御楷 on 2020/9/4.
//  Copyright © 2020 李御楷. All rights reserved.
//

import UIKit

class FavouritesViewController: UIViewController {
    
    @IBOutlet weak var navigationItemTitle: UINavigationItem!
    @IBOutlet weak var collectionView: UICollectionView!
    
    let viewModel = FavouritesViewControllerViewModel()
    
    override func viewWillAppear(_ animated: Bool) {
        // 通知事件 - 更新我的最愛
        NotificationCenter.default.addObserver(self, selector: #selector(updateFavorite), name: .updateFavorite, object: nil)
        update() // 立即更新
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        // 取消NotificationCenter
        NotificationCenter.default.removeObserver(self, name: .updateFavorite, object: nil)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        registerCell() // 註冊Cell
        setupUI() // 設定ＵＩ
    }
    
    // MARK: - ---- 設定ＵＩ ----
    func setupUI() {
        navigationItemTitle.title = NSLocalizedString("NavigationItemFavouritesTitle", comment: "")
    }
    
    // MARK: - ---- 通知事件 ----
    // MARK: 更新我的最愛
    @objc func updateFavorite(notification: Notification){
        update()
    }
    
    // MARK: - ---- 更新我的最愛 ----
    func update() {
        viewModel.photosModel.photo = UserDefaultsTool.getPhotos()
        collectionView.reloadData()
    }
}

// MARK: - ---- CollectionView Delegate & Datasource ----
extension FavouritesViewController: UICollectionViewDelegate, UICollectionViewDataSource {
    
    // MARK: 註冊Cell
    func registerCell() {
        let itemNib = UINib(nibName: CollectionViewCellName.SearchResultCollectionViewCell.rawValue, bundle: nil)
        collectionView.register(itemNib, forCellWithReuseIdentifier: CollectionViewCellID.ResultCell.rawValue)
        
        collectionView.delegate = self
        collectionView.dataSource = self
        collectionView.setCollectionViewLayout(settingFlowLayout(), animated: true)
    }
    
    // MARK: 設定Collection View Flow Layout
    func settingFlowLayout() -> UICollectionViewFlowLayout{
        let layout = UICollectionViewFlowLayout()
        let fullScreenSize = UIScreen.main.bounds
        // 設置 Section 的間距 四個數值分別是上 下 左 右的間距
        layout.sectionInset = UIEdgeInsets(top: 15, left: 15, bottom: 15, right: 15)
        
        // 設置每一行的間距
        layout.minimumLineSpacing = 5
        
        // 設置每個 cell 的尺寸
        let width: CGFloat = CGFloat((fullScreenSize.width-45)/2)
        layout.itemSize = CGSize(width: width, height: width)
        
        // 設置水平滑動方向
        layout.scrollDirection = UICollectionView.ScrollDirection.vertical
        
        return layout
    }
    
    // MARK: Cell 數量
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return viewModel.photosModel.photo.count
    }
    
    // MARK: Cell 內容
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: CollectionViewCellID.ResultCell.rawValue, for: indexPath) as? SearchResultCollectionViewCell else { return UICollectionViewCell() }
        cell.setupUI(model: viewModel.photosModel.photo[indexPath.row])
        return cell
    }
}
