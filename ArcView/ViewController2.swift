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
    
    var colors = [UIColor.red, .green, .blue, .yellow, .orange, .purple]
    

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        sectorsView.dataSource = self
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

// MARK: - SectorsViewDataSource
extension ViewController2: SectorsViewDataSource {
    func numberOfSectors(inSectorsView sectorsView: SectorsView) -> Int {
        return 10
    }
    
    func sectorsView(_ sectorsView: SectorsView, fillColorForSectorAtIndex index: Int) -> CGColor {
        return colors[index % colors.count].cgColor
    }
    
    func sectorsView(_ sectorsView: SectorsView, strokeColorForSectorAtIndex index: Int) -> CGColor {
        return UIColor.black.cgColor
    }
    
    func sectorsView(_ sectorsView: SectorsView, strokeWidthForSectorAtIndex index: Int) -> CGFloat {
        return 0.5
    }
    
    func outerRadiusFactor(inSectorsView sectorsView: SectorsView) -> CGFloat {
        return 0.9
    }
    
    func innerRadiusFactor(inSectorsView sectorsView: SectorsView) -> CGFloat {
        return 0.0
    }
    
    
}
