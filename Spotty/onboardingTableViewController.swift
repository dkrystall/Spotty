//
//  onboardingTableViewController.swift
//  Spotty
//
//  Created by David Krystall on 2/11/17.
//  Copyright © 2017 David Krystall. All rights reserved.
//

import UIKit
import CoreData

class onboardingTableViewController: UITableViewController {
    @IBOutlet var navigation: UINavigationItem!
    let appDelegate = UIApplication.shared.delegate as! AppDelegate
    var appContext:NSManagedObjectContext?
    @IBOutlet var sexSegmentedControl: UISegmentedControl!
    @IBOutlet var weightTextField: UITextField!
    @IBOutlet var heightTextField: UITextField!
    @IBOutlet var experienceSegmentControl: UISegmentedControl!
    @IBOutlet var nameTextFIeld: UITextField!
    @IBOutlet var benchTextField: UITextField!
    @IBOutlet var squatTextField: UITextField!
    @IBOutlet var deadliftTextField: UITextField!
    @IBOutlet var rowTextField: UITextField!
    var accountAlreadyMade = false
    override func viewDidLoad() {
        super.viewDidLoad()
        print("setting up table")
        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false
        
        // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
        // self.navigationItem.rightBarButtonItem = self.editButtonItem()
    }
    override func viewDidAppear(_ animated: Bool) {
        appContext = appDelegate.persistentContainer.viewContext
        
        let request = NSFetchRequest<NSFetchRequestResult>(entityName: "Profile")
        request.returnsObjectsAsFaults = false
        do {
            let results = try appContext?.fetch(request)
            if (results?.count)! > 0 {
                performSegue(withIdentifier: "mainSegue", sender: self)
                print("Account already exists")
                accountAlreadyMade = true
                UserDefaults.standard.setValue(true, forKey: "AccountMadeAlready")
            }
        } catch {
            print("error")
        }
    }
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    // MARK: - Table view data source
    
    override func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 2
    }
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        switch section{
        case 0:
            return 5
        case 1:
            return 4
        default:
            return 0
        }
    }
    /*
     * Sex 0 = Male, Sex 1 = Female
     * Saves the profile to the context
     */
    func createWeights(){
        
        if let benchText = benchTextField.text{
            if let context = appContext{
                do{
                    let benchWeight = Double(benchText)
                    if let newExercise = NSEntityDescription.insertNewObject(forEntityName: "Exercise", into: context) as? Exercise {
                        newExercise.exercise = "bench"
                        newExercise.setValue(newExercise.exercise, forKey: "exercise")
                        newExercise.weight = benchWeight!
                        newExercise.setValue(newExercise.weight, forKey: "weight")
                        try context.save()
                    }
                }catch {
                    print("Failed to save bench")
                }
            }
            if let squatText = squatTextField.text{
                if let context = appContext{
                    do{
                        let squatWeight = Double(squatText)
                        if let newExercise = NSEntityDescription.insertNewObject(forEntityName: "Exercise", into: context) as? Exercise {
                            newExercise.exercise = "squat"
                            newExercise.setValue(newExercise.exercise, forKey: "exercise")
                            newExercise.weight = squatWeight!
                            newExercise.setValue(newExercise.weight, forKey: "weight")
                            try context.save()
                        }
                    }
                    catch {
                        print("Failed to save squat")
                    }
                }
            }
            if let deadliftText = deadliftTextField.text{
                if let context = appContext{
                    do{
                        let deadliftWeight = Double(deadliftText)
                        if let newExercise = NSEntityDescription.insertNewObject(forEntityName: "Exercise", into: context) as? Exercise {
                            newExercise.exercise = "deadlift"
                            newExercise.setValue(newExercise.exercise, forKey: "exercise")
                            newExercise.weight = deadliftWeight!
                            newExercise.setValue(newExercise.weight, forKey: "weight")
                            try context.save()
                        }
                    }
                    catch {
                        print("failed to save deadlift")
                    }
                }
            }
            if let rowText = rowTextField.text{
                if let context = appContext{
                    do{
                        let rowWeight = Double(rowText)
                        if let newExercise = NSEntityDescription.insertNewObject(forEntityName: "Exercise", into: context) as? Exercise {
                            newExercise.exercise = "row"
                            newExercise.setValue(newExercise.exercise, forKey: "exercise")
                            newExercise.weight = rowWeight!
                            newExercise.setValue(newExercise.weight, forKey: "weight")
                            try context.save()
                        }
                        
                    } catch {
                        print("Failed to save row")
                    }
                }
            }
        }
    }
    override func viewWillDisappear(_ animated: Bool) {
        //save context
        let sex = self.sexSegmentedControl.selectedSegmentIndex
        let experience:Int16 = Int16(self.experienceSegmentControl.selectedSegmentIndex)
        createWeights()
        if !accountAlreadyMade{
            do{
                if let context = appContext{
                    if let newUser = NSEntityDescription.insertNewObject(forEntityName: "Profile", into: context) as? Profile{
                        newUser.name = nameTextFIeld.text
                        newUser.setValue(newUser.name, forKey: "name")
                        sex > 0 ? (newUser.sex=1) : (newUser.sex = 0)
                        newUser.setValue(newUser.sex, forKey: "gender")
                        if let weight = Double(weightTextField.text!){
                            newUser.weight = weight
                            newUser.setValue(newUser.weight, forKey: "weight")
                            print("Weight set")
                        }
                        newUser.experience = experience
                        newUser.setValue(experience, forKey: "experience")
                        print("sex is: \(newUser.sex)")
                        try context.save()
                    }
                }
            }
            catch {
                print("Context Invalid")
            }
        }
    }
    
    @IBAction func nextPressed(_ sender: Any) {
        performSegue(withIdentifier: "mainSegue", sender: self)
    }
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        //let nav = self.navigationController
        self.navigationController!.viewControllers.removeAll()
    }
    
    /*
     // Override to support conditional editing of the table view.
     override func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
     // Return false if you do not want the specified item to be editable.
     return true
     }
     */
    
    /*
     // Override to support editing the table view.
     override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCellEditingStyle, forRowAt indexPath: IndexPath) {
     if editingStyle == .delete {
     // Delete the row from the data source
     tableView.deleteRows(at: [indexPath], with: .fade)
     } else if editingStyle == .insert {
     // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
     }
     }
     */
    
    /*
     // Override to support rearranging the table view.
     override func tableView(_ tableView: UITableView, moveRowAt fromIndexPath: IndexPath, to: IndexPath) {
     
     }
     */
    
    /*
     // Override to support conditional rearranging of the table view.
     override func tableView(_ tableView: UITableView, canMoveRowAt indexPath: IndexPath) -> Bool {
     // Return false if you do not want the item to be re-orderable.
     return true
     }
     */
    
    /*
     // MARK: - Navigation
     
     // In a storyboard-based application, you will often want to do a little preparation before navigation
     override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
     // Get the new view controller using segue.destinationViewController.
     // Pass the selected object to the new view controller.
     }
     */
    
}
