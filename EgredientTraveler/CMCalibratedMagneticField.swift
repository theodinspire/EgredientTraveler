//
//  CMCalibratedMagneticField.swift
//  EgredientTraveler
//
//  Created by Eric Cormack on 5/24/17.
//  Copyright © 2017 the Odin Spire. All rights reserved.
//

import CoreMotion

extension CMCalibratedMagneticField {
    func normalizedDirection() -> (x: Double, y: Double, z: Double) {
        let fieldMagnitude = sqrt(field.x * field.x + field.y * field.y + field.z * field.z)
        
        return (field.x / fieldMagnitude, field.y / fieldMagnitude, field.z / fieldMagnitude)
    }
}
