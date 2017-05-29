//
//  CMQuaternion.swift
//  EgredientTraveler
//
//  Created by Eric Cormack on 5/27/17.
//  Copyright © 2017 the Odin Spire. All rights reserved.
//

import CoreMotion

extension CMQuaternion {
    init(vector: Vector, andRotation theta: Double) {
        let s = sin(theta / 2)
        let u = s * vector
        w = cos(theta / 2)
        x = u.x
        y = u.y
        z = u.z
    }
    
    func rotate(vector: Vector) -> Vector {
        let u = Vector(x: x, y: y, z: z)
        
        let a = 2 * u.dot(vector) * u
        let b = (w * w - u.dot(u)) * vector
        let c = 2 * w * u.cross(vector)
        
        return a + b + c
    }
    
    func rotate(acceleration a: CMAcceleration) -> Vector {
        return rotate(vector: Vector(x: a.x, y: a.y, z: a.z))
    }
}
