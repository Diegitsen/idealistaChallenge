//
//  Observable.swift
//  idealistaChallenge
//
//  Created by diegitsen on 15/12/24.
//

import Foundation

class Observable<T: Equatable> {
    private let thread : DispatchQueue
    var value : T? {
        willSet(newValue) {
            if let newValue = newValue, value != newValue {
                thread.async {
                    self.observe?(newValue)
                }
            }
        }
    }
    var observe : ((T) -> ())?
    init(_ value: T? = nil, thread dispatcherThread: DispatchQueue = DispatchQueue.main) {
        self.thread = dispatcherThread
        self.value = value
    }
}
