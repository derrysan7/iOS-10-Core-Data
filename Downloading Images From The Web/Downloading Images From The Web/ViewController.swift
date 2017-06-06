//
//  ViewController.swift
//  Downloading Images From The Web
//
//  Created by MacBookPro on 6/6/17.
//  Copyright © 2017 Binary. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    
    @IBOutlet var bachimageView: UIImageView!

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        let url = URL(string: "https://upload.wikimedia.org/wikipedia/commons/6/6a/Johann_Sebastian_Bach.jpg")!
        
        let request = NSMutableURLRequest(url: url)
        
        let task = URLSession.shared.dataTask(with: request as URLRequest){
            data,response,error in
            
            if error != nil {
                
                print(error)
                
            }else{
                
                if let data = data{ //force unwarp, if data is not nill then..
                    
                    if let bachImage = UIImage(data: data){
                        
                        self.bachimageView.image = bachImage
                        
                        //store image in device, jadi tidak reload dari web lagi
                        
                        
                        
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

