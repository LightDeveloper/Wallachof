//
//  AddProductViewController.swift
//  Wallachof
//
//  Created by Dev2 on 21/05/2019.
//  Copyright © 2019 Dev2. All rights reserved.
//

import UIKit

class AddProductViewController: UIViewController {

    @IBOutlet weak var imgProduct: UIImageView!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    
    @IBAction func tapDetected(_ sender: UITapGestureRecognizer) {
        debugPrint("Han hecho tap \(sender.numberOfTouches)")
        showPictureSourceAlert()
    }
    
    func showPictureSourceAlert() {
        let alert = UIAlertController(title: nil, message: nil, preferredStyle: .actionSheet)
        let cameraAction = UIAlertAction(title: "Abrir cámara", style: .default) { (alert) in
            // TODO: Abrir la cámara
            debugPrint("Abriría la cámara")
        }
        alert.addAction(cameraAction)
        let albumAction = UIAlertAction(title: "Abrir álbum", style: .default) { (alert) in
            // TODO: Abrir la galería
            debugPrint("Abriría la galería")
        }
        alert.addAction(albumAction)
        let cancelAction = UIAlertAction(title: "Cancelar", style: .cancel)
        alert.addAction(cancelAction)
        
        present(alert, animated: true)
    }
}
