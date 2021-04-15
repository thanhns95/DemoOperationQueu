//
//  PhotoPopupViewController.swift
//  DemoOperationQueu
//
//  Created by Nguyễn Thành on 15/04/2021.
//  Copyright © 2021 TrungNguyen. All rights reserved.
//

import UIKit

class PhotoPopupViewController: UIViewController {
    @IBOutlet weak var titleLb: UILabel!
    @IBOutlet weak var idLb: UILabel!
    
    var data = PhotosBO()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        titleLb.text = data.title
        idLb.text = "\(data.id ?? 0)"
        // Do any additional setup after loading the view.
    }

}
