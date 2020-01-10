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
    var shift: CGFloat = 0
    var innerRadiusFactor: CGFloat = 0
    var sign: CGFloat = 1
    var strokeWidthFactor: CGFloat = 0
    
    var colors = [UIColor.red, .green, .blue, .yellow, .orange, .purple]
    
    @objc private func reload() {
        self.sectorsView.transform = self.sectorsView.transform.rotated(by: CGFloat(-0.1).degreesToRadians)
        self.innerRadiusFactor += 0.0025 * self.sign
        self.strokeWidthFactor += 0.0025 * self.sign
        self.sectorsView.reloadData()
        
        if self.innerRadiusFactor > 1 {
            self.sign = -1
        } else if self.innerRadiusFactor < 0 {
            self.sign = 1
        }        
    }

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        sectorsView.dataSource = self
        sectorsView.delegate = self
        
        let link = CADisplayLink(target: self, selector: #selector(reload))
        link.add(to: .main, forMode: .defaultRunLoopMode)
        
        /*Timer.scheduledTimer(withTimeInterval: 0.1, repeats: true) { (_) in
            UIView.animate(withDuration: 0.1, animations: {
                self.sectorsView.transform = self.sectorsView.transform.rotated(by: CGFloat(-0.5).degreesToRadians)
            })
            self.innerRadiusFactor += 0.01 * self.sign
            self.strokeWidthFactor += 0.01 * self.sign
            self.sectorsView.reloadData()
        }
        
        Timer.scheduledTimer(withTimeInterval: 10, repeats: true) { (_) in
            self.sign *= -1
        }*/
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
    func shiftAngleInDegrees(inSectorsView sectorsView: SectorsView) -> CGFloat {
        return shift
    }
    
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
        return max(0, strokeWidthFactor * 5)
    }
    
    func outerRadiusFactor(inSectorsView sectorsView: SectorsView) -> CGFloat {
        return 0.99
    }
    
    func innerRadiusFactor(inSectorsView sectorsView: SectorsView) -> CGFloat {
        return innerRadiusFactor
    }
    
    
}

// MARL: - SectorsViewDelegate
extension ViewController2: SectorsViewDelegate {
    func sectorsView(_ sectorsView: SectorsView, didSelectSectorAtIndex index: Int) {
        print(index)
    }
    
    
}
