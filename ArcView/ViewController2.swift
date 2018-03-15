//
//  ViewController2.swift
//  ArcView
//
//  Created by Arabia -IT on 3/15/18.
//  Copyright © 2018 Arabia-IT. All rights reserved.
//

import UIKit

class ViewController2: UIViewController {
    
    @IBOutlet weak var sectorsView: SectorsView!

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        
        sectorsView.colors = [UIColor.red, .green, .blue]
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
