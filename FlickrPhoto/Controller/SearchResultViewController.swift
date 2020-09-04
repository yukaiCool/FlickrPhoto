//
//  SearchResultViewController.swift
//  FlickrPhoto
//
//  Created by 李御楷 on 2020/9/4.
//  Copyright © 2020 李御楷. All rights reserved.
//

import UIKit

class SearchResultViewController: UIViewController {
    
    @IBOutlet weak var navigationItemTitle: UINavigationItem!
    @IBOutlet weak var collectionView: UICollectionView!
    
    let viewModel = SearchResultViewControllerViewModel()

    override func viewDidLoad() {
        super.viewDidLoad()
        registerCell() // 註冊Cell
        bindViewModel() // 建立Closure的接口
        setupRefresh() // 設定TableView refresh
        setupUI() // 設定UI
    }
    
    // MARK: - ---- 設定UI ----
    func setupUI() {
        navigationItemTitle.title = NSLocalizedString("NavigationItemSearchResultTitle", comment: "") + " " + viewModel.searchName
    }
    
    // MARK: - ---- 設定Collection refresh ----
    func setupRefresh() {
        //添加刷新
        let refreshControl = UIRefreshControl()
        refreshControl.tintColor = UIColor.black
        refreshControl.backgroundColor = UIColor(hexString: "#F4F6FA")
        refreshControl.addTarget(self, action: #selector(getData), for: UIControl.Event.valueChanged)
        collectionView.refreshControl = refreshControl
    }
    
    // MARK: 更新資料
    @objc func getData() {
        viewModel.getPhoto(model: Photos(), page: 1, perPage: viewModel.photosModel.perpage)
    }
    
    // MARK: - ---- 建立Closure的接口 ----
    func bindViewModel() {
        // 取得照片結束
        viewModel.onGetEnd = { [weak self] in
            DispatchQueue.main.async {
                self?.collectionView.reloadData()
                self?.collectionView.refreshControl?.endRefreshing()
            }
        }
    }

}

// MARK: - ---- CollectionView Delegate & Datasource ----
extension SearchResultViewController: UICollectionViewDelegate, UICollectionViewDataSource {
    
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
        viewModel.checkDownload(indexPath: indexPath)
        return cell
    }
}
