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

    @IBOutlet var logOutButton: UIButton!
    @IBAction func logOut(_ sender: Any) {
        
        let appDelegate = UIApplication.shared.delegate as! AppDelegate
        
        let context = appDelegate.persistentContainer.viewContext
        
        let request = NSFetchRequest<NSFetchRequestResult>(entityName: "Users")
        
        do {
            
            let results = try context.fetch(request)
            
            if results.count > 0 {
                
                for result in results as! [NSManagedObject] {
                    
                    context.delete(result)
                    
                    do{
                        
                        try context.save()
                        
                    }catch{
                        
                        
                        print("Individual delete failed")
                        
                    }
                    
                }
                
                label.alpha = 0
                
                logOutButton.alpha = 0
                
                loginButton.setTitle("Login", for: [])
                
                isLoggedin = false
                
                textField.alpha = 1
                
            }
            
        }catch{
            
            print("Delete failed")
            
        }
        
    }
    
    @IBOutlet var textField: UITextField!
    
    @IBOutlet var label: UILabel!
    
    var isLoggedin = false
    
    @IBOutlet var loginButton: UIButton!
    @IBAction func login(_ sender: Any) {
        
        let appDelegate = UIApplication.shared.delegate as! AppDelegate
        
        let context = appDelegate.persistentContainer.viewContext
        
        if isLoggedin {
            
            let request = NSFetchRequest<NSFetchRequestResult>(entityName: "User")
            
            do{
                
                let results = try context.fetch(request)
                
                if results.count > 0 {
                    
                    for result in results as! [NSManagedObject]{
                        
                        result.setValue(textField.text, forKey: "name")
                        
                        do{
                            
                            try context.save()
                            
                        }catch{
                            
                            print("Update username save failed")
                            
                        }
                        
                    }
                    
                  label.text = "Hi there " + textField.text! + "!"
                    
                }
                
            }catch{
                
                
                print("Update username failed")
                
            }
            
        }else{
            
            let newValue = NSEntityDescription.insertNewObject(forEntityName: "Users", into: context)
            
            newValue.setValue(textField.text, forKey: "name")
            
            do{
                
                try context.save()
                
                
                loginButton.setTitle("Update username", for: [])
                
                logOutButton.alpha = 1
                
                label.alpha = 1
                
                label.text = "Hi there " + textField.text! + "!"
                
                isLoggedin = true
                
            }catch{
                
                print("Failed to save")
                
            }
            
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
                    
                    textField.alpha = 1
                    
                    loginButton.setTitle("Update username", for: [])
                    
                    logOutButton.alpha = 1
                    
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

