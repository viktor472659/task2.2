//
//  ViewController2.swift
//  task2.1
//
//  Created by Viktor on 02.12.2020.
//  Copyright © 2020 Viktor. All rights reserved.
//

import UIKit

class ViewController2: UIViewController {

   @IBOutlet weak var containerView: UIView!
    
    var circularView = CircularProgressView()
    var duration: TimeInterval!
    
    override func viewDidLoad() {
    super.viewDidLoad()
    circularView.center = view.center
    containerView.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(handleTap)))
    view.addSubview(circularView)
    }

    @objc func handleTap() {
    duration = 5    //Play with whatever value you want :]
    circularView.progressAnimation(duration: duration)
    }


}
