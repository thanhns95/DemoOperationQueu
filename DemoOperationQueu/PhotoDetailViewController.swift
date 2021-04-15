//
//  PhotoDetailViewController.swift
//  DemoOperationQueu
//
//  Created by Nguyễn Thành on 14/03/2021.
//  Copyright © 2021 TrungNguyen. All rights reserved.
//

import UIKit

class PhotoDetailViewController: UIViewController, UITableViewDataSource, UITableViewDelegate {
    @IBOutlet weak var photoTbv: UITableView!
    @IBOutlet weak var uploadBtn: UIButton!
    
    var listPhotos = [PhotosBO]()
    let operationQueue = OperationQueue()
    let baseCallApi = CallBaseApi.sharedInstance
    
    override func viewDidLoad() {
        super.viewDidLoad()
        photoTbv.register(UINib(nibName: "PhotoTableViewCell", bundle: nil), forCellReuseIdentifier: "PhotoTableViewCell")
        operationQueue.maxConcurrentOperationCount = 2
        // Do any additional setup after loading the view.
    }
    
    @IBAction func backBtnAction(_ sender: Any) {
        dismiss(animated: true, completion: nil)
    }
    
    func downloadImage() {
        let finishDownLoadOperation = BlockOperation {
            DispatchQueue.main.async {
                self.uploadBtn.isSelected = false
                self.uploadBtn.titleLabel?.text = "Download"
            }
        }
        for photo in listPhotos {
            let asyncOperation = AsyncOperation()
            let downloadTask = baseCallApi.download(from: photo.url ?? "") { _ in
                asyncOperation.finish()
            }
            asyncOperation.task = downloadTask
            asyncOperation.addExecutionBlock {
                downloadTask?.resume()
            }
            finishDownLoadOperation.addDependency(asyncOperation)
            operationQueue.addOperation(asyncOperation)
        }
        operationQueue.addOperation(finishDownLoadOperation)
    }
    
    @IBAction func downloadBtnAction(_ sender: Any) {
        uploadBtn.isSelected = !uploadBtn.isSelected
        if uploadBtn.isSelected {
            uploadBtn.titleLabel?.text = "Cancel"
            downloadImage()
        } else {
            uploadBtn.titleLabel?.text = "Download"
            operationQueue.cancelAllOperations()
            print("Cancel")
        }
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.listPhotos.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "PhotoTableViewCell", for: indexPath) as! PhotoTableViewCell
        let data = self.listPhotos[indexPath.row]
        cell.bindDataPhoto(data)
        return cell
    }
    
}
