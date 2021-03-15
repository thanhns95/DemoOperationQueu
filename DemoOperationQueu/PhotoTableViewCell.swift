//
//  PhotoTableViewCell.swift
//  DemoOperationQueu
//
//  Created by Nguyễn Thành on 14/03/2021.
//  Copyright © 2021 TrungNguyen. All rights reserved.
//

import UIKit

class PhotoTableViewCell: UITableViewCell {
    @IBOutlet weak var titleLb: UILabel!
    @IBOutlet weak var totalLb: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    
    func bindData(_ data: AlbumBO) {
        titleLb.text = data.title
        totalLb.text = data.total
    }
    
    func bindDataPhoto(_ data: PhotosBO) {
        titleLb.text = data.title
    }
}
