//
//  ViewController.swift
//  CustomTableSwift
//
//  Created by Kashif on 17/11/16.
//  Copyright © 2016 Kashif. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    @IBAction func btnAction(_ sender: UIButton) {
        let tableViewController = self.storyboard?.instantiateViewController(withIdentifier: "tableViewController") as! TableViewController
        self.present(tableViewController, animated: true, completion: nil)
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

