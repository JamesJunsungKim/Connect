//
//  AlbumDetailViewController.swift
//  Connect
//
//  Created by James Kim on 6/3/18.
//  Copyright © 2018 James Kim. All rights reserved.
//

import UIKit
import Photos

class AlbumDetailViewController: DefaultViewController {
    // UI
    fileprivate var collectionView: UICollectionView!
    fileprivate var doneButton: UIBarButtonItem!
    
    init(photoSelectAction: @escaping ((UIImage)->())) {
        self.photoSelectAction = photoSelectAction
        super.init(nibName: nil, bundle: nil)
    }
    
    func setup(fromVC: UIViewController, userInfo: [String : Any]?) {
        let collectionKey = AlbumMasterViewController.Keys.collection
        let fetchKey = AlbumMasterViewController.Keys.fetch
        
        if let collection = userInfo?[collectionKey] as? PHAssetCollection {
            assetCollection = collection
        }
        fetchResult = userInfo![fetchKey]! as? PHFetchResult<PHAsset>
        
        // ViewDidLoad
        enterViewControllerMemoryLog(type: self.classForCoder)
        setupUI()
        setupVC()
        setupCollectionView()
        resetCachedAssets()
    }

    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        updateCachedAssets()
    }
    
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        updateCachedAssets()
    }
    
    deinit {
        leaveViewControllerMomeryLog(type: self.classForCoder)
        PHPhotoLibrary.shared().unregisterChangeObserver(self)
    }
    
    // MARK: - Public
    
    
    // MARK: - Actions
    
    @objc fileprivate func doneBtnClicked() {
        selectedPhotos.forEach(photoSelectAction)
        navigationController?.dismiss(animated: true, completion: nil)
    }
    
    fileprivate func didSelectCollectionViewItem(atIndexPath indexPath: IndexPath) {
        let cell_ = cell(forIndexPath: indexPath)
        cell_.didGetSelected()
        _ = selectedPhotos.insert(cell_.albumImageView.image!)
        enableOrDisableDoneButton()
    }
    
    fileprivate func didDeSelectCollectionViewItem(atIndexPath indexPath: IndexPath) {
        let cell_ = cell(forIndexPath: indexPath)
        cell_.didGetDeselected()
        _ = selectedPhotos.remove(cell_.albumImageView.image!)
        enableOrDisableDoneButton()
    }
    
    // MARK: - Fileprivate
    fileprivate var fetchResult: PHFetchResult<PHAsset>!
    fileprivate var assetCollection: PHAssetCollection!
    fileprivate let photoSelectAction: ((UIImage)->())
    fileprivate var selectedPhotos = Set<UIImage>()
    
    fileprivate var thumbnailSize: CGSize!
    fileprivate var previousPreheatRect = CGRect.zero
    fileprivate let imageManager = PHCachingImageManager()
    
    fileprivate func setupVC() {
        view.backgroundColor = .white
        PHPhotoLibrary.shared().register(self)
        doneButton = UIBarButtonItem(title: "Done", style: .plain, target: self, action: #selector(doneBtnClicked))
        navigationItem.rightBarButtonItem = doneButton
        enableOrDisableDoneButton()
    }
    
    fileprivate func setupCollectionView() {
        thumbnailSize = CGSize(width: 200, height: 200)
        
        collectionView.delegate = self
        collectionView.dataSource = self
        collectionView.register(AlbumDetailCell.self, forCellWithReuseIdentifier: AlbumDetailCell.reuseIdentifier)
        collectionView.allowsMultipleSelection = true
        collectionView.alwaysBounceVertical = true
        
        collectionView.reloadData()
    }
    
    fileprivate func resetCachedAssets() {
        imageManager.stopCachingImagesForAllAssets()
        previousPreheatRect = .zero
    }
    
    fileprivate func updateCachedAssets() {
        guard isViewLoaded && view.window != nil else { return }
        
        let visibleRect = CGRect(origin: collectionView!.contentOffset, size: collectionView!.bounds.size)
        let preheatRect = visibleRect.insetBy(dx: 0, dy: -0.5 * visibleRect.height)
        
        let delta = abs(preheatRect.midY - previousPreheatRect.midY)
        guard delta > view.bounds.height / 3 else { return }
        
        let (addedRects, removedRects) = differencesBetweenRects(previousPreheatRect, preheatRect)
        let addedAssets = addedRects
            .flatMap { rect in collectionView!.indexPathsForElements(in: rect) }
            .map { indexPath in fetchResult.object(at: indexPath.item) }
        let removedAssets = removedRects
            .flatMap { rect in collectionView!.indexPathsForElements(in: rect) }
            .map { indexPath in fetchResult.object(at: indexPath.item) }
        
        imageManager.startCachingImages(for: addedAssets,
                                        targetSize: thumbnailSize, contentMode: .aspectFill, options: nil)
        imageManager.stopCachingImages(for: removedAssets,
                                       targetSize: thumbnailSize, contentMode: .aspectFill, options: nil)
        
        previousPreheatRect = preheatRect
    }
    
    fileprivate func differencesBetweenRects(_ old: CGRect, _ new: CGRect) -> (added:[CGRect], removed:[CGRect]) {
        if old.intersects(new) {
            var added = [CGRect]()
            if new.maxY > old.maxY {
                added += [CGRect(x: new.origin.x, y: old.maxY,
                                 width: new.width, height: new.maxY - old.maxY)]
            }
            if old.minY > new.minY {
                added += [CGRect(x: new.origin.x, y: new.minY,
                                 width: new.width, height: old.minY - new.minY)]
            }
            var removed = [CGRect]()
            if new.maxY < old.maxY {
                removed += [CGRect(x: new.origin.x, y: new.maxY,
                                   width: new.width, height: old.maxY - new.maxY)]
            }
            if old.minY < new.minY {
                removed += [CGRect(x: new.origin.x, y: old.minY,
                                   width: new.width, height: new.minY - old.minY)]
            }
            return (added, removed)
        } else {
            return ([new], [old])
        }
    }
    
    fileprivate func cell(forIndexPath indexPath:IndexPath) -> AlbumDetailCell {
        return (collectionView.cellForItem(at: indexPath) as! AlbumDetailCell)
    }
    
    fileprivate func enableOrDisableDoneButton() {
        doneButton.isEnabled = selectedPhotos.count != 0
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}
extension AlbumDetailViewController: UICollectionViewDelegate, UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return fetchResult.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let asset = fetchResult.object(at: indexPath.item)
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: AlbumDetailCell.reuseIdentifier, for: indexPath) as! AlbumDetailCell
        cell.representedAssetIdentifier = asset.localIdentifier
        
        imageManager.requestImage(for: asset, targetSize: thumbnailSize, contentMode: .aspectFill, options: nil, resultHandler: { image, _ in
            if cell.representedAssetIdentifier == asset.localIdentifier {
                cell.albumImageView.image = image
            }
        })
        
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        didSelectCollectionViewItem(atIndexPath: indexPath)
    }
    func collectionView(_ collectionView: UICollectionView, didDeselectItemAt indexPath: IndexPath) {
        didDeSelectCollectionViewItem(atIndexPath: indexPath)
    }
}

extension AlbumDetailViewController: PHPhotoLibraryChangeObserver {
    func photoLibraryDidChange(_ changeInstance: PHChange) {
        
        guard let changes = changeInstance.changeDetails(for: fetchResult) else {return}
        
        DispatchQueue.main.sync {
            fetchResult = changes.fetchResultAfterChanges
            if changes.hasIncrementalChanges {
                guard let collectionView = self.collectionView else {return}
                collectionView.performBatchUpdates({
                    if let removed = changes.removedIndexes, removed.count > 0 {
                        collectionView.deleteItems(at: removed.map({ IndexPath(item: $0, section: 0) }))
                    }
                    if let inserted = changes.insertedIndexes, inserted.count > 0 {
                        collectionView.insertItems(at: inserted.map({ IndexPath(item: $0, section: 0) }))
                    }
                    if let changed = changes.changedIndexes, changed.count > 0 {
                        collectionView.reloadItems(at: changed.map({ IndexPath(item: $0, section: 0) }))
                    }
                    changes.enumerateMoves { fromIndex, toIndex in
                        collectionView.moveItem(at: IndexPath(item: fromIndex, section: 0),
                                                to: IndexPath(item: toIndex, section: 0))
                    }
                }, completion: nil)
            } else {
                collectionView.reloadData()
            }
            resetCachedAssets()
        }
    }
}

extension AlbumDetailViewController {
    
    fileprivate func setupUI() {
        let width = (view.frame.width-3) / 4
        collectionView = UICollectionView.create(backgroundColor: .white, configuration: { (layout) in
            layout.itemSize = CGSize(width: width, height: width)
            layout.minimumLineSpacing = 1
            layout.minimumInteritemSpacing = 1
        })

        view.addSubview(collectionView)
        collectionView.snp.makeConstraints { (make) in
            make.left.top.right.bottom.equalTo(view.safeAreaLayoutGuide)
        }
    }
}
