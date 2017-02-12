//
//  WorkoutDescriptionViewController.swift
//  Spotty
//
//  Created by David Krystall on 2/12/17.
//  Copyright © 2017 David Krystall. All rights reserved.
//

import UIKit

class WorkoutDescriptionViewController: UIViewController {
    var lift:Lift?
    
    @IBOutlet var exerciseLabel: UILabel!
    
    @IBOutlet var exerciseDescriptionLabel: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        let calculator = MaxCalculator()
        if lift != nil {
            print(lift?.exerciseName)
            print(lift?.exerciseWeight)
            exerciseLabel.text = lift?.exerciseName
            exerciseDescriptionLabel.text = calculator.recommendedSetsLbs(currMaxRepLbs: (lift?.exerciseWeight)!)
        }

        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
