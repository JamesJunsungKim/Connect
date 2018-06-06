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
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
        setupVC()
        setupCollectionView()
        resetCachedAssets()
        
    }
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
    }
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        updateCachedAssets()
    }
    // MARK: - Public
    
    
    // MARK: - Actions
    
    fileprivate func didSelectItem(atIndexPath indexPath: IndexPath) {
        
    }
    
    // MARK: - Fileprivate
    fileprivate var thumbnailSize: CGSize!
    fileprivate var fetchResult: PHFetchResult<PHAsset>!
    fileprivate var assetCollection: PHAssetCollection!
    fileprivate var previousPreheatRect = CGRect.zero
    fileprivate let imageManager = PHCachingImageManager()
    
    fileprivate var dataSource: DefaultCollectionViewDataSource<AlbumDetailCell>!
    
    fileprivate func setupVC() {
        view.backgroundColor = .white
    }
    
    fileprivate func setupCollectionView() {
        collectionView.delegate = self
        dataSource = DefaultCollectionViewDataSource<AlbumDetailCell>.init(collectionView: collectionView, parentViewController: self)
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
}
extension AlbumDetailViewController: UICollectionViewDelegate {
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        didSelectItem(atIndexPath: indexPath)
    }
}

extension AlbumDetailViewController {
    func setup(fromVC: UIViewController, userInfo: [String : Any]?) {
        
    }
    
    fileprivate func setupUI() {
        let bounds = UIScreen.main.bounds
        let width = (bounds.width-4)/5
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



