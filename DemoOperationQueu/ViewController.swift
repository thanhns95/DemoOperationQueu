//
//  ViewController.swift
//  DemoOperationQueu
//
//  Created by Nguyễn Thành on 14/03/2021.
//  Copyright © 2021 TrungNguyen. All rights reserved.
//

import UIKit

class ViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    var listAlbum = [AlbumBO]()
    var listPhotos = [PhotosBO]()
    let baseCallApi = CallBaseApi.sharedInstance
    let operationQueu = OperationQueue()
    @IBOutlet weak var albumTbv: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        albumTbv.register(UINib(nibName: "PhotoTableViewCell", bundle: nil), forCellReuseIdentifier: "PhotoTableViewCell")
        getDataApi1()
        // Do any additional setup after loading the view.
        
    }

    func getDataApi1() {
        let blockOperationAlbum = AsyncOperation()
        let blockOperationPhoto = AsyncOperation()
        let blockOperationReload = AsyncOperation()
        blockOperationAlbum.addExecutionBlock {
            self.baseCallApi.getAlbum { (response: AlbumObject) in
                self.listAlbum = response.albums ?? [AlbumBO]()
                blockOperationAlbum.finish()
            }
        }
        
        blockOperationPhoto.addExecutionBlock {
            self.baseCallApi.getPhotos { (response: PhotosObject) in
                self.listPhotos = response.photos ?? [PhotosBO]()
                blockOperationPhoto.finish()
            }
        }
        
        blockOperationReload.addExecutionBlock {
            DispatchQueue.main.async {
                self.albumTbv.reloadData()
            }
        }
        
        blockOperationReload.addDependency(blockOperationAlbum)
        blockOperationReload.addDependency(blockOperationPhoto)
        operationQueu.addOperations([blockOperationAlbum,blockOperationPhoto,blockOperationReload], waitUntilFinished: false)
        
    }
    
    func getDataApi2() {
        let blockOperationAlbum = AsyncOperation()
        let blockOperationPhoto = AsyncOperation()
        let blockOperationReload = AsyncOperation()
        blockOperationAlbum.addExecutionBlock {
            self.baseCallApi.getAlbum { (response: AlbumObject) in
                self.listAlbum = response.albums ?? [AlbumBO]()
                blockOperationAlbum.finish()
            }
        }
        
        blockOperationPhoto.addExecutionBlock {
            self.baseCallApi.getPhotos { (response: PhotosObject) in
                self.listPhotos = response.photos ?? [PhotosBO]()
                blockOperationPhoto.finish()
            }
        }
        
        blockOperationReload.addExecutionBlock {
            DispatchQueue.main.async {
                self.albumTbv.reloadData()
            }
        }
        
        blockOperationPhoto.addDependency(blockOperationAlbum)
        blockOperationReload.addDependency(blockOperationPhoto)
        operationQueu.addOperations([blockOperationAlbum,blockOperationPhoto,blockOperationReload], waitUntilFinished: false)
        
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.listAlbum.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "PhotoTableViewCell", for: indexPath) as! PhotoTableViewCell
        let data = self.listAlbum[indexPath.row]
        data.total = "\(listPhotos.filter({$0.albumId == data.id}).count)"
        cell.bindData(data)
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
//        let detailVc = PhotoDetailViewController()
//        let album = self.listAlbum[indexPath.row]
//        detailVc.listPhotos = listPhotos.filter({ $0.albumId == album.id})
//        detailVc.modalPresentationStyle = .overFullScreen
//        present(detailVc, animated: true, completion: nil)
        let clonedata = self.listAlbum[indexPath.row].clone()
        clonedata.id = 5
        clonedata.title = "thay doi"
        clonedata.printData()
        self.listAlbum[indexPath.row].printData()
        
        let data = PhotoBuilder().setId(3).setTitle("duoc roi").build()
        
        let detailVc = PhotoPopupViewController()
        detailVc.data = data
        detailVc.modalPresentationStyle = .overFullScreen
        present(detailVc, animated: true, completion: nil)
        
        
    }
    
    

}

