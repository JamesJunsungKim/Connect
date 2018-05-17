//
//  AppStatus.swift
//  Connect
//
//  Created by James Kim on 5/18/18.
//  Copyright © 2018 James Kim. All rights reserved.
//

import Foundation
import RxSwift

class AppStatus {
    static let observer = AppStatus()
    
    private init() {}
    
    
    var currentUser: User! {
        didSet {
            currentUserSubject.onNext(currentUser)
        }    }
    
    fileprivate var currentUserSubject = PublishSubject<User>()
    
    public var currentUserObservable : Observable<User> {
        return currentUserSubject.asObservable()
    }
    
    
    
    
    
    
}
