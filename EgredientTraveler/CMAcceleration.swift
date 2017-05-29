//
//  CMAcceleration.swift
//  EgredientTraveler
//
//  Created by Eric Cormack on 5/27/17.
//  Copyright © 2017 the Odin Spire. All rights reserved.
//

import CoreMotion

extension CMAcceleration {
    var xInMetersPerSecondSquared: Double { return x * Constants.accelerationDueToGravity }
    var yInMetersPerSecondSquared: Double { return y * Constants.accelerationDueToGravity }
    var zInMetersPerSecondSquared: Double { return z * Constants.accelerationDueToGravity }
}
