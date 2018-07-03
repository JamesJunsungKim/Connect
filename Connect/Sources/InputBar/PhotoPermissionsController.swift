//
//  PhotoPermissionsController.swift
//  Connect
//
//  Created by James Kim on 7/1/18.
//  Copyright © 2018 James Kim. All rights reserved.
//

import Foundation
import Photos

public protocol PhotoPermissionsController {
    var isCameraAuthorized: Bool {get}
    var isPhotoLibraryAuthorized: Bool {get}
    var areCameraOrPhotoLibraryAuthorized: Bool {get}
    var areCameraAndPhotoLibraryAuthorized: Bool {get}
}

final class PhotoPermissionsControllerStrategy: PhotoPermissionsController {
    
    var isCameraAuthorized: Bool {
        switch AVCaptureDevice.authorizationStatus(for: .video) {
        case .authorized: return true
        default: return false
        }
    }
    
    var isPhotoLibraryAuthorized: Bool {
        switch PHPhotoLibrary.authorizationStatus() {
        case .authorized: return true
        default: return false
        }
    }
    
    var areCameraOrPhotoLibraryAuthorized: Bool {
        return isCameraAuthorized || isPhotoLibraryAuthorized
    }
    
    var areCameraAndPhotoLibraryAuthorized: Bool {
        return isCameraAuthorized && isPhotoLibraryAuthorized
    }
}















