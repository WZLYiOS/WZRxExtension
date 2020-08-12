//
//  Rx+UITextField.swift
//  WZStore
//
//  Created by xiaobin liu on 2019/7/9.
//  Copyright © 2019 我主良缘. All rights reserved.
//

import UIKit
import RxSwift
import RxCocoa


// MARK: - UITextField
public extension Reactive where Base: UITextField {
    
    var delegate: RxTextFieldDelegateProxy {
        return RxTextFieldDelegateProxy.proxy(for: base)
    }
    
    var shouldClear: ControlEvent<UITextField> {
        let source = delegate.shouldClearPublishSubject
        return ControlEvent(events: source)
    }
    
    var shouldReturn: ControlEvent<UITextField> {
        let source = delegate.shouldReturnPublishSubject
        return ControlEvent(events: source)
    }
    
    var valueChanged: Binder<Void> {
        return Binder(base) { textField, _ in
            textField.sendActions(for: .valueChanged)
        }
    }
}


// MARK: - HasDelegate
extension UITextField: HasDelegate {
    
    public typealias Delegate = UITextFieldDelegate
}

open class RxTextFieldDelegateProxy: DelegateProxy<UITextField, UITextFieldDelegate>, DelegateProxyType, UITextFieldDelegate {
    
    public weak private(set) var textField: UITextField?
    
    public init(textField: ParentObject) {
        self.textField = textField
        super.init(parentObject: textField, delegateProxy: RxTextFieldDelegateProxy.self)
    }
    
    public static func registerKnownImplementations() {
        self.register { RxTextFieldDelegateProxy(textField: $0) }
    }
    
    private var _shouldClearPublishSubject: PublishSubject<UITextField>?
    private var _shouldReturnPublishSubject: PublishSubject<UITextField>?
    
    var shouldClearPublishSubject: PublishSubject<UITextField> {
        if let subject = _shouldClearPublishSubject {
            return subject
        }
        
        let subject = PublishSubject<UITextField>()
        _shouldClearPublishSubject = subject
        
        return subject
    }
    
    var shouldReturnPublishSubject: PublishSubject<UITextField> {
        if let subject = _shouldReturnPublishSubject {
            return subject
        }
        
        let subject = PublishSubject<UITextField>()
        _shouldReturnPublishSubject = subject
        
        return subject
    }
    
    public typealias ShouldChangeCharacters = (UITextField, NSRange, String) -> Bool
    
    public var shouldChangeCharacters: ShouldChangeCharacters = { _, _, _ in true }
    
    public func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        return shouldChangeCharacters(textField, range, string)
    }
    
    public func textFieldShouldClear(_ textField: UITextField) -> Bool {
        if let subject = _shouldClearPublishSubject {
            subject.onNext(textField)
        }
        return true
    }
    
    public func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        if let subject = _shouldReturnPublishSubject {
            subject.onNext(textField)
        }
        return true
    }
    
    deinit {
        if let subject = _shouldClearPublishSubject {
            subject.onCompleted()
        }
        if let subject = _shouldReturnPublishSubject {
            subject.onCompleted()
        }
    }
}
