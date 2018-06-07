//
//  AlbumInfo.swift
//  Connect
//
//  Created by James Kim on 6/3/18.
//  Copyright © 2018 James Kim. All rights reserved.
//

import UIKit
import Photos

struct AlbumInfo: BaseModel {
    let images : [UIImage]?
    let name: String
    var totalNumber : Int
    let assetCollection: PHAssetCollection?
}

extension AlbumInfo {
    
    // MARK: - Static
    
    public static let imageManager = PHCachingImageManager()
    
    public static func fetchAndCreate<A:PHObject>(fromFetchResult fetchResult: PHFetchResult<A>, targetSize: CGSize, batchSize: Int, name:String, collection: PHAssetCollection? = nil, completion:@escaping (AlbumInfo)->()) {
        var result = [UIImage]()
        var isfinished = false
        fetchResult.enumerateObjects { (asset, index, _) in
            if isfinished {return}
            imageManager.requestImage(for: (asset as! PHAsset), targetSize: targetSize, contentMode: .aspectFit, options: nil, resultHandler: { (image, _) in
                
                if let image = image {
                    result.append(image)
                }
                if (index == batchSize-1 || index == fetchResult.count-1) && !isfinished  {
                    isfinished = true
                    let album = AlbumInfo(images: result, name: name, totalNumber: fetchResult.count, assetCollection: collection)
                    completion(album)
                    return
                }
            })
        }
    }
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
}
