//
//  UIViewExtension.swift
//  YMUI
//
//  Created by Yanke Guo on 16/2/1.
//  Copyright © 2016年 JuXian(Beijing) Technology Co., Ltd. All rights reserved.
//

import UIKit

extension UIView {

  public var size: CGSize {
    get {
      return self.frame.size
    }
    set(value) {
      var frame = self.frame
      frame.size = value
      self.frame = frame
    }
  }

  public var origin: CGPoint {
    get {
      return self.frame.origin
    }
    set(value) {
      var frame = self.frame
      frame.origin = value
      self.frame = frame
    }
  }

  public var width: CGFloat {
    get {
      return self.size.width
    }
    set(value) {
      var size = self.size
      size.width = value
      self.size = size
    }
  }

  public var height: CGFloat {
    get {
      return self.size.height
    }
    set(value) {
      var size = self.size
      size.height = value
      self.size = size
    }
  }

}
