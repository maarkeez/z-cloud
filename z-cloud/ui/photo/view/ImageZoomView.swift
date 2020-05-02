//
//  ImageZoomView.swift
//  z-cloud
//
//  Created by David Márquez Delgado on 01/05/2020.
//  Copyright © 2020 David Márquez Delgado. All rights reserved.
//

import UIKit

class ImageZoomView: UIScrollView, UIScrollViewDelegate  {
    var imageView: UIImageView!
    var gestureRecognizer: UITapGestureRecognizer!
    var saved = false
    var parentVC: UIViewController!
    
    convenience init(_ parentVC: UIViewController, frame: CGRect, image: UIImage) {
        self.init(frame: frame)
        self.parentVC = parentVC
        // Creates the image view and adds it as a subview to the scroll view
        imageView = UIImageView(image: image)
        imageView.frame = frame
        imageView.contentMode = .scaleAspectFit
        addSubview(imageView)
        
        setupScrollView()
        setupZoomGestureRecognizer()
        setupSaveGestureRecognizer()
    }
    
    // Sets the scroll view delegate and zoom scale limits.
    // Change the `maximumZoomScale` to allow zooming more than 2x.
    func setupScrollView() {
        delegate = self
        minimumZoomScale = 1.0
        maximumZoomScale = 20.0
    }
    
    // Tell the scroll view delegate which view to use for zooming and scrolling
    func viewForZooming(in scrollView: UIScrollView) -> UIView? {
        return imageView
    }
    
    // Sets up the gesture recognizer that receives double taps to auto-zoom
    func setupZoomGestureRecognizer() {
        gestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(handleDoubleTap))
        gestureRecognizer.numberOfTapsRequired = 2
        addGestureRecognizer(gestureRecognizer)
    }
    
    // Handles a double tap by either resetting the zoom or zooming to where was tapped
    @objc func handleDoubleTap() {
        if zoomScale == 1 {
            zoom(to: zoomRectForScale(maximumZoomScale, center: gestureRecognizer.location(in: gestureRecognizer.view)), animated: true)
        } else {
            setZoomScale(1, animated: true)
        }
    }
    
    // Calculates the zoom rectangle for the scale
    func zoomRectForScale(_ scale: CGFloat, center: CGPoint) -> CGRect {
        var zoomRect = CGRect.zero
        zoomRect.size.height = imageView.frame.size.height / scale
        zoomRect.size.width = imageView.frame.size.width / scale
        let newCenter = convert(center, from: imageView)
        zoomRect.origin.x = newCenter.x - (zoomRect.size.width / 2.0)
        zoomRect.origin.y = newCenter.y - (zoomRect.size.height / 2.0)
        return zoomRect
    }
    
    
    func setupSaveGestureRecognizer() {
        let gestureRecognizer = UILongPressGestureRecognizer(target: self, action: #selector(showSaveImageMenu))
        gestureRecognizer.minimumPressDuration = 1.0
        gestureRecognizer.delaysTouchesBegan = true
        addGestureRecognizer(gestureRecognizer)
    }
    
    
    @objc func showSaveImageMenu(){
        if(!saved){
            saved = true
            print("Saving...")
            UIImageWriteToSavedPhotosAlbum(imageView.image!, self, #selector(afterSaveImage(_:didFinishSavingWithError:contextInfo:)), nil)
        }
    }
    
    @objc func afterSaveImage(_ image: UIImage, didFinishSavingWithError error: Error?, contextInfo: UnsafeRawPointer) {
        if let error = error {
            let ac = UIAlertController(title: "Save error", message: error.localizedDescription, preferredStyle: .alert)
            ac.addAction(UIAlertAction(title: "OK", style: .default))
            parentVC.present(ac, animated: true)
        } else {
            let ac = UIAlertController(title: "Save success", message: "Your image has been saved to your photo gallery.", preferredStyle: .alert)
            ac.addAction(UIAlertAction(title: "OK", style: .default))
            parentVC.present(ac, animated: true)
        }
    }
    
    
}
