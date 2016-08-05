//
//  ViewController.swift
//  uploadImage
//
//  Created by hoaqt on 7/31/16.
//  Copyright © 2016 com.noron. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    
    var lastPoint = CGPoint.zero
    
    var originalImage = UIImage()
    
    var editedImage = UIImage()
    
    var brushWidth: CGFloat = 50.0

    var opacity: CGFloat = 1.0
    
    var isDrawing = false

    @IBOutlet weak var imageView: UIImageView!
    
    @IBAction func onSaveButtonTap(sender: UIBarButtonItem) {
        print("Uploading")
        print(originalImage)
        print(editedImage)
        
    }
    @IBAction func onClearButtonTap(sender: UIBarButtonItem) {
        
        imageView.image = originalImage
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        let vc = UIImagePickerController()
        vc.delegate = self
        vc.allowsEditing = true
        vc.sourceType = UIImagePickerControllerSourceType.PhotoLibrary
        
        self.presentViewController(vc, animated: true, completion: nil)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    func drawLine(image:UIImage, fromPoint: CGPoint, toPoint: CGPoint) {
        
        let image = imageView.image!

        UIGraphicsBeginImageContext(view.frame.size)
        let context = UIGraphicsGetCurrentContext()
        image.drawInRect(CGRect(x: 0, y: 0, width: view.frame.width, height: view.frame.height))

        
        CGContextSetLineCap(context, CGLineCap.Round)
        CGContextSetLineWidth(context, brushWidth)
        CGContextSetStrokeColorWithColor(context, UIColor.blackColor().CGColor)
        
        CGContextMoveToPoint(context, fromPoint.x, fromPoint.y)
        CGContextAddLineToPoint(context, toPoint.x, toPoint.y)
        
        CGContextStrokePath(context)
        
       
        let newImage = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()
        imageView.image = newImage
        
        
    }
    
    override func touchesBegan(touches: Set<UITouch>, withEvent event: UIEvent?) {
        isDrawing = false
        let touch = touches.first as UITouch!
        lastPoint = touch.locationInView(view)
    }
    
    override func touchesMoved(touches: Set<UITouch>, withEvent event: UIEvent?) {
        if let touch = touches.first {
            let currentPoint = touch.locationInView(view)
            drawLine(imageView.image!, fromPoint: lastPoint, toPoint: currentPoint)
            
            lastPoint = currentPoint
        }
    }
    
    override func touchesEnded(touches: Set<UITouch>, withEvent event: UIEvent?) {
        
        editedImage = imageView.image!
    }


}

extension ViewController: UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    func imagePickerController(picker: UIImagePickerController, didFinishPickingImage image: UIImage, editingInfo: [String : AnyObject]?) {
        originalImage = image
        imageView.image = originalImage
        dismissViewControllerAnimated(true, completion: nil)
    }
}

