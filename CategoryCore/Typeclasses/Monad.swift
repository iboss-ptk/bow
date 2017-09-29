//
//  Monad.swift
//  CategoryCore
//
//  Created by Tomás Ruiz López on 29/9/17.
//  Copyright © 2017 Tomás Ruiz López. All rights reserved.
//

import Foundation

public protocol Monad : Applicative {
    func flatMap<A, B>(_ fa : HK<F, A>, _ f : (A) -> HK<F, B>) -> HK<F, B>
}

public extension Monad {
    public func ap<A, B>(_ fa: HK<F, A>, _ ff: HK<F, (A) -> B>) -> HK<F, B> {
        return self.flatMap(ff, { f in self.map(fa, f) })
    }
    
    public func flatten<A>(_ ffa : HK<F, HK<F, A>>) -> HK<F, A> {
        return self.flatMap(ffa, id)
    }
    
    public func followedBy<A, B>(_ fa : HK<F, A>, _ fb : HK<F, B>) -> HK<F, B> {
        return flatMap(fa, { _ in fb })
    }
    
    public func forEffect<A, B>(_ fa : HK<F, A>, _ fb : HK<F, B>) -> HK<F, A> {
        return self.flatMap(fa, { a in self.map(fb, { _ in a })})
    }
}
