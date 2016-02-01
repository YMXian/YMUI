//
//  ViewController.swift
//  YMUIExample
//
//  Created by Yanke Guo on 16/2/1.
//  Copyright © 2016年 JuXian(Beijing) Technology Co., Ltd. All rights reserved.
//

import UIKit
import YMUI

class ViewController: UIViewController {

  override func viewDidLoad() {
    super.viewDidLoad()
    // Do any additional setup after loading the view, typically from a nib.
  }

  override func didReceiveMemoryWarning() {
    super.didReceiveMemoryWarning()
    // Dispose of any resources that can be recreated.
  }

  @IBAction func onActionSheetButtonTouched() {
    let sheet = ActionSheet()
    sheet.addTextItem("This is a Awesome Title !")
    sheet.addSeperatorItem()
    sheet.addButtonItem("Action 1") { () -> Void in
      print("Shake it baby 1")
    }
    sheet.addButtonItem("Action 2") { () -> Void in
      print("Shake it baby 2")
    }
    sheet.addSeperatorItem()
    sheet.addButtonItem("Action 3") { () -> Void in
      print("Shake it baby 3")
    }

    sheet.show(self.view)
  }

}
