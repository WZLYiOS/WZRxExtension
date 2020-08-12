//
//  Rx+UIButton.swift
//  WZStore
//
//  Created by xiaobin liu on 2019/9/23.
//  Copyright © 2019 我主良缘. All rights reserved.
//

import RxSwift
import RxCocoa
import Foundation

// MARK: - UIButton
public extension Reactive where Base: UIButton {
    
    var selected: ControlProperty<Bool> {
        let source = tap.map { [unowned button = self.base] _ -> Bool in
            button.isSelected = !button.isSelected
            return button.isSelected
        }
        let sink = isSelected
        return ControlProperty(values: source, valueSink: sink)
    }
}
