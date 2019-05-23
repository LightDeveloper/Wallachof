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
    
    let categorias0 = ["móvil", "ordenador", "consola"]
    let categorias1 = ["ropa", "zapatos", "torrijas", "cinturones"]

    var imagePicker: UIImagePickerController!
    
    @IBOutlet weak var scrollForm: UIScrollView!
    @IBOutlet weak var imgProduct: UIImageView!
    
    @IBOutlet weak var pickerEndAdd: UIDatePicker!
    @IBOutlet weak var pickerCategory: UIPickerView!
    @IBOutlet weak var txtfName: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillShow), name: UIResponder.keyboardWillShowNotification, object: nil)

        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillHide), name: UIResponder.keyboardWillHideNotification, object: nil)
        
        txtfName.delegate = self
        pickerCategory.delegate = self
        pickerCategory.dataSource = self
    }
    
    @objc func keyboardWillShow(notification: Notification) {
        adjustScrollForKeyboardShow(true, notification: notification)
        debugPrint("El teclado va a salir")
    }

    @objc func keyboardWillHide(notification: Notification) {
        adjustScrollForKeyboardShow(false, notification: notification)
        debugPrint("El teclado va a ocultar")
    }
    
    func adjustScrollForKeyboardShow(_ show: Bool, notification: Notification) {
        guard let userInfo = notification.userInfo,
            let frameValue = userInfo[UIResponder.keyboardFrameEndUserInfoKey] as? NSValue
            else {
                return
        }
        
        let keyboardFrame = frameValue.cgRectValue
        var adjustInset: CGFloat = 0.0
        if show {
            adjustInset = keyboardFrame.height
        } else {
            adjustInset = -keyboardFrame.height
        }
        scrollForm.contentInset.bottom = adjustInset
        scrollForm.scrollIndicatorInsets.bottom = adjustInset
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
    
    @IBAction func pickerEndAddChanged(_ sender: UIDatePicker) {
        
    }
}


extension AddProductViewController: UITextFieldDelegate {
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
//        textField.endEditing(true)
        
        return true
    }
    
}

extension AddProductViewController: UIPickerViewDataSource {
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 2
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        if component == 0 {
            return categorias0.count
        } else  {
            return categorias1.count
        }
    }
}

extension AddProductViewController: UIPickerViewDelegate {
    
    func pickerView(_ pickerView: UIPickerView,
                    titleForRow row: Int,
                    forComponent component: Int) -> String? {
        switch component {
        case 0:
            return categorias0[row]
        case 1:
            return categorias1[row]
        default:
            debugPrint("Error no debería llegar")
            return "no existe"
        }
    }
    
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        
        
        let fila0 = pickerView.selectedRow(inComponent: 0)
        let fila1 = pickerView.selectedRow(inComponent: 1)
        debugPrint("Todos \(categorias0[fila0]) y \(categorias1[fila1])")
        
        switch component {
        case 0:
            debugPrint("Un solo \(categorias0[row])")
        case 1:
            debugPrint("Un solo \(categorias1[row])")
        default:
            debugPrint("Error no debería llegar")
         }
    }
    
}

extension AddProductViewController: UINavigationControllerDelegate {
    // Necesario para el image picker, pero en este caso no se usa
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
