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
    
    init(photoSelectAction: @escaping ((UIImage)->())) {
        self.photoSelectAction = photoSelectAction
        super.init(nibName: nil, bundle: nil)
    }

    override func viewDidLoad() {
        super.viewDidLoad()
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
        dismiss(animated: true, completion: nil)
    }
    
    fileprivate func didSelectCollectionViewItem(atIndexPath indexPath: IndexPath) {
        let cell = dataSource.cellForItem(atIndexPath: indexPath)

    }
    
    // MARK: - Fileprivate
    fileprivate var fetchResult: PHFetchResult<PHAsset>!
    fileprivate var assetCollection: PHAssetCollection!
    fileprivate let photoSelectAction: ((UIImage)->())
    fileprivate var selectedPhotos = [UIImage]()
    
    fileprivate var thumbnailSize: CGSize!
    fileprivate var previousPreheatRect = CGRect.zero
    fileprivate let imageManager = PHCachingImageManager()
    
    fileprivate var dataSource: DefaultCollectionViewDataSource<AlbumDetailCell>!
    
    fileprivate func setupVC() {
        view.backgroundColor = .white
        PHPhotoLibrary.shared().register(self)
        
        navigationController?.navigationItem.rightBarButtonItem = UIBarButtonItem(title: "Done", style: .plain, target: self, action: #selector(doneBtnClicked))
    }
    
    fileprivate func setupCollectionView() {
        let scale = UIScreen.main.scale
        let cellSize = (collectionView.collectionViewLayout as! UICollectionViewFlowLayout).itemSize
        thumbnailSize = CGSize(width: cellSize.width * scale, height: cellSize.height * scale)
        
        dataSource = DefaultCollectionViewDataSource<AlbumDetailCell>.init(collectionView: collectionView, parentViewController: self)
        collectionView.delegate = self
        collectionView.allowsMultipleSelection = true
        
        let indexPathForLast = IndexPath(item: fetchResult.count-1, section: 0)
        collectionView.scrollToItem(at: indexPathForLast, at: .bottom, animated: false)
    }
    
    fileprivate func resetCachedAssets() {
        imageManager.stopCachingImagesForAllAssets()
        previousPreheatRect = .zero
    }
    
    fileprivate func updateCachedAssets() {
        // Update only if the view is visible.
        guard isViewLoaded && view.window != nil else { return }
        
        // The preheat window is twice the height of the visible rect.
        let visibleRect = CGRect(origin: collectionView!.contentOffset, size: collectionView!.bounds.size)
        let preheatRect = visibleRect.insetBy(dx: 0, dy: -0.5 * visibleRect.height)
        
        // Update only if the visible area is significantly different from the last preheated area.
        let delta = abs(preheatRect.midY - previousPreheatRect.midY)
        guard delta > view.bounds.height / 3 else { return }
        
        // Compute the assets to start caching and to stop caching.
        let (addedRects, removedRects) = differencesBetweenRects(previousPreheatRect, preheatRect)
        let addedAssets = addedRects
            .flatMap { rect in collectionView!.indexPathsForElements(in: rect) }
            .map { indexPath in fetchResult.object(at: indexPath.item) }
        let removedAssets = removedRects
            .flatMap { rect in collectionView!.indexPathsForElements(in: rect) }
            .map { indexPath in fetchResult.object(at: indexPath.item) }
        
        // Update the assets the PHCachingImageManager is caching.
        imageManager.startCachingImages(for: addedAssets,
                                        targetSize: thumbnailSize, contentMode: .aspectFill, options: nil)
        imageManager.stopCachingImages(for: removedAssets,
                                       targetSize: thumbnailSize, contentMode: .aspectFill, options: nil)
        
        // Store the preheat rect to compare against in the future.
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
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}
extension AlbumDetailViewController: UICollectionViewDelegate {
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        didSelectCollectionViewItem(atIndexPath: indexPath)
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
    func setup(fromVC: UIViewController, userInfo: [String : Any]?) {
        
    }
    
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



