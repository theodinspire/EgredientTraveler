//
//  Vector.swift
//  EgredientTraveler
//
//  Created by Eric Cormack on 5/27/17.
//  Copyright © 2017 the Odin Spire. All rights reserved.
//

import CoreMotion

struct Vector : Equatable {
    let x: Double
    let y: Double
    let z: Double
    
    static let zeroVector = Vector(x: 0, y: 0, z: 0)
    static let i = Vector(x: 1, y: 0, z: 0)
    static let j = Vector(x: 0, y: 1, z: 0)
    static let k = Vector(x: 0, y: 0, z: 1)
    
    init(x a: Double, y b: Double, z c: Double) { (x, y, z) = (a, b, c) }
    init(_ tuple: (x: Double, y: Double, z: Double)) { (x, y, z) = tuple }
    init?(acceleration: CMAcceleration?) {
        guard let acc = acceleration else { return nil }
        (x, y, z) = (acc.x, acc.y, acc.z)
    }
    
    var magnitude: Double { return sqrt(x * x + y * y + z * z) }
    
    static func +(a: Vector, b: Vector) -> Vector { return Vector(x: a.x + b.x, y: a.y + b.y, z: a.z + b.z) }
    
    static func *(scalar: Double, vector: Vector) -> Vector { return Vector(x: scalar * vector.x, y: scalar * vector.y, z: scalar * vector.z) }
    static func *(scalar: Int, vector: Vector) -> Vector { return Double(scalar) * vector }
    
    static func -(a: Vector, b: Vector) -> Vector { return a + -1 * b }
    
    static func /(vector: Vector, scalar: Double) -> Vector { return (1 / scalar) * vector }
    static func /(vector: Vector, scalar: Int) -> Vector { return vector / Double(scalar) }
    
    static func +=(a: inout Vector, b: Vector) { a = a + b }
    static func *=(vector: inout Vector, scalar: Double) { vector = scalar * vector }
    static func *=(vector: inout Vector, scalar: Int) { vector *= Double(scalar) }
    static func -=(a: inout Vector, b: Vector) { a = a - b }
    static func /=(vector: inout Vector, scalar: Double) { vector = vector / scalar }
    static func /=(vector: inout Vector, scalar: Int) { vector /= Double(scalar) }
    
    static func ==(a: Vector, b: Vector) -> Bool { return a.x == b.x && a.y == b.y && a.z == b.z }
    
    func dot(_ that: Vector) -> Double { return x * that.x + y * that.y + z * that.z }
    
    func cross(_ that: Vector) -> Vector {
        return Vector(x: y * that.z - z * that.y, y: z * that.x - x * that.z, z: x * that.y - y * that.x)
    }
    
    static func mean(vectors: [Vector]) -> Vector {
        var sum = Vector.zeroVector
        vectors.yield(output: &sum, op: +=)
        return sum / vectors.count
    }
    
    static func mean(vectors: Vector...) -> Vector {
        return mean(vectors: vectors)
    }
}
