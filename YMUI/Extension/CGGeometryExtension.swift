//
//  CGGeometryExtension.swift
//  YMUI
//
//  Created by Yanke Guo on 16/2/1.
//  Copyright © 2016年 JuXian(Beijing) Technology Co., Ltd. All rights reserved.
//

import UIKit

public func CGRectGetCenter(rect: CGRect) -> CGPoint {
  return CGPointMake(CGRectGetMidX(rect), CGRectGetMidY(rect))
}

public func CGSizeAspectFill(target: CGSize, _ source: CGSize) -> CGSize {
  let targetRatio = target.width / target.height
  let sourceRatio = source.width / source.height

  if (targetRatio > sourceRatio) {
    let widthScale = target.width / source.width
    return CGSizeMake(target.width, source.height * widthScale)
  } else {
    let heightScale = target.height / source.height
    return CGSizeMake(source.width * heightScale, target.height)
  }
}

public func CGSizeScale(size: CGSize, _ scale: CGFloat) -> CGSize {
  return CGSizeMake(size.width * scale, size.height * scale)
}

public func CGRectCreateCenterSize(center: CGPoint, _ size: CGSize) -> CGRect {
  return CGRectMake(center.x - size.width/2, center.y - size.height/2, size.width, size.height)
}
