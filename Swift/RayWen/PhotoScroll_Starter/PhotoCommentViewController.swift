//
//  PhotoCommentViewController.swift
//  PhotoScroll
//
//  Created by Akshay Bhandary on 6/29/16.
//  Copyright © 2016 raywenderlich. All rights reserved.
//

import UIKit

public class PhotoCommentViewController: UIViewController {
  
  @IBOutlet weak var nameTextField: UITextField!
  @IBOutlet weak var scrollView: UIScrollView!
  @IBOutlet weak var imageView: UIImageView!
  

  public var photoName : String?
  public var photoIndex: Int?
  
  override public func viewDidLoad() {
    super.viewDidLoad()
    
    if let photoName = photoName {
      imageView.image = UIImage(named: photoName)
    }
    
    NotificationCenter.default().addObserver(
      self,
      selector: #selector(self.keyboardWillShow(notification:)),
      name: Notification.Name.UIKeyboardWillShow,
      object: nil)
    
    NotificationCenter.default().addObserver(
      self,
      selector: #selector(self.keyboardWillHide(notification:)),
      name: Notification.Name.UIKeyboardWillHide,
      object: nil)
  }
  
  override public func didReceiveMemoryWarning() {
    super.didReceiveMemoryWarning()
    // Dispose of any resources that can be recreated.
  }
  
  
  @IBAction func hideKeyboard(sender : AnyObject?) {
    
  
    nameTextField.endEditing(false)
  }
  
  @IBAction func openZoomingViewController(sender : AnyObject?) {
      performSegue(withIdentifier: "zooming", sender: nil)
  }
  
  
  
  
  private func adjustInsertForKeyboard(show : Bool, notification : Notification) {
    
    guard let value = notification.userInfo?[UIKeyboardFrameBeginUserInfoKey] as? NSValue else { return }
    
    let keyboardRect = value.cgRectValue()
    let adjustmentHeight = (keyboardRect.size.height + 20) * (show ? 1 : -1)
    scrollView.contentInset.bottom += adjustmentHeight
    scrollView.scrollIndicatorInsets.bottom += adjustmentHeight
  }
  
  func keyboardWillShow(notification : Notification) {
    
    adjustInsertForKeyboard(show: true, notification: notification)
  }
  
  func keyboardWillHide(notification: Notification) {
    
    adjustInsertForKeyboard(show: false, notification: notification)
  }
  
  deinit {
    NotificationCenter.default().removeObserver(self)
  }
  
  
   // MARK: - Navigation
   
   // In a storyboard-based application, you will often want to do a little preparation before navigation
   override public func prepare(for segue: UIStoryboardSegue, sender: AnyObject?) {
    if let id = segue.identifier,
       zoomedViewController = segue.destinationViewController as? ZoomedPhotoViewController
        where id == "zooming" {
      zoomedViewController.photoName = photoName
    }
    
   }

  
}
