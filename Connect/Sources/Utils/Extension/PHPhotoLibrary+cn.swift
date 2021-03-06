//
//  PHPhotoLibrary.swift
//  Connect
//
//  Created by montapinunt Pimonta on 6/3/18.
//  Copyright © 2018 James Kim. All rights reserved.
//

import UIKit
import Photos
import RxSwift

extension PHPhotoLibrary {
    public static var authorized: Observable<Bool> {
        return Observable.create({ (observer) in
            performOnMain {
                switch authorizationStatus() {
                case .authorized:
                    observer.onNext(true)
                    observer.onNext(true)
                    observer.onCompleted()
                default:
                    observer.onNext(false)
                    requestAuthorization({ (newStatus) in
                        observer.onNext(newStatus == .authorized)
                        observer.onCompleted()
                    })
                }
            }
            return Disposables.create()
        })
    }
}

