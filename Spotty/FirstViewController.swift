//
//  FirstViewController.swift
//  Spotty
//
//  Created by David Krystall on 2/11/17.
//  Copyright © 2017 David Krystall. All rights reserved.
//

import UIKit
import CoreData

class FirstViewController: UIViewController {
    @IBOutlet var userName: UILabel!
    var accountMade = false
    var currentUser:Profile?
    var genderField:String?
    var liftsToCalculate = [Lift]()
    
    @IBOutlet var suggestionLabel: UILabel!
    override func viewDidLoad() {
        
        super.viewDidLoad()
        
        if let alreadyMade = UserDefaults.standard.value(forKey: "AccountMadeAlready") as? Bool {
            accountMade = alreadyMade
            
        }
        
        let appDelegate = UIApplication.shared.delegate as! AppDelegate
        let context = appDelegate.persistentContainer.viewContext
        let request = NSFetchRequest<NSFetchRequestResult>(entityName: "Profile")
        request.returnsObjectsAsFaults = false
        let exerciseRequest = NSFetchRequest<NSFetchRequestResult>(entityName: "Exercise")
        exerciseRequest.returnsObjectsAsFaults = false
        
        var lifts = [Lift]()
        
        do{
            let results = try context.fetch(request)
            if results.count > 0 {
                for result in results as! [NSManagedObject] {
                    let fetchedUserName = result.value(forKey: "name") as? String
                    userName.text = fetchedUserName
                    if let name = fetchedUserName{
                        currentUser?.name = name
                    }
                    if let fetchedWeight = result.value(forKey: "weight") as? Double{
                        currentUser?.weight = fetchedWeight
                    }
                    if let gender = result.value(forKey: "gender") as? Int{
                        currentUser?.sex = Int16(gender)
                        
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
                    lifts.append(lift)
                }
                for lift in lifts {
                    print (lift.exerciseName.description)
                    print (lift.exerciseWeight.description)
                    liftsToCalculate.append(lift)
                }
            }
        } catch {
            
        }
        
        self.navigationController?.hidesBarsOnTap = true
        // Do any additional setup after loading the view, typically from a nib.
        
        if !accountMade {
            let alert = UIAlertController.init(title: "Account Made Successfully", message: "Don't hurt yourself.", preferredStyle: .alert)
            let ok = UIAlertAction.init(title: "Yay!", style: UIAlertActionStyle.default, handler: nil)
            alert.addAction(ok)
            self.present(alert, animated: true, completion: nil)
        }
        setupMenu()
        calculateLifts()
    }
    
    @IBOutlet var deadliftLabel: UILabel!
    @IBOutlet var deadliftDescriptionLabel: UILabel!
    @IBOutlet var benchLabel: UILabel!
    @IBOutlet var benchDescriptionLabel: UILabel!
    @IBOutlet var squatLabel: UILabel!
    @IBOutlet var squatDescriptionLabel: UILabel!
    
    func setupMenu(){
        suggestionLabel.text = "Based on your 1 Rep Max, Here is our suggested strength workout"
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    func calculateLifts(){
        deadliftLabel.text = "Dead Lifts"
        benchLabel.text = "Bench Press"
        squatLabel.text = "Squats"
        let calculate = MaxCalculator()
        for lift in liftsToCalculate{
            let thisLiftDescription = calculate.recommendedSetsLbs(currMaxRepLbs: lift.exerciseWeight)
            if lift.exerciseName == "deadlift" {
                deadliftDescriptionLabel.text = thisLiftDescription
            }
            if lift.exerciseName == "bench" {
                benchDescriptionLabel.text = thisLiftDescription
            }
            if lift.exerciseName == "squat" {
                squatDescriptionLabel.text = thisLiftDescription
            }
            print(thisLiftDescription)
        }
    }
    
    
}

class Lift {
    public var exerciseName:String = ""
    public var exerciseWeight:Double = 0
}

