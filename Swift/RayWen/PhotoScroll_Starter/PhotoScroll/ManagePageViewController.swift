//
//  ManagePageViewController.swift
//  PhotoScroll
//
//  Created by Akshay Bhandary on 6/30/16.
//  Copyright © 2016 raywenderlich. All rights reserved.
//

import UIKit

class ManagePageViewController: UIPageViewController {

    var photos = ["photo1", "photo2", "photo3", "photo4", "photo5"]
    var currentIndex : Int?
  
    override func viewDidLoad() {
        super.viewDidLoad()
      
        self.dataSource = self
      
        if let photoVC = viewPhotoCommentViewController(index: currentIndex ?? 0) {
        
            let viewControllers = [photoVC]
            setViewControllers(viewControllers,
                               direction: .forward,
                               animated: false,
                               completion: nil)
        }
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    func viewPhotoCommentViewController(index : Int) -> PhotoCommentViewController? {
    
        if let storyboard = storyboard,
            photoCommentVC = storyboard.instantiateViewController(withIdentifier: "PhotoCommentViewController") as? PhotoCommentViewController  {
        
            photoCommentVC.photoName = photos[index]
            photoCommentVC.photoIndex = index
            return photoCommentVC
        }
        return nil;
    }
  
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}

extension ManagePageViewController : UIPageViewControllerDataSource {
  
    func pageViewController(_ pageViewController: UIPageViewController, viewControllerBefore viewController: UIViewController) -> UIViewController? {
    
      if let photoCommentVC = viewController as? PhotoCommentViewController,
          photoIndex = photoCommentVC.photoIndex {
          guard  photoIndex != NSNotFound && photoIndex > 0 else { return nil }
          return viewPhotoCommentViewController(index: photoIndex - 1)
      }
      return nil;
  }
  
  func pageViewController(_ pageViewController: UIPageViewController, viewControllerAfter viewController: UIViewController) -> UIViewController? {
    
      if let photoCommentViewController = viewController as? PhotoCommentViewController,
          photoIndex = photoCommentViewController.photoIndex {
        
          guard photoIndex != NSNotFound && photoIndex < photos.count - 1 else { return nil }
          return viewPhotoCommentViewController(index: photoIndex + 1)
      }
      return nil
  }
  
  func presentationCount(for pageViewController: UIPageViewController) -> Int {
    return photos.count
  }
  
  func presentationIndex(for pageViewController: UIPageViewController) -> Int {
    return currentIndex ?? 0
  }
}
