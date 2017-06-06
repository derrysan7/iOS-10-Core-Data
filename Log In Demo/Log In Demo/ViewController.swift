//
//  ViewController.swift
//  Log In Demo
//
//  Created by MacBookPro on 6/6/17.
//  Copyright © 2017 Binary. All rights reserved.
//

import UIKit
import CoreData

class ViewController: UIViewController {

    @IBOutlet var textField: UITextField!
    
    @IBOutlet var label: UILabel!
    
    @IBOutlet var loginButton: UIButton!
    @IBAction func login(_ sender: Any) {
        
        let appDelegate = UIApplication.shared.delegate as! AppDelegate
        
        let context = appDelegate.persistentContainer.viewContext
        
        let newValue = NSEntityDescription.insertNewObject(forEntityName: "Users", into: context)
        
        newValue.setValue(textField.text, forKey: "name")
        
        do{
            
            try context.save()
            
            textField.alpha = 0
            
            loginButton.alpha = 0
            
            label.alpha = 1
            
            label.text = "Hi there " + textField.text! + "!"
            
        }catch{
            
            print("Failed to save")
            
        }
        
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
    
        let appDelegate = UIApplication.shared.delegate as! AppDelegate
        
        let context = appDelegate.persistentContainer.viewContext
        
        let request = NSFetchRequest<NSFetchRequestResult>(entityName: "Users")
        
        request.returnsObjectsAsFaults = false
        
        do {
            
            let results = try context.fetch(request)
            
            for result in results as! [NSManagedObject] {
                
                if let username = result.value(forKey: "name") as? String {
                    
                    textField.alpha = 0
                    
                    loginButton.alpha = 0
                    
                    label.alpha = 1
                    
                    label.text = "Hi there " + username + "!"
                    
                }
                
            }
            
        } catch {
            
            print("Request failed")
            
        }
    
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

