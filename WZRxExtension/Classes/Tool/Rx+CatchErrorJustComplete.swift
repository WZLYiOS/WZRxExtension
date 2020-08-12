//
//  Rx+CatchErrorJustComplete.swift
//  WZStore
//
//  Created by xiaobin liu on 2019/7/7.
//  Copyright © 2019 我主良缘. All rights reserved.
//


import RxSwift


// MARK: - catchErrorJustComplete
extension ObservableType {
    
    /**
     Dismiss errors and complete the sequence instead
     
     - returns: An observable sequence that never errors and completes when an error occurs in the underlying sequence
     */
    public func catchErrorJustComplete() -> Observable<Element> {
        return catchError { _ in
            return Observable.empty()
        }
    }
}
