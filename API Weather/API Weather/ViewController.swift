//
//  ViewController.swift
//  API Weather
//
//  Created by MacBookPro on 6/6/17.
//  Copyright © 2017 Binary. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        let url = URL(string: "http://api.openweathermap.org/data/2.5/weather?q=London&appid=a98efa86379313cb8f8b3eab0c1abe26")!
        
        let task = URLSession.shared.dataTask(with: url) { (data, response, error) in
            
            if error != nil {
                
                print(error)
                
            } else {
                
                if let urlContent = data {
                    
                    do {
                    
                        let jsonResult = try JSONSerialization.jsonObject(with: urlContent, options: JSONSerialization.ReadingOptions.mutableContainers) as AnyObject
                    
                        print(jsonResult)
                        
                    }catch{
                        
                        print("JSON Processing failed")
                        
                    }
                    
                }
                
            }
            
        }
        
        task.resume()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

