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
    static let current = AppStatus()
    
    private init() {}
    
    
    var user: User!
    
    public var userObservable : Observable<User> {
        return currentUserSubject.asObservable()
    }
    
    public var requestUserObservable: Observable<User> {
        return requestUserSubject.asObservable()
    }
    
    // MARK: - user
    public func updateSettingAttributeAndPatch(withAttribute attribute: SettingAttribute, success:@escaping ()->(), failure:@escaping (Error)->()) {
        user.updateSettingAttributeAndPatch(withAttribute: attribute, success: {[unowned self] in
            success()
            self.send(data: self.user, through: self.currentUserSubject)
        }) { (error) in
            failure(error)
        }
    }
    
    public func gotRequestFrom(user: User) {
        requestUserSubject.onNext(user)
    }
    
    // MARK: - Fileprivate
    fileprivate var currentUserSubject = PublishSubject<User>()
    fileprivate var requestUserSubject = PublishSubject<User>()
    
    fileprivate func send<A>(data: A,through publishSubject: PublishSubject<A>) {
        publishSubject.onNext(data)
    }
    
    
}






























