//
//  GetUserData.swift
//  Spotty
//
//  Created by David Krystall on 2/12/17.
//  Copyright © 2017 David Krystall. All rights reserved.
//

import Foundation

//
//  FirstViewController.swift
//  Spotty
//
//  Created by David Krystall on 2/11/17.
//  Copyright © 2017 David Krystall. All rights reserved.
//

import UIKit
import CoreData

class GetUserData {
    var currentUser:User?
    var genderField:String?
    
    func findThings() -> User{
        let userToReturn = User()
        let appDelegate = UIApplication.shared.delegate as! AppDelegate
        let context = appDelegate.persistentContainer.viewContext
        let request = NSFetchRequest<NSFetchRequestResult>(entityName: "Profile")
        request.returnsObjectsAsFaults = false
        let exerciseRequest = NSFetchRequest<NSFetchRequestResult>(entityName: "Exercise")
        exerciseRequest.returnsObjectsAsFaults = false
        
        
        
        do{
            let results = try context.fetch(request)
            if results.count > 0 {
                for result in results as! [NSManagedObject] {
                    let fetchedUserName = result.value(forKey: "name") as? String
                    if let name = fetchedUserName{
                        userToReturn.name = name
                    }
                    if let fetchedWeight = result.value(forKey: "weight") as? Double{
                        userToReturn.weight = Int(fetchedWeight)
                    }
                    if let gender = result.value(forKey: "gender") as? Int{
                        userToReturn.sex = gender
                        
                        switch gender
                        {
                        case 0 : genderField = "Male"
                        case 1 : genderField = "Female"
                        default: genderField = "?"
                        }
                    }
                }
            }
        } catch{
            print("fetch failed")
        }
        return userToReturn
    }
    func findLifts() -> [Lift]{
        let appDelegate = UIApplication.shared.delegate as! AppDelegate
        let context = appDelegate.persistentContainer.viewContext
        let exerciseRequest = NSFetchRequest<NSFetchRequestResult>(entityName: "Exercise")
        exerciseRequest.returnsObjectsAsFaults = false
        
        var lifts = [Lift()]
        
        do {
            let results = try context.fetch(exerciseRequest)
            if results.count > 0 {
                for result in results as! [NSManagedObject] {
                    let lift = Lift()
                    if let fetchedExerciseName = result.value(forKey: "exercise") as? String{
                        lift.exerciseName = fetchedExerciseName
                    }
                    if let fetchedExerciseWeight = result.value(forKey: "weight") as? Double {
                        lift.exerciseWeight = fetchedExerciseWeight
                    }
                    if lift.exerciseWeight != 0 && lift.exerciseName != ""{
                        lifts.append(lift)
                    }
                }
            }
        } catch {
            print("Error finding lifts")
        }
        return lifts

    }
    
    func calculateLifts() -> [String]{
        let calculate = MaxCalculator()
        let liftsToCalculate = findLifts()
        var descriptions = [String]()
        for lift in liftsToCalculate{
            let thisLiftDescription = calculate.recommendedSetsLbs(currMaxRepLbs: lift.exerciseWeight)
            if lift.exerciseName == "deadlift" {
                let deadliftDescription = thisLiftDescription
                descriptions.append(deadliftDescription)
            }
            if lift.exerciseName == "bench" {
                let benchDescription = thisLiftDescription
                descriptions.append(benchDescription)
            }
            if lift.exerciseName == "squat" {
                let squatDescription = thisLiftDescription
                descriptions.append(squatDescription)
            }
            print(thisLiftDescription)
        }
        return descriptions
    }
    
    
}
