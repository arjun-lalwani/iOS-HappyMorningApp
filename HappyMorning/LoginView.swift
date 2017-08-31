//
//  LoginView.swift
//  HappyMorning
//
//  Created by Arjun Lalwani on 8/31/17.
//  Copyright © 2017 Arjun Lalwani. All rights reserved.
//

import UIKit

class LoginView: UIView {

    override init(frame: CGRect) {
        super.init(frame: frame)
        
        didLoad()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
    func didLoad() {
        self.layer.backgroundColor = UIColor(patternImage: UIImage(named: "sunrise")!)
    }
    
    
    /*
    // Only override draw() if you perform custom drawing.
    // An empty implementation adversely affects performance during animation.
    override func draw(_ rect: CGRect) {
        // Drawing code
     
    }
    */

}
