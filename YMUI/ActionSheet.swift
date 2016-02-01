//
//  ActionSheet.swift
//  YMUI
//
//  Created by Yanke Guo on 16/2/1.
//  Copyright © 2016年 JuXian(Beijing) Technology Co., Ltd. All rights reserved.
//

import UIKit

public class ActionSheet: UIView {

  public typealias Action = () -> Void

  public static var DefaultTextItemColor = UIColor.blackColor()

  public static var DefaultButtonItemTitleColor = UIColor.blackColor()

  public static var DefaultSeperatorItemColor   = UIColor.groupTableViewBackgroundColor()

  private struct ActionSheetItem {

    enum Type {
      case Text
      case Seperator
      case Button
    }

    let type: Type

    let title: String?

    let color: UIColor

    let action: Action?
  }

  /// If backgroundAction is set, touch on background will invoke backgroundAction and dismiss
  /// Default to a empty block
  public var backgroundAction: Action? = {}

  private var items = [ActionSheetItem]()

  private var itemViews   = [UIView]()

  private var otherViews  = [UIView]()

  private var backgroundView = UIView()

  public override init(frame: CGRect) {
    super.init(frame: frame)
    _init()
  }

  public required init?(coder aDecoder: NSCoder) {
    super.init(coder: aDecoder)
    _init()
  }

  private func _init() {
    self.backgroundView.backgroundColor = UIColor.blackColor().colorWithAlphaComponent(0.4)
    self.backgroundView.userInteractionEnabled = true
    self.backgroundView.addGestureRecognizer(UITapGestureRecognizer(target: self, action: "onBackgroundTouched:"))

    self.backgroundColor = UIColor.whiteColor()
    self.userInteractionEnabled = true
  }

  /**
   Add a text item

   - parameter text: text to show
   */
  public func addTextItem(text: String) {
    self.items.append(ActionSheetItem(type: .Text, title: text, color: ActionSheet.DefaultTextItemColor, action: nil))
  }

  public func addButtonItem(title: String, titleColor: UIColor? = nil, action: Action?) {
    self.items.append(ActionSheetItem(type: .Button, title: title, color: titleColor ?? ActionSheet.DefaultButtonItemTitleColor, action: action))
  }

  public func addSeperatorItem() {
    self.items.append(ActionSheetItem(type: .Seperator, title: nil, color: ActionSheet.DefaultSeperatorItemColor, action: nil))
  }

  public func show(view: UIView) {
    // Prepare backgroundView
    self.backgroundView.frame = view.bounds
    self.backgroundView.alpha = 0
    view .addSubview(self.backgroundView)

    //  Clean old views
    for view in self.itemViews {
      view.removeFromSuperview()
    }
    self.itemViews.removeAll()

    for view in self.otherViews {
      view.removeFromSuperview()
    }
    self.otherViews.removeAll()

    // Add items

    var currentY: CGFloat = 0

    for item in self.items {
      switch item.type {
      case .Seperator:
        let view = UIView(frame: CGRectMake(0, currentY, CGRectGetWidth(view.bounds), 8))
        view.backgroundColor = item.color
        self.itemViews.append(view)
        self.addSubview(view)

        currentY += 8
      case .Button:
        let button = UIButton(type: .Custom)
        button.frame = CGRectMake(0, currentY, CGRectGetWidth(view.bounds), 50)
        button.setTitle(item.title, forState: .Normal)
        button.setTitleColor(item.color, forState: .Normal)
        button.titleLabel?.font = UIFont.systemFontOfSize(16)
        button.addTarget(self, action: "onButtonItemTouched:", forControlEvents: .TouchUpInside)

        self.itemViews.append(button)
        self.addSubview(button)

        currentY += 50
      case .Text:
        let label = UILabel(frame: CGRectMake(0, currentY, CGRectGetWidth(view.bounds), 50))
        label.textColor = item.color
        label.font = UIFont.systemFontOfSize(14)
        label.textAlignment = .Center
        label.text = item.title

        self.itemViews.append(label)
        self.addSubview(label)

        currentY += 50

        let hairline = UIView(frame: CGRectMake(0, currentY - 1, CGRectGetWidth(view.bounds), 1))
        hairline.backgroundColor = ActionSheet.DefaultSeperatorItemColor

        self.otherViews.append(hairline)
        self.addSubview(hairline)
      }
    }

    self.frame = CGRectMake(0, CGRectGetHeight(view.bounds), CGRectGetWidth(view.bounds), currentY)
    view.addSubview(self)

    UIView.animateWithDuration(0.2) {
      self.backgroundView.alpha = 1
      self.frame = CGRectMake(0, CGRectGetHeight(view.bounds) - currentY, CGRectGetWidth(view.bounds), currentY)
    }
  }

  public func dismiss() {
    if let superview = self.superview {
      UIView.animateWithDuration(0.2, animations: {
        self.backgroundView.alpha = 0
        self.frame = CGRectMake(0,
          CGRectGetHeight(superview.bounds),
          CGRectGetWidth(superview.bounds),
          CGRectGetHeight(self.bounds)
        )
      }) { finished in
        self.backgroundView.removeFromSuperview()
        self.removeFromSuperview()
      }
    }
  }

  @objc private func onButtonItemTouched(button: UIButton) {
    let buttonIndex = self.itemViews.indexOf(button)!
    let item = self.items[buttonIndex]
    item.action?()
    self.dismiss()
  }

  @objc private func onBackgroundTouched(sender: AnyObject?) {
    if self.backgroundAction != nil {
      self.backgroundAction?()
      self.dismiss()
    }
  }

}
