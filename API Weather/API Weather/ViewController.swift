//
//  ViewController.swift
//  API Weather
//
//  Created by MacBookPro on 6/6/17.
//  Copyright © 2017 Binary. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet var cityTextField: UITextField!
    @IBOutlet var resultLabel: UILabel!
    @IBAction func submit(_ sender: Any) {
        
        if let url = URL(string: "http://api.openweathermap.org/data/2.5/weather?q=" + cityTextField.text!.replacingOccurrences(of: " ", with: "%20") + "&appid=a98efa86379313cb8f8b3eab0c1abe26") {
        
        let task = URLSession.shared.dataTask(with: url) { (data, response, error) in
            
            if error != nil {
                
                print(error)
                
            } else {
                
                if let urlContent = data {
                    
                    do {
                        
                        let jsonResult = try JSONSerialization.jsonObject(with: urlContent, options: JSONSerialization.ReadingOptions.mutableContainers) as AnyObject
                        
                        print(jsonResult)
                        
                        print(jsonResult["name"])
                        
                        if let description = ((jsonResult["weather"] as? NSArray)?[0] as? NSDictionary)?["description"] as? String{
                            
                            DispatchQueue.main.sync(execute: {
                                
                                self.resultLabel.text = description
                                
                            })
                            
                        }
                        
                    }catch{
                        
                        print("JSON Processing failed")
                        
                    }
                    
                }
                
            }
            
        }
        
        task.resume()
        
        } else {
            
            resultLabel.text = "Couldn't find weather for that city - please try another"
            
        }
        
        
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

