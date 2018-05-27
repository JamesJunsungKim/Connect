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
    
    public var requestObservable: Observable<Request> {
        return receivedRequestSubject.asObservable()
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
    
    public func received(request: Request) {
        send(data: request, through: receivedRequestSubject)
    }
    
    // MARK: - Fileprivate
    fileprivate var currentUserSubject = PublishSubject<User>()
    fileprivate var receivedRequestSubject = PublishSubject<Request>()
    
    fileprivate func send<A>(data: A,through publishSubject: PublishSubject<A>) {
        publishSubject.onNext(data)
    }
    
    
}






























