//
//  Childrenable.swift
//  EnchantrixFormula
//
//  Created by MarkG on 6/6/24.
//

import Foundation

public protocol Childrenable {

    var children: [Formula] { get }
}

public protocol DynamicChildrenable: Childrenable {

    func generateChildren(for target: Target)
}

public protocol ChildFormula: Formula {

    associatedtype Parent: Formula
}
