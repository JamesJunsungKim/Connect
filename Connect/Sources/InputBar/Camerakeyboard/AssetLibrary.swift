//
//  AssetLibrary.swift
//  Connect
//
//  Created by James Kim on 7/1/18.
//  Copyright © 2018 James Kim. All rights reserved.
//

import Foundation
import Photos

public protocol AssetLibraryDelegate: AnyObject {
    func assetLibraryDidChange(_ library: AssetLibrary)
}

open class AssetLibrary:NSObject {
   
    init(synchronous:Bool = false) {
        self.synchronous = synchronous
        super.init()
        PHPhotoLibrary.shared().register(self)
        refetchAssets(synchronous: synchronous)
    }
    
    deinit {
        PHPhotoLibrary.shared().unregisterChangeObserver(self)
    }
    
    // MARK: - Public
    public enum AssetError: Error {
        case outOfRange, notLoadedError
    }
    open weak var delegate: AssetLibraryDelegate?
    open let synchronous: Bool
    
    open var count: Int {
        guard let fetch = self.fetch else {return 0}
        return fetch.count
    }
    
    open func asset(atIndex index: Int) throws -> PHAsset {
        guard let fetch = self.fetch else {
            throw AssetError.notLoadedError
        }
        
        if index >= count {
            throw AssetError.outOfRange
        }
        
        return fetch.object(at: index)
    }
    
    open func refetchAssets(synchronous:Bool = false) {
        guard !self.fetchingAssets else {return}
        fetchingAssets = true
        
        let syncOperation = {[unowned self]in
            let options = PHFetchOptions()
            options.sortDescriptors = [NSSortDescriptor(key: "creationDate", ascending: false)]
            self.fetch = PHAsset.fetchAssets(with: options)
            self.notifyChangeToDelegate()
        }
        if synchronous {
            syncOperation()
        } else {
            DispatchQueue(label: "ConnectAssetLibrary", qos: .background, attributes: [], autoreleaseFrequency: .inherit, target: .none).async(execute: syncOperation)
        }
    }
    
    
    
    
    
    // MARK: - Fileprivate
    fileprivate var fetchingAssets = false
    fileprivate var fetch: PHFetchResult<PHAsset>?
    
    fileprivate func notifyChangeToDelegate() {
        let completion = {[unowned self] in
            self.delegate?.assetLibraryDidChange(self)
            self.fetchingAssets = false
        }
        
        if synchronous {
            completion()
        } else {
            performOnMain(block: completion)
        }
    }
    
}


extension AssetLibrary: PHPhotoLibraryChangeObserver {
    public func photoLibraryDidChange(_ changeInstance: PHChange) {
        
        guard let fetch = self.fetch, let changeDetails = changeInstance.changeDetails(for: fetch) else {return}
        
        self.fetch = changeDetails.fetchResultAfterChanges
        self.notifyChangeToDelegate()
    }
}




