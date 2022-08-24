//
//  ViewController.swift
//  day06
//
//  Created by Kyu jin Lee on 2022/08/24.
//

import UIKit
import CoreMotion


let myColor = [UIColor.red,
               UIColor.orange,
               UIColor.yellow,
               UIColor.green,
               UIColor.blue,
               UIColor.purple]

class ViewController: UIViewController {
    var dynamicAnimator = UIDynamicAnimator()
    var gravity = UIGravityBehavior()
    var collision = UICollisionBehavior()
    var itemBehavior = UIDynamicItemBehavior()
    var motionManager = CMMotionManager()
    @IBOutlet weak var image: UIImageView!
    
    @IBAction func tap(_ sender: UITapGestureRecognizer) {
        let location = sender.location(in: view)
        let shape = UIView(frame: CGRect(x: location.x - 50, y: location.y - 50, width: 100, height: 100))
        if arc4random_uniform(2) == 1 {
            shape.layer.cornerRadius = CGFloat(50)
        }
        shape.backgroundColor = myColor[Int(arc4random_uniform(UInt32(myColor.count)))]
        shape.isUserInteractionEnabled = true
        shape.clipsToBounds = true
        self.view.addSubview(shape)
        
        addPhysics(shape)
        addGesture(shape)
        
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        dynamicAnimator = UIDynamicAnimator(referenceView: view)
        gravity = UIGravityBehavior(items: [])
        collision = UICollisionBehavior(items: [])
        itemBehavior = UIDynamicItemBehavior(items: [])
        
        itemBehavior.elasticity = 1
        collision.translatesReferenceBoundsIntoBoundary = true
        
        dynamicAnimator.addBehavior(gravity)
        dynamicAnimator.addBehavior(collision)
        dynamicAnimator.addBehavior(collision)
    
        
        if motionManager.isAccelerometerAvailable {
            motionManager.accelerometerUpdateInterval = 0.1
            motionManager.startAccelerometerUpdates(to: OperationQueue.main){ (data, error) in
                guard let d = data else { return }
                let accelerationX = CGFloat(d.acceleration.x);
                let accelerationY = CGFloat(d.acceleration.y);
                let accelerationVector = CGVector(dx: accelerationX, dy: -accelerationY);
                self.gravity.gravityDirection = accelerationVector;
            }
        }
    }
    
    func addPhysics(_ item: UIView) {
        gravity.addItem(item)
        collision.addItem(item)
        itemBehavior.addItem(item)
    }
    
    func removePhysics(_ item: UIView) {
        gravity.removeItem(item)
        collision.removeItem(item)
        itemBehavior.removeItem(item)
    }
    
    func addGesture(_ item: UIView) {
        
        let panGesture = UIPanGestureRecognizer(target: self, action: #selector(pan(sender:)))
        item.addGestureRecognizer(panGesture)
        let pinchGesture = UIPinchGestureRecognizer(target: self, action: #selector(pinch(sender:)))
        item.addGestureRecognizer(pinchGesture)
        let rotateGesture = UIRotationGestureRecognizer(target: self, action: #selector(rotate(sender:)))
        item.addGestureRecognizer(rotateGesture)
    }
    
    @objc func pan(sender: UIPanGestureRecognizer) {
        guard let item = sender.view else {
            return
        }
        if sender.state == .changed {
            removePhysics(item)

            item.center = sender.location(in: item.superview)
            dynamicAnimator.updateItem(usingCurrentState: item)
            addPhysics(item)

        }
    }
    
    @objc func pinch(sender: UIPinchGestureRecognizer) {
        guard let item = sender.view else {
            return
        }
        if sender.state == .changed {
            removePhysics(item)
            item.layer.bounds.size.width *= sender.scale
            item.layer.bounds.size.height *= sender.scale
            if (item.layer.cornerRadius != 0) {
                item.layer.cornerRadius *= sender.scale
            }
            sender.scale = 1.0
            
            addPhysics(item)
        }
    }
    
    @objc func rotate(sender: UIRotationGestureRecognizer) {
        guard let item = sender.view else {
            return
        }
        if sender.state == .changed {
            removePhysics(item)
            item.transform = item.transform.rotated(by: sender.rotation)
            dynamicAnimator.updateItem(usingCurrentState: item)
            sender.rotation = 0

            addPhysics(item)
        }
    }
}

