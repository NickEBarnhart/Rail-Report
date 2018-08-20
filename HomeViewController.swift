//
//  HomeViewController.swift
//  Siemens_Reporter
//
//  Created by Nicholas Barnhart on 1/26/17.
//  Copyright © 2017 Nicholas Edward Barnhart. All rights reserved.
//

import UIKit

class HomeViewController: UIViewController {

    @IBOutlet weak var box1: UIButton!
    @IBOutlet weak var box2: UIButton!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        box1.layer.borderColor = UIColor.blue.cgColor
        box1.layer.borderWidth = 1.0
        box1.layer.cornerRadius = 5.0
        
        box2.layer.borderColor = UIColor.blue.cgColor
        box2.layer.borderWidth = 1.0
        box2.layer.cornerRadius = 5.0
        
    
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
