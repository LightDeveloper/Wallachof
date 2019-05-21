//
//  AddProductViewController.swift
//  Wallachof
//
//  Created by Dev2 on 21/05/2019.
//  Copyright © 2019 Dev2. All rights reserved.
//

import UIKit

class AddProductViewController: UIViewController {

    enum ImageSource {
        case photoLibrary
        case camera
    }
    
    var imagePicker: UIImagePickerController!
    
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
        
        if UIImagePickerController.isSourceTypeAvailable(.camera) {
            
            let alert = UIAlertController(title: nil, message: nil, preferredStyle: .actionSheet)
            let cameraAction = UIAlertAction(title: "Abrir cámara", style: .default) { (alert) in
                self.selectImageFrom(.camera)
            }
            alert.addAction(cameraAction)
            let albumAction = UIAlertAction(title: "Abrir álbum", style: .default) { (alert) in
                self.selectImageFrom(.photoLibrary)
            }
            alert.addAction(albumAction)
            let cancelAction = UIAlertAction(title: "Cancelar", style: .cancel)
            alert.addAction(cancelAction)
            
            present(alert, animated: true)
        } else {
            selectImageFrom(.photoLibrary)
        }
    }
    
    func selectImageFrom(_ source: ImageSource) {
        imagePicker = UIImagePickerController()
        imagePicker.delegate = self
        
        switch source {
        case .camera:
            imagePicker.sourceType = .camera
        case .photoLibrary:
            imagePicker.sourceType = .photoLibrary
        }
        
        present(imagePicker, animated: true)
    }
}

extension AddProductViewController: UINavigationControllerDelegate {
    
}

extension AddProductViewController: UIImagePickerControllerDelegate {
    
    func imagePickerController(_ picker: UIImagePickerController,
                               didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        
        picker.dismiss(animated: true)
        guard let selectedImage = info[.originalImage] as? UIImage else {
            debugPrint("ERROR No pude obtener la imagen")
            return
        }
        imgProduct.image = selectedImage
        
        let context = CoreDataManager.shared.persistentContainer.viewContext
        let flores = Product(context: context)
        flores.name = "Flower power"
        flores.desc = "Mogollón de alergia para tu nariz"
        flores.price = 500.0
        
//        if let dataPng = selectedImage.pngData() {
//            // dataPng de tipo Data
//        }
        
        let thumbImage = selectedImage.resizeImage(targetSize: CGSize(width: 100, height: 100))
        
        if let dataJpeg = thumbImage.jpegData(compressionQuality: 0.8) {
            // dataJpeg de tipo Data
            flores.thumb = NSData(data: dataJpeg)
        }
        
        CoreDataManager.shared.saveContext()
    }
    
    
}
