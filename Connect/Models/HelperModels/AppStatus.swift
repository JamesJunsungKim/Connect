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
    
    
    var currentUser: User!
    
    public var userObservable : Observable<User> {
        return currentUserSubject.asObservable()
    }
    
    // MARK: - user
    public func updateSettingAttributeAndPatch(withAttribute attribute: SettingAttribute, success:@escaping ()->(), failure:@escaping (Error)->()) {
        currentUser.updateSettingAttributeAndPatch(withAttribute: attribute, success: {[unowned self] in
            success()
            self.send(data: self.currentUser, through: self.currentUserSubject)
        }) { (error) in
            failure(error)
        }
    }
    
    // MARK: - Fileprivate
    fileprivate var currentUserSubject = PublishSubject<User>()
    
    fileprivate func send<A>(data: A,through publishSubject: PublishSubject<A>) {
        publishSubject.onNext(data)
    }
    
    
}






























