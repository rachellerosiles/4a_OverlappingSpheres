//
//  Monte Carlo Integral.swift
//  4a_OverlappingSpheres
//
//  Created by PHYS 440 Rachelle on 2/16/24.
//

// calculate the 1s and 2px

import Foundation


import Foundation
import SwiftUI

@Observable class MonteCarloWaves {
    
    var psi1Data = [(xPoint: Double, yPoint: Double, zPoint: Double)]()
    var psi2Data = [(xPoint: Double, yPoint: Double, zPoint: Double)]()
    var totalGuessesString = ""
    var guessesString = ""
    var integralString = ""
    var enableButton = true
    
    var orbital1xCenter = 0.0
    var orbital2xCenter = 0.0
    var orbital1yCenter = 0.0
    var orbital2yCenter = 0.0
    var orbital1zCenter = 0.0
    var orbital2zCenter = 0.0
    
    var integral = 0.0
    var guesses = 1
    var totalGuesses = 0
    var totalIntegral = 0.0
    var xLimitPos = 10.0
    var xLimitNeg = -10.0
    var yLimitPos = 0.0
    var yLimitNeg = 0.0
    var zLimitPos = 0.0
    var zLimitNeg = 0.0
    
    var firstTimeThroughLoop = true
    
    var bohrRadius = 0.529177210903
    
    //var psi1s = 0.0
    //var psi2px = 0.0
    //var sum1s2px = 0.0
    
//    @MainActor init(withData data: Bool) {
//        
//        psi1Data = []
//        psi2Data = []
//        
//        
//        
//    }
    
    func orbital1s(a: Double, r: Double) -> Double {
        
        let psi1s = (1/sqrt(Double.pi)) * pow(1/a, Double(3.0/2.0)) * exp(-r/a)
        return psi1s
    }
    
    func orbital2px(a: Double, r: Double, theta: Double, phi: Double) -> Double {
        
        let psi2px = (1/sqrt(32*Double.pi)) * pow(1/a, Double(5.0/2.0)) * r * exp(-r/(2*a)) * sin(theta) * cos(phi)
        return psi2px
    }
    
    //x, y, and z are given wrt 0,0,0
    // offsets are x, y, and z wrt 0,0,0; these will be treated as origin
    // returns spherical coordinates wrt offset from origin
    /// Converts cartesian coordinates to sphereical coordinates
    /// - Parameters:
    ///   - x, y, z: coordinates of the point where the wavefunction is calculated
    ///   - xOffSet: x coordinate of the sphere center wrt origin
    ///   - yOffSet: y coordinate of the sphere center wrt origin
    ///   - zOffSet: y coordinate of the sphere center wrt origin
    /// - Returns: spherical coordinates wrt the x,y,z offset
    func cartesianToSpherical(x: Double, y: Double, z: Double, xOffSet: Double, yOffSet: Double, zOffSet: Double)  -> (r: Double, theta: Double, phi: Double){
        
        let newY = y - yOffSet
        let newX = x - xOffSet
        let newZ = z - zOffSet
        
        let r = sqrt( pow(newX, 2) + pow(newY, 2) + pow(newZ, 2))
        
        let theta = acos(newZ/r)
        let phi = atan2(newY, newX)
        
        return (r, theta, phi)
        
    }
    
    ///
    func calculateIntegral() {
        
        var maxGuesses = 0.0
        let boundingBoxCalculator = BoundingBox() ///Instantiates Class needed to calculate the area of the bounding box.
        
        maxGuesses = Double(guesses)
        
        let newValue = calculateMonteCarloIntegral(domain: (xMin: xLimitNeg, xMax: xLimitPos, yMin: yLimitNeg, yMax: yLimitPos, zMin: zLimitNeg, zMax: zLimitPos), maxGuesses: maxGuesses)
        totalIntegral = totalIntegral + newValue
        totalGuesses = totalGuesses + guesses
        
        updateTotalGuessesString(text: "\(totalGuesses)")
        
        //totalGuessesString = "\(totalGuesses)"
        
        ///Calculates the value of π from the area of a unit circle
        
        let volumeOfBoundingBox = boundingBoxCalculator.calculateVolume(lengthOfSide1: (xLimitPos-xLimitNeg), lengthOfSide2: (yLimitPos-yLimitNeg), lengthOfSide3: (zLimitPos-zLimitNeg))
        
        integral = totalIntegral * volumeOfBoundingBox/Double(totalGuesses)
        
        updatePiString(text: "\(integral)")
        
        //piString = "\(pi)"
        
        
        
    }
    
    /// calculates the Monte Carlo Integral of a the overlap of two orbitals
    ///
    /// - Parameters:
    ///   - domain: half the side length of the bounding box
    ///   - maxGuesses: number of guesses to use in the calculaton
    /// - Returns: ratio of the sum of all (value of first wavefunction) x (value of second wavefunction) / maxGuesses
    /// must multiply return value by the box volume
    func calculateMonteCarloIntegral(domain: (xMin: Double, xMax: Double, yMin: Double, yMax: Double, zMin: Double, zMax: Double), maxGuesses: Double) -> Double {
        
        var numberOfGuesses = 0.0
        //var overlappingPoints = 0.0
        //var integral = 0.0
        var point = (xPoint: 0.0, yPoint: 0.0, zPoint: 0.0)
        
        //var newOverlappingPoints : [(xPoint: Double, yPoint: Double, zPoint: Double)] = []
        //var newNonOverlappingPoints : [(xPoint: Double, yPoint: Double, zPoint: Double)] = []
        var psiSum = 0.0
        
        
        while numberOfGuesses < maxGuesses {
            
            /* Calculate 2 random values within the box */
            /* Determine psi 1 and psi 2 */
            /* multipy psi1 and psi2 and add to the sum */
            point.xPoint = Double.random(in: domain.xMin...domain.xMax)
            point.yPoint = Double.random(in: domain.yMin...domain.yMax)
            point.zPoint = Double.random(in: domain.zMin...domain.zMax)
            
            var sphereCord_wrt_Orbital1 = cartesianToSpherical(x: point.xPoint, y: point.yPoint, z: point.zPoint, xOffSet: orbital1xCenter, yOffSet: orbital1yCenter, zOffSet: orbital1zCenter)
            
            var sphereCord_wrt_Orbital2 = cartesianToSpherical(x: point.xPoint, y: point.yPoint, z: point.zPoint, xOffSet: orbital2xCenter, yOffSet: orbital2yCenter, zOffSet: orbital2zCenter)
            
            let psi1 = orbital1s(a: bohrRadius, r: sphereCord_wrt_Orbital1.r)
            //let psi2px = orbital2px(a: 1.0, r: sphereCord_wrt_Orbital2.r, theta: sphereCord_wrt_Orbital2.theta, phi: sphereCord_wrt_Orbital2.theta)
            
            let psi2 = orbital1s(a: bohrRadius, r: sphereCord_wrt_Orbital2.r)
            
            psiSum = psiSum + psi1*psi2
            
            numberOfGuesses += 1.0
            
        }
        
        
        //integral = psiSum/maxGuesses
        integral = psiSum
        //Append the points to the arrays needed for the displays
        //Don't attempt to draw more than 250,000 points to keep the display updating speed reasonable.
        
        /*if ((totalGuesses < 500001) || (firstTimeThroughLoop)){
         
         //            insideData.append(contentsOf: newInsidePoints)
         //            outsideData.append(contentsOf: newOutsidePoints)
         
         var plotInsidePoints = newOverlappingPoints
         var plotOutsidePoints = newNonOverlappingPoints
         
         if (newOverlappingPoints.count > 750001) {
         
         plotInsidePoints.removeSubrange(750001..<newOverlappingPoints.count)
         }
         
         if (newNonOverlappingPoints.count > 750001){
         plotOutsidePoints.removeSubrange(750001..<newNonOverlappingPoints.count)
         
         }
         
         updateData(insidePoints: plotInsidePoints, outsidePoints: plotOutsidePoints)
         firstTimeThroughLoop = false
         }*/
        
        return psiSum
    }
    
    
    /// updateData
    /// The function runs on the main thread so it can update the GUI
    /// - Parameters:
    ///   - insidePoints: points inside the circle of the given radius
    ///   - outsidePoints: points outside the circle of the given radius
    /*@MainActor func updateData(insidePoints: [(xPoint: Double, yPoint: Double)] , outsidePoints: [(xPoint: Double, yPoint: Double)]){
     
     insideData.append(contentsOf: insidePoints)
     outsideData.append(contentsOf: outsidePoints)
     */
    
    /// updateTotalGuessesString
    /// The function runs on the main thread so it can update the GUI
    /// - Parameter text: contains the string containing the number of total guesses
    func updateTotalGuessesString(text:String){
        
        totalGuessesString = text
        
    }
    
    /// updatePiString
    /// The function runs on the main thread so it can update the GUI
    /// - Parameter text: contains the string containing the current value of Pi
   func updatePiString(text:String){
        
        integralString = text
        
    }
    
    
    /// setButton Enable
    /// Toggles the state of the Enable Button on the Main Thread
    /// - Parameter state: Boolean describing whether the button should be enabled.
    func setButtonEnable(state: Bool){
        if state {
            Task.init {
                 {
                     self.enableButton = true
                }
            }
        }
        else{
            Task.init {
                 {
                     self.enableButton = false
                }
            }
        }
    }
}
