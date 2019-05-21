//
//  ViewController.swift
//  Wallachof
//
//  Created by Dev2 on 20/05/2019.
//  Copyright © 2019 Dev2. All rights reserved.
//

import UIKit

class CoreDataTesterViewController: UIViewController {
    
    @IBOutlet weak var imgLoad: UIImageView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
    }
    
    
    @IBAction func btnTestPressed(_ sender: Any) {
        
        let persistentContainer = CoreDataManager.shared.persistentContainer
        let context = persistentContainer.viewContext
        
        let dinoDetector = Product(context: context)
        dinoDetector.name = "Dino Detector Ultimate 🦖"
        dinoDetector.desc = "Detector de dinosaurios de última generación"
        dinoDetector.price = 2000.0
        
        CoreDataManager.shared.saveContext()
    }
    
    @IBAction func btnFetchRequestPressed(_ sender: Any) {
        for producto in Product.all {
            debugPrint("\(String(describing: producto.name)) a  \(producto.price) desc: \(String(describing: producto.desc))")
        }
    }
    
    @IBAction func btnLoadImagePressed(_ sender: Any) {
        for producto in Product.all where producto.thumb != nil {
            if let dataJpeg = producto.thumb {
                imgLoad.image = UIImage(data: Data(referencing: dataJpeg))
            }
        }
    }
    
}

