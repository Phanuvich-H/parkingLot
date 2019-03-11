//
//  RefilMoneyViewController.swift
//  parkingLotProject
//
//  Created by Phanuvich Hirunsirisombut on 11/17/2560 BE.
//  Copyright © 2560 Phanuvich Hirunsirisombut. All rights reserved.
//

import UIKit
import FirebaseDatabase
import FirebaseAuth
class RefilMoneyViewController: UIViewController {
    let showView = ShowingViewController()
    @IBOutlet weak var amountTxtField: UITextField!
    
    var ref: DatabaseReference{
        return Database.database().reference().child("user")
    }
    
    var uidValue : String!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    @IBAction func cancelBtn(_ sender: Any) {
        //kill this page
        self.dismiss(animated: true, completion:nil)
//        self.showView.reloadPage()
    }
    @IBAction func submitBtn(_ sender: Any) {
        print(uidValue)
        var balance = 0
        let input = amountTxtField.text!
        if(Int(input) == nil){
            print("invalid input type")
            alertBox(topic: "Invalid Input Type!", body: "input must be numeric.")
        }
        else if(Int(input)! <= 0){
            print("input must greater than 0")
            alertBox(topic: "Invalid Input Value!", body: "input must greater than 0.")
        }
        else{
            self.ref.child(self.uidValue).observeSingleEvent(of: .value, with: {(snapshot) in
                let value = snapshot.value as? NSDictionary
                
                balance = (value!["balance"])! as! Int
                print(balance)
                
                balance = balance + Int(input)!
                
                self.ref.child(self.uidValue).child("balance").setValue(balance)
                
                self.alertBox(topic: "Secceed Topup!", body: "your balance is now "+String(balance)+"Bath.")
                self.amountTxtField.text = ""
            })
            
        }
    }
    
    func alertBox(topic:String, body:String){
        let myAlert = UIAlertController(title: topic, message:body, preferredStyle: UIAlertControllerStyle.alert);
        
        let okAction = UIAlertAction(title:"Ok", style:UIAlertActionStyle.default){ action in
        }
        
        myAlert.addAction(okAction);
        self.present(myAlert, animated:true, completion:nil);
    }
    
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
 

}
