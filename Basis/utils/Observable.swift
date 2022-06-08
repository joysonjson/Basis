//
//  Observable.swift
//  Basis
//
//  Created by Joyson P S on 09/06/22.
//

import Foundation

class Observable<T>{
    var value:T? {
        didSet {
            listener?.forEach {
                $0(value)
            }
        }
    }
    
    init(_ value:T?){
        self.value = value
    }
    private var listener: [((T?) ->Void)]? = []
    
    func bind(_ listener: @escaping (T?)->Void){
        self.listener?.append(listener)
        
    }
}
