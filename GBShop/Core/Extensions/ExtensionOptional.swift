//
//  ExtensionOptional.swift
//  GBShop
//
//  Created by Olga Martyanova on 11/02/2019.
//  Copyright © 2019 olgamart. All rights reserved.
//

import Foundation
extension Optional {
    func map <U>(_ f: ((Wrapped) -> U)?) -> U? {
        guard let f = f else {return nil}
        return self.map(f)
    }
}

precedencegroup FunctorOperatorPrecendence {
    higherThan: MultiplicationPrecedence
    associativity: left
    assignment: false
}

precedencegroup ApplyFunctorOperatorPrecendence {
    higherThan: FunctorOperatorPrecendence
    associativity: left
    assignment: false
}

infix operator <*>: ApplyFunctorOperatorPrecendence
func <*><T, U>(f: ((T) -> U)?, a: T?) -> U? {
    return a.map(f)
}

public func curry <A, B, C> (_ function: @escaping ((A, B)) -> C) -> (A) -> (B) -> C {
    return { (a: A) -> (B) -> C in {
        (b: B) -> C in function ((a, b))}}
}

public func curry<A, B, C, D>(_ function: @escaping ((A, B, C)) -> D) -> (A) -> (B) -> (C) -> D {
    return { (a: A) -> (B) -> (C) -> D in { (b: B) -> (C) -> D in { (c: C) -> D in function((a, b, c)) } } }
}
