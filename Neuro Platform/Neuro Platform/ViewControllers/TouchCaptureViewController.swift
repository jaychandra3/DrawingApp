//
//  TouchCaptureViewController.swift
//  Neuro Platform
//
//  Created by user175482 on 7/14/20.
//  Copyright © 2020 NDDP. All rights reserved.
//

import UIKit

protocol TouchCaptureViewDelegate {
    func didStartDrag(_ sender : TouchCaptureViewController)
    func didDrag(_ sender : TouchCaptureViewController)
    func didFinishDrag(_ sender : TouchCaptureViewController)
}

class TouchCaptureViewController: UIViewController {
    
    var delegate : TouchCaptureViewDelegate?
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        super.touchesBegan(touches, with : event)
        delegate?.didStartDrag(self)
    }
    
    override func touchesMoved(_ touches: Set<UITouch>, with event: UIEvent?) {
        super.touchesMoved(touches, with: event)
        if let touch = touches.first {
            print (touch.altitudeAngle)
            print (touch.azimuthAngle(in: self.view))
            print (touch.force)
        }
    }
    
    override func touchesEnded(_ touches: Set<UITouch>, with event: UIEvent?) {
        super.touchesEnded(touches, with: event)
    }

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
