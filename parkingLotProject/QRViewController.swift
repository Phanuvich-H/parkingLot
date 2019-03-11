//
//  QRViewController.swift
//  parkingLotProject
//
//  Created by TAIINEY on 13/11/2560 BE.
//  Copyright © 2560 Phanuvich Hirunsirisombut. All rights reserved.
//

import Foundation
import UIKit
import FirebaseAuth
import FirebaseDatabase

class QRViewController: UIViewController {
    @IBOutlet weak var imageViewQR: UIImageView!
    @IBOutlet weak var TextField: UITextField!
    var QRCode :String!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        guard  let myString = QRCode else {
            return
        }
        let data = myString.data(using: .ascii,allowLossyConversion: false)
        let filter = CIFilter(name: "CIQRCodeGenerator")
        filter?.setValue(data, forKey: "inputMessage")
        let img = UIImage(ciImage: (filter?.outputImage)!)
        imageViewQR.image = img
        // Do any additional setup after loading the view, typically from a nib.
    }
    
    
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
}

