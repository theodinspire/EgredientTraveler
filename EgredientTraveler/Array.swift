//
//  Array.swift
//  EgredientTraveler
//
//  Created by Eric Cormack on 5/28/17.
//  Copyright © 2017 the Odin Spire. All rights reserved.
//

import Foundation

extension Array {
    func yield<T>(output: inout T, op: (_ a: inout T, _ b: Element) -> Void ) {
        for element in self { op(&output, element) }
    }
}
