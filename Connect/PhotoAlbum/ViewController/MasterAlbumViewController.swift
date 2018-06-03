//
//  MasterAlbumController.swift
//  Connect
//
//  Created by James Kim on 6/3/18.
//  Copyright © 2018 James Kim. All rights reserved.
//

import UIKit
import Photos
import RxSwift

class MasterAlbumViewController: UIViewController, NameDescribable {
    // UI
    fileprivate var tableView: UITableView!
    
    init(photoSelectAction: @escaping ((UIImage)->())) {
        self.photoSelectAction = photoSelectAction
        super.init(nibName: nil, bundle: nil)
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        enterViewControllerMemoryLog(type: self.classForCoder)
        setupUI()
        setupVC()
        setupTableView()
        checkIfAuthorizedAndThenFetch()
    }
    
    deinit {
        leaveViewControllerMomeryLog(type: self.classForCoder)
    }
    
    // MARK: - Public/Internal
    
    // MARK: - Actions
    fileprivate func didSelectTableViewCell(atIndexPath indexPath: IndexPath) {
        // Segue to the selected type with data
        _ = dataSource.object(atIndexPath: indexPath)
    }
    
    fileprivate lazy var checkIfAuthorizedAndLoadPhotosIfSo: (Bool)->() = {[unowned self] (authorized)in
        if !authorized {
            self.presentDefaultError(message: "Access Denied", okAction: {
                self.dismiss(animated: true, completion: nil)
            })
        } else {
            self.fetchSampleAssets()
        }
    }
    
    // MARK: - Filepriavte
    fileprivate var dataSource: DefaultTableViewDataSource<MasterAlbumCell>!
    fileprivate let photoSelectAction:((UIImage)->())
    
    fileprivate var allPhoto: PHFetchResult<PHAsset>!
    fileprivate var smartAlbums: PHFetchResult<PHAssetCollection>!
    fileprivate var userCollections: PHFetchResult<PHCollection>!
    fileprivate let sampleOptions = PHFetchOptions.sampleFetch()
    fileprivate let targetSize = CGSize(width: 200, height: 200)
    
    fileprivate var allPhotoInfo: AlbumInfo!
    fileprivate var smartAlbumsInfo = [AlbumInfo]()
    fileprivate var userCollectionAlbumInfo = [AlbumInfo]()
    
    fileprivate let bag = DisposeBag()
    
    fileprivate func setupVC() {
        view.backgroundColor = .white
        navigationItem.title = "Albums"
    }
    
    fileprivate func setupTableView() {
        dataSource = DefaultTableViewDataSource<MasterAlbumCell>.init(tableView: tableView, parentViewController: self)
        tableView.delegate = self
    }
    
    fileprivate func checkIfAuthorizedAndThenFetch() {
        PHPhotoLibrary.authorized
            .skipWhile({$0 == false})
            .subscribe(onNext: checkIfAuthorizedAndLoadPhotosIfSo,
            onCompleted: observerDisposedDescription).disposed(by: bag)
    }
    
    fileprivate func fetchSampleAssets(){
        allPhoto = PHAsset.fetchAssets(with: .image, options: sampleOptions)
        smartAlbums = PHAssetCollection.fetchAssetCollections(with: .smartAlbum, subtype: .albumRegular, options: sampleOptions)
        userCollections = PHCollectionList.fetchTopLevelUserCollections(with: sampleOptions)
        
        let group = DispatchGroup()
        group.enter()
        AlbumInfo.fetchAndCreate(fromFetchResult: allPhoto, targetSize: targetSize, batchSize: 3, name: "All Photos", collection: nil) {[unowned self] (album) in
            group.leave()
            self.allPhotoInfo = album
        }
        
        for index in 0..<smartAlbums.count {
            group.enter()
            let collection = smartAlbums.object(at: index)
            let fetch = PHAsset.fetchAssets(in: collection, options: sampleOptions)
            AlbumInfo.fetchAndCreate(fromFetchResult: fetch, targetSize: targetSize, batchSize: 3, name: collection.localizedTitle!, collection: collection) {[unowned self] (album) in
                group.leave()
                self.smartAlbumsInfo.append(album)
            }
        }
        
        for index in 0..<userCollections.count {
            group.enter()
            let collection = userCollections.object(at: index)
            guard let assetCollection = collection as? PHAssetCollection else {continue}
            let fetch = PHAsset.fetchAssets(in: assetCollection, options: sampleOptions)
            AlbumInfo.fetchAndCreate(fromFetchResult: fetch, targetSize: targetSize, batchSize: 3, name: collection.localizedTitle.unwrapOr(defaultValue: "Undefined Name"), collection: assetCollection) {[unowned self] (album) in
                group.leave()
                self.userCollectionAlbumInfo.append(album)
            }
        }
        
        group.notify(queue: DispatchQueue.main) {[unowned self] in
            let objectDictionary = AlbumInfo.createObjectDictionary()
                .updateObject(atSection: 0, withData: [self.allPhotoInfo])
                .updateObject(atSection: 1, withData: self.smartAlbumsInfo)
                .updateObject(atSection: 2, withData: self.userCollectionAlbumInfo)
            
            self.dataSource.update(data: objectDictionary)
        }
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
extension MasterAlbumViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 90
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        didSelectTableViewCell(atIndexPath: indexPath)
    }
}

extension MasterAlbumViewController {
    fileprivate func setupUI() {
        tableView = UITableView(frame: .zero, style: .plain)
        view.addSubview(tableView)
        tableView.snp.makeConstraints { (make) in
            make.left.top.right.bottom.equalTo(view.safeAreaLayoutGuide)
        }
    }
}
