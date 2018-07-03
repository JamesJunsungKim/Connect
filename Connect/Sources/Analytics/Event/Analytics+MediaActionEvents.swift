//
//  Analytics+MediaActionEvents.swift
//  Connect
//
//  Created by James Kim on 7/1/18.
//  Copyright © 2018 James Kim. All rights reserved.
//

import UIKit

@objc public enum ConversationMediaPictureSource: UInt {
    case gallery, camera, sketch, giphy, sharing, clip, paste
    
    static let attributeName = "source"
    var attributeValue: String {
        switch self {
        case .gallery:  return "gallery"
        case .camera:   return "camera"
        case .sketch:   return "sketch"
        case .giphy:    return "giphy"
        case .sharing:  return "sharing"
        case .clip:     return "clip"
        case .paste:    return "paste"
        }
    }
}

@objc public enum ConversationMediaPictureTakeMethod: UInt {
    case none, keyboard, fullFromKeyboard, quickMenu
    
    static let attributeName = "method"
    
    var attributeValue: String {
        switch self {
        case .none:             return ""
        case .keyboard:         return "keyboard"
        case .fullFromKeyboard: return "full_screen"
        case .quickMenu:        return "quick_menu"
        }
    }
}

@objc public enum ConversationMediaSketchSource : UInt {
    case none
    case sketchButton
    case cameraGallery
    case imageFullView
}

@objc public enum ConversationMediaPictureCamera: UInt {
    case none, front, back
    
    static let attributeName = "camera"
    
    init (camera: UIImagePickerControllerCameraDevice) {
        switch camera {
        case .front:
            self = .front
        case .rear:
            self = .back
        }
    }
    
    var attributeValue: String {
        switch self {
        case .none:  return ""
        case .front: return "front"
        case .back:  return "back"
        }
    }
}

@objcMembers open class ImageMetadata: NSObject {
    var source: ConversationMediaPictureSource = .gallery
    var method: ConversationMediaPictureTakeMethod = .none
    var sketchSource: ConversationMediaSketchSource = .none
    var camera: ConversationMediaPictureCamera = .none
    
    
    @objc static func metadata(with camera: ConversationMediaPictureCamera, method: ConversationMediaPictureTakeMethod) -> ImageMetadata {
        let mt = ImageMetadata()
        mt.camera = camera
        mt.method = method
        mt.source = .camera
        mt.sketchSource = .none
        return mt
    }
    
    
    
    
    
    
    
}



