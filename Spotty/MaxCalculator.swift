//
//  MaxCalculator.swift
//  Spotty
//
//  Created by David Krystall on 2/12/17.
//  Copyright © 2017 David Krystall. All rights reserved.
//

import Foundation

class MaxCalculator {
    public func setWarningKg(currWeight: Double, oneMaxRepKg: Double, numOfReps: Int) -> String {
        
        let percentage = (currWeight / oneMaxRepKg) * 100
        
        print(percentage)
        
        switch(percentage) {
        case 0...75.00:
            if(numOfReps > 10) {
                return "Safe weight but decrease reps"
            }
            else{
                return "Safe Set"
            }
        case 75.01...80.00:
            if(numOfReps > 8){
                return "Safe weight but decrease reps"
            }
            else{
                return "Safe set"
            }
        case 80.01...85.00:
            if(numOfReps > 6) {
                return "Semi-heavy weight. Be careful. Decrease reps"
            }
            else{
                return "Semi-heavy weight but safe set"
            }
        case 85.01...90.00:
            if(numOfReps > 4) {
                return "Nearing One Rep Max. Decreasae reps for safety!"
            }
            else{
                return "Nearing One Rep Max. Doable set but be safe!"
            }
        case 90.01...100.00:
            return "Should only do One Repition at this weight!"
        default:
            return "Miscalculation"
        }
    }
    
    public func setWarningLbs(currWeight: Double, oneMaxRepLbs: Double, numOfReps: Int) -> String {
        
        let percentage = (currWeight / oneMaxRepLbs) * 100
        
        print(percentage)
        
        switch(percentage) {
        case 0...75.00:
            if(numOfReps > 10) {
                return "Safe weight but decrease reps"
            }
            else{
                return "Safe Set"
            }
        case 75.01...80.00:
            if(numOfReps > 8){
                return "Safe weight but decrease reps"
            }
            else{
                return "Safe set"
            }
        case 80.01...85.00:
            if(numOfReps > 6) {
                return "Semi-heavy weight. Be careful. Decrease reps"
            }
            else{
                return "Semi-heavy weight but safe set"
            }
        case 85.01...90.00:
            if(numOfReps > 4) {
                return "Nearing One Rep Max. Decreasae reps for safety!"
            }
            else{
                return "Nearing One Rep Max. Doable set but be safe!"
            }
        case 90.01...100.00:
            return "Should only do One Repition at this weight!"
        default:
            return "Miscalculation"
        }
        
    }
    public func recommendedSetsLbs(currMaxRepLbs: Double) -> String {
        
        //    3 x 10 @ 75% - Three sets of 10 reps at 75% of the 1RM
        //    8/80%, 6/85%, 6/85%, 4/90% - Eight reps at 80%, two sets of six reps at 85%, and four reps at 90% of the 1RM
        
        let seventyFivePercent : String = String(round(Double(currMaxRepLbs) * 0.75))
        let eightyPercent : String = String(round(Double(currMaxRepLbs) * 0.80))
        let eightyFivePercent : String = String(round(Double(currMaxRepLbs) * 0.85))
        let ninetyPercent : String = String(round(Double(currMaxRepLbs) * 0.90))
        
        
        let recommendedSet = "For best results do:\n3x10 of " + seventyFivePercent + " lbs,\n"
            + "3x8 of " + eightyPercent + " lbs,\n" + "3x6 of " + eightyFivePercent + " lbs,\n"
            + "3x4 of " + ninetyPercent + " lbs"
        
        return recommendedSet
    }
    

}
