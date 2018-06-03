//
//  AlbumInfo.swift
//  Connect
//
//  Created by James Kim on 6/3/18.
//  Copyright © 2018 James Kim. All rights reserved.
//

import UIKit
import Photos

struct AlbumInfo:DictionaryCreatable {
    let images : [UIImage]?
    let name: String
    let totalNumber : Int
    let assetCollection: PHAssetCollection?
}

extension AlbumInfo {
    // MARK: - Static
    public static func fetchAndCreate<A:PHObject>(fromFetchResult fetchResult: PHFetchResult<A>, targetSize: CGSize, batchSize: Int, name:String, collection: PHAssetCollection? = nil, completion:@escaping (AlbumInfo)->()) {
        let imageManager = PHCachingImageManager()
        var result = [UIImage]()
        fetchResult.enumerateObjects { (asset, index, _) in
            imageManager.requestImage(for: (asset as! PHAsset), targetSize: targetSize, contentMode: .aspectFit, options: nil, resultHandler: { (image, _) in
                guard let image = image else {return}
                result.append(image)
                
                if index == batchSize-1 || index == fetchResult.count-1 {
                    let album = AlbumInfo(images: result, name: name, totalNumber: fetchResult.count, assetCollection: collection)
                    completion(album)
                }
            })
        }
    }
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
}
