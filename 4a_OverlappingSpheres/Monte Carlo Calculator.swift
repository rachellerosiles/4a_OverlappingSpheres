//
//  Monte Carlo Integral.swift
//  4a_OverlappingSpheres
//
//  Created by PHYS 440 Rachelle on 2/16/24.
//

// calculate the 1s and 2px

import Foundation

@Observable class MonteCarlo {
    
    func orbital1s(a: Double, r: Double) {
        let result = (1/sqrt(Double.pi)) * pow(1/a, Double(3/2)) * exp(-r/a)
    }
    
    func orbital2px(a: Double, r: Double, theta: Double, phi: Double) {
        let result = (1/sqrt(32*Double.pi)) * pow(1/a, Double(5/2)) * r * exp(-r/(2*a)) * sin(theta) * cos(phi)
     }
    
    //x, y, and z are given wrt 0,0,0
    // offsets are x, y, and z wrt 0,0,0; these will be treated as origin
    // returns spherical coordinates wrt offset from origin
    func cartesianToSpherical(x: Double, y: Double, z: Double, xOffSet: Double, yOffSet: Double, zOffSet: Double) -> (r: Double, theta: Double, phi: Double){
        
        let newY = y - yOffSet
        let newX = x - xOffSet
        let newZ = z - zOffSet
        
        let r = sqrt( pow(newX, 2) + pow(newY, 2) + pow(newZ, 2))
        
        let theta = atan(newY/newZ)
        let phi = atan(newY/newX)
        
        return (r, theta, phi)
        
    }
    
}
