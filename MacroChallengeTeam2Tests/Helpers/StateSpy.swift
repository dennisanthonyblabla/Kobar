//
//  StateSpy.swift
//  KobarTests
//
//  Created by Mohammad Alfarisi on 15/11/22.
//

import RxSwift

class StateSpy<T> {
    private(set) var values: [T] = []
    private let disposeBag = DisposeBag()
    
    init(_ observable: Observable<T>) {
        observable
            .subscribe { [weak self] state in
                self?.values.append(state)
            }
            .disposed(by: disposeBag)
    }
}
