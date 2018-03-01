//
//  ChooseDateViewController.swift
//  P5_CRM
//
//  Created by Sofia Vidal Urriza on 24/11/2017.
//  Copyright © 2017 Sofia Vidal Urriza. All rights reserved.
//

import UIKit

class ChooseDateViewController: UIViewController {
    
    
    @IBOutlet weak var firstDatePicker: UIDatePicker!
    @IBOutlet weak var lastDatePicker: UIDatePicker!
    
    
    
    // Para guardar/recuperar los valores introducidos anteriormente
    let defaults = UserDefaults.standard
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Recupero los valores de persistencia
        if let savedFirstDate = defaults.object(forKey: "firstDate") as? Date {
            firstDatePicker.date = savedFirstDate
        }
        if let savedLastDate = defaults.object(forKey: "lastDate") as? Date {
            lastDatePicker.date = savedLastDate
        }
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    override func shouldPerformSegue(withIdentifier identifier: String, sender: Any?) -> Bool {
        if identifier == "GoBackToVisitss" {
            if lastDatePicker.date > firstDatePicker.date {
                return true
            } else {
                print ("print alert")
                let alert = UIAlertController(title: "ERROR", message: "The introduced dates are not possible. Please introduce the again. ", preferredStyle: .alert)
                alert.addAction(UIAlertAction(title: "OK", style: .default))
                present(alert,animated: true)
                return false
            }
        }
        return true
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "GoBackToVisitss" {
            if let vcToVisits = segue.destination as? PrincipalTableViewController {
                
                vcToVisits.firstDate = firstDatePicker.date
                print ("LALALALA \(firstDatePicker.date)")
                
                vcToVisits.lastDate = lastDatePicker.date
                
                // Guardo preferencias
                defaults.set(firstDatePicker.date, forKey: "firstDate")
                defaults.set(lastDatePicker.date, forKey: "lastDate")
                defaults.synchronize()
                
            }
        }
    }
    
}
