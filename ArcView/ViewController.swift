//
//  ViewController.swift
//  ArcView
//
//  Created by Arabia -IT on 12/31/17.
//  Copyright © 2017 Arabia-IT. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    
    @IBOutlet var arcView: ArcView!

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        
//        arcView.arcs = Array(stride(from: 0, to: 360, by: 45)).map({ ($0 + 10, $0 + 35) })
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

