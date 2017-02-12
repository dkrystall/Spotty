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
    override func viewDidLoad() {
        
        super.viewDidLoad()
        
        if let alreadyMade = UserDefaults.standard.value(forKey: "AccountMadeAlready") as? Bool {
            accountMade = alreadyMade
        }
        
        let appDelegate = UIApplication.shared.delegate as! AppDelegate
        let context = appDelegate.persistentContainer.viewContext
        let request = NSFetchRequest<NSFetchRequestResult>(entityName: "Profile")
        request.returnsObjectsAsFaults = false
        
        do{
            let results = try context.fetch(request)
            if results.count > 0 {
                for result in results as! [NSManagedObject] {
                    let fetchedUserName = result.value(forKey: "name") as? String
                    userName.text = fetchedUserName
                    print(userName.text)
                }
            }
        } catch{
            print("fetch failed")
        }
        
        self.navigationController?.hidesBarsOnTap = true
        // Do any additional setup after loading the view, typically from a nib.
        
        if !accountMade {
            let alert = UIAlertController.init(title: "Account Made Successfully", message: "Don't hurt yourself.", preferredStyle: .alert)
            let ok = UIAlertAction.init(title: "Yay!", style: UIAlertActionStyle.default, handler: nil)
            alert.addAction(ok)
            self.present(alert, animated: true, completion: nil)
        }
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

