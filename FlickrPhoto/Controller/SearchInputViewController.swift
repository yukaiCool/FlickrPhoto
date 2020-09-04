//
//  SearchInputViewController.swift
//  FlickrPhoto
//
//  Created by 李御楷 on 2020/9/4.
//  Copyright © 2020 李御楷. All rights reserved.
//

import UIKit

class SearchInputViewController: UIViewController {

    @IBOutlet weak var navigationItemTitle: UINavigationItem!
    @IBOutlet weak var textFieldSearchTitle: UITextField!
    @IBOutlet weak var textFieldSearchCount: UITextField!
    @IBOutlet weak var buttonSearch: UIButton!
    
    let viewModel = SearchInputViewControllerViewModel()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI() // 設定UI
        setupTextField() // 設定TextField
        bindViewModel() // 建立Closure的接口
    }
    
    // MARK: - ---- 設定UI ----
    func setupUI() {
        navigationItem.title = NSLocalizedString("NavigationItemSearchInputTitle", comment: "")
        textFieldSearchTitle.placeholder = NSLocalizedString("TextFieldSearchInputPlaceHolderTitle", comment: "")
        textFieldSearchCount.placeholder = NSLocalizedString("TextFieldSearchInputPlaceHolderCount", comment: "")
        buttonSearch.setTitle(NSLocalizedString("ButtonSearchInputSearch", comment: ""), for: UIControl.State.normal)
        setupButton(isEnabled: false)
    }
    
    // MARK: - ---- 設定TextField ----
    func setupTextField() {
        textFieldSearchCount.keyboardType = .numberPad
        textFieldSearchCount.delegate = self
        textFieldSearchTitle.delegate = self
    }
    
    // MARK: - ---- 設定Button ----
    func setupButton(isEnabled: Bool) {
        buttonSearch.layer.cornerRadius = 8
        buttonSearch.isEnabled = isEnabled
        if isEnabled {
            buttonSearch.backgroundColor = .systemBlue
        } else {
            buttonSearch.backgroundColor = .gray
        }
    }
    
    // MARK: - ---- 建立Closure的接口 ----
    func bindViewModel() {
        // 取得照片結束
        viewModel.onGetEnd = { [weak self] model in
            DispatchQueue.main.async {
                self?.pushToSearchResultPage(model)
            }
        }
    }
    
    // MARK: - ---- 跳轉頁面 -----
    // MARK: 進入結果頁面
    func pushToSearchResultPage(_ model: Photos) {
        guard let controller = storyboard?.instantiateViewController(withIdentifier: StoryBoardID.SearchResultViewController.rawValue) as? SearchResultViewController else { return }
        controller.viewModel.photosModel = model
        navigationController?.pushViewController(controller, animated: true)
    }
    
    // MARK: - ---- Button ----
    // MARK 搜尋
    @IBAction func searchAction(_ sender: UIButton) {
        viewModel.getPhoto(searchName: textFieldSearchTitle.text ?? "", perPage: Int(textFieldSearchCount.text ?? "") ?? 10)
    }
    
}

// MARK: - ---- TextField Delegate ----
extension SearchInputViewController: UITextFieldDelegate {
    
    // MARK: 輸入文字時
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        // 只能輸入數字
        guard textField == textFieldSearchCount else { return true }
        let aSet = NSCharacterSet(charactersIn: "0123456789").inverted
        let compSepByCharInSet = string.components(separatedBy: aSet)
        let numberFiltered = compSepByCharInSet.joined(separator: "")
        
        return (string == numberFiltered)
    }
    
    // MARK: 輸入框文字改變時
    func textFieldDidChangeSelection(_ textField: UITextField) {
        guard (textFieldSearchTitle.text ?? "") != "" , (textFieldSearchCount.text ?? "") != "" else {
            print("1")
            setupButton(isEnabled: false)
            return
        }
        print("2")
        setupButton(isEnabled: true)
    }
    
    // MARK: 點擊return, 鍵盤消失
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        return true
    }
    
    // MARK: 點擊空白處, 鍵盤消失
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        self.view.endEditing(true)
    }
    
}
