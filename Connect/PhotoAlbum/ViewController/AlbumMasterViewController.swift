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

class AlbumMasterViewController: UIViewController, NameDescribable {
    
    enum Section: Int {
        case allPhotos = 0
        case smartAlbums = 1
        case userCollections = 2
        case all
    }
    
    struct Keys {
        static let fetch = "fetch"
        static let collection = "collection"
    }
    
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
        observePhotoChanges()
    }
    
    deinit {
        leaveViewControllerMomeryLog(type: self.classForCoder)
    }
    
    // MARK: - Public/Internal
    
    // MARK: - Actions
    fileprivate func didSelectTableViewCell(atIndexPath indexPath: IndexPath) {
        // Segue to the selected type with data
        guard let indexPath = tableView.indexPathForSelectedRow else {assertionFailure();return}
        var userInfo = [String:Any]()
        let section = Section(rawValue: indexPath.section)!
        let option = PHFetchOptions.fetchOption(configure: {
            $0.sortDescriptors = [NSSortDescriptor(key: PHFetchOptions.Key.creationDate, ascending: true)]
        })
        switch section {
        case .allPhotos:
            userInfo[Keys.fetch] = PHAsset.fetchAssets(with: .image, options: option)
        case .smartAlbums, .userCollections:
            let collection = dataSource.object(atIndexPath: indexPath).assetCollection!
            userInfo[Keys.fetch] = PHAsset.fetchAssets(in: collection, options: option)
            userInfo[Keys.collection] = collection
        default: assertionFailure()
        }
        
        presentDefaultVC(targetVC: AlbumDetailViewController(photoSelectAction: photoSelectAction), userInfo: userInfo)
    }
    
    fileprivate lazy var observePhotoAcceessPermission: (Bool)->() = {[unowned self] (authorized)in
        if authorized {
            guard self.needToFetchSample else {return}
            self.fetchSampleAssets()
        } else {
            self.presentDefaultError(message: "Access Denied", okAction: {self.dismiss(animated: true, completion: nil)})
        }
    }
    
    // MARK: - Filepriavte
    fileprivate var dataSource: DefaultTableViewDataSource<MasterAlbumCell>!
    fileprivate let photoSelectAction:((UIImage)->())
    
    fileprivate var allPhoto: PHFetchResult<PHAsset>!
    fileprivate var smartAlbums: PHFetchResult<PHAssetCollection>!
    fileprivate var userCollections: PHFetchResult<PHCollection>!
    fileprivate let targetSize = CGSize(width: 200, height: 200)
    fileprivate let sampleOption = PHFetchOptions.fetchOption(configure: {
        $0.sortDescriptors = [NSSortDescriptor(key: PHFetchOptions.Key.creationDate, ascending: false)]})
    
    fileprivate var allPhotoInfo = [AlbumInfo]()
    fileprivate var smartAlbumInfo = [AlbumInfo]()
    fileprivate var userCollectionAlbumInfo = [AlbumInfo]()
    fileprivate var needToFetchSample = true
    
    fileprivate let bag = DisposeBag()
    
    fileprivate func setupVC() {
        view.backgroundColor = .white
        navigationItem.title = "Albums"
    }
    
    fileprivate func setupTableView() {
        tableView.delegate = self
        dataSource = DefaultTableViewDataSource<MasterAlbumCell>.init(tableView: tableView, parentViewController: self)
    }
    
    fileprivate func checkIfAuthorizedAndThenFetch() {
        PHPhotoLibrary.authorized
            .skip(1)
            .subscribe(onNext: observePhotoAcceessPermission,
            onCompleted: observerDisposedDescription).disposed(by: bag)
    }
    
    fileprivate func fetchSampleAssets(){
        guard needToFetchSample else {return}
        needToFetchSample = false
        
        allPhoto = PHAsset.fetchAssets(with: .image, options: sampleOption)
        smartAlbums = PHAssetCollection.fetchAssetCollections(with: .smartAlbum, subtype: .albumRegular, options: nil)
        userCollections = PHCollectionList.fetchTopLevelUserCollections(with: nil)
        
        fetchAllPhoto(fetchResult: allPhoto)
        fetchSmartAlbums(fetchResult: smartAlbums)
        fetchUserCollection(fetchResult: userCollections)
        
        createObjectDictionaryAndUpdateDataSource(forSection: .all)
    }
    
    fileprivate func fetchAllPhoto(fetchResult: PHFetchResult<PHAsset>) {
        allPhotoInfo.removeAll()
        AlbumInfo.fetchAndCreate(fromFetchResult: fetchResult, targetSize: targetSize, batchSize: 3, name: "All Photos", collection: nil) {[unowned self] (album) in
            self.allPhotoInfo.append(album)
        }
    }
    
    fileprivate func fetchSmartAlbums(fetchResult: PHFetchResult<PHAssetCollection>) {
        smartAlbumInfo.removeAll()
        for index in 0..<fetchResult.count {
            let collection = fetchResult.object(at: index)
            let fetch = PHAsset.fetchAssets(in: collection, options: sampleOption)
            AlbumInfo.fetchAndCreate(fromFetchResult: fetch, targetSize: targetSize, batchSize: 3, name: collection.localizedTitle!, collection: collection) {[unowned self] (album) in
                if album.name != "Videos" && album.name != "All Photos" && album.name != "Camera Roll"  {
                    self.smartAlbumInfo.append(album)
                }
            }
        }
    }
    
    fileprivate func fetchUserCollection(fetchResult: PHFetchResult<PHCollection>) {
        userCollectionAlbumInfo.removeAll()
        for index in 0..<fetchResult.count {
            let collection = fetchResult.object(at: index)
            guard let assetCollection = collection as? PHAssetCollection else {continue}
            let fetch = PHAsset.fetchAssets(in: assetCollection, options: sampleOption)
            AlbumInfo.fetchAndCreate(fromFetchResult: fetch, targetSize: targetSize, batchSize: 3, name: collection.localizedTitle.unwrapOr(defaultValue: "Undefined Name"), collection: assetCollection) {[unowned self] (album) in
                self.userCollectionAlbumInfo.append(album)
            }
        }
    }
    
    fileprivate func createObjectDictionaryAndUpdateDataSource(forSection section: Section) {
        var objectDictionary = AlbumInfo.createObjectDictionary()
        
        switch section {
        case .allPhotos:
            objectDictionary = objectDictionary.updateObject(atSection: section.rawValue, withData: allPhotoInfo)
            dataSource.update(data: objectDictionary, atSection: section.rawValue)
        case .smartAlbums:
            objectDictionary = objectDictionary.updateObject(atSection: section.rawValue, withData: smartAlbumInfo)
            dataSource.update(data: objectDictionary, atSection: section.rawValue)
        case .userCollections:
            objectDictionary = objectDictionary.updateObject(atSection: section.rawValue, withData: userCollectionAlbumInfo)
            dataSource.update(data: objectDictionary, atSection: section.rawValue)
        case .all:
            objectDictionary = objectDictionary
                .updateObject(atSection: Section.allPhotos.rawValue, withData: allPhotoInfo)
                .updateObject(atSection: Section.smartAlbums.rawValue, withData: smartAlbumInfo)
                .updateObject(atSection: Section.userCollections.rawValue, withData: userCollectionAlbumInfo)
            dataSource.update(data: objectDictionary)
        }
    }
    
    fileprivate func observePhotoChanges() {
        PHPhotoLibrary.shared().register(self)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
extension AlbumMasterViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 90
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        didSelectTableViewCell(atIndexPath: indexPath)
        tableView.deselectRow(at: indexPath, animated: false)
    }
}
extension AlbumMasterViewController:PHPhotoLibraryChangeObserver {
    func photoLibraryDidChange(_ changeInstance: PHChange) {
        DispatchQueue.performOnMain {[unowned self] in
            if let changeDetails = changeInstance.changeDetails(for: self.allPhoto) {
                self.allPhoto = changeDetails.fetchResultAfterChanges
                self.fetchAllPhoto(fetchResult: changeDetails.fetchResultAfterChanges)
                self.createObjectDictionaryAndUpdateDataSource(forSection: .allPhotos)
            }
            
            if let changeDetails = changeInstance.changeDetails(for: self.smartAlbums) {
                self.smartAlbums = changeDetails.fetchResultAfterChanges
                self.fetchSmartAlbums(fetchResult: changeDetails.fetchResultAfterChanges)
                self.createObjectDictionaryAndUpdateDataSource(forSection: .smartAlbums)
            }
            
            if let changeDetails = changeInstance.changeDetails(for: self.userCollections) {
                self.userCollections = changeDetails.fetchResultAfterChanges
                self.fetchUserCollection(fetchResult: changeDetails.fetchResultAfterChanges)
                self.createObjectDictionaryAndUpdateDataSource(forSection: .userCollections)
            }
        }
    }
}

extension AlbumMasterViewController {
    fileprivate func setupUI() {
        tableView = UITableView(frame: .zero, style: .plain)
        tableView.separatorStyle = .none
        view.addSubview(tableView)
        tableView.snp.makeConstraints { (make) in
            make.left.top.right.bottom.equalTo(view.safeAreaLayoutGuide)
        }
    }
}
