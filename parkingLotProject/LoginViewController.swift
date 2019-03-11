//
//  LoginViewController.swift
//  parkingLotProject
//
//  Created by Phanuvich Hirunsirisombut on 10/27/2560 BE.
//  Copyright © 2560 Phanuvich Hirunsirisombut. All rights reserved.
//

import UIKit
import SwiftyJSON
import Kingfisher
import Foundation
import FirebaseDatabase
import FirebaseAuth

class LoginViewController: UIViewController{
 
    @IBOutlet weak var idTxtField: UITextField!
    @IBOutlet weak var passwordTxtField: UITextField!
    
    var mRootRef:DatabaseReference!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        mRootRef = Database.database().reference()
        
        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func loginButton(_ sender: Any) {
        
        loginFun(email: idTxtField.text!, password: passwordTxtField.text!)
        
        
    }
    
    @IBAction func regisButton(_ sender: Any) {
//        idTxtField.text = "regis"
    }
    
    func loginFun(email: String, password: String) {
        
        Auth.auth().signIn(withEmail: email, password: password, completion:{ (user, error) in
            
            if error == nil {
                
//                print(Auth.auth().currentUser?.uid)
                if Auth.auth().currentUser != nil {
                    
                    
//                    let storyboard: UIStoryboard = UIStoryboard(name: "Main", bundle: nil)
//
//                    let vc: UIViewController = storyboard.instantiateViewController(withIdentifier: "tabView")
//
//                    self.present(vc, animated: true, completion: nil)
                    print("login successed")
                    
//                    let uidValue = Auth.auth().currentUser?.uid
//                    print(uidValue as Any)
//                    self.ref.child("user").child(uidValue!).observeSingleEvent(of: .value, with: { (snapshot) in
//                        // Get user value
//                        let value = snapshot.value as? NSDictionary
//                        let nameval = value?["carid"]
//                        //print (value as Any)
//                        print (nameval as Any)
//
//                        self.delegate?.finishPassing(string: uidValue!)
//                        self.performSegue(withIdentifier: "loginToShowingTable", sender: nil)
//
//                    }) { (error) in
//                        print(error.localizedDescription)
//                    }
                self.performSegue(withIdentifier: "loginToShowingTable", sender: nil)
                    
                    
                } else {
                    print("login fail")
                }
                
                
            }
                
            else {
                //throw every error to here
                let myAlert = UIAlertController(title:"Error!", message:"\(String(describing: error?.localizedDescription))", preferredStyle: UIAlertControllerStyle.alert);
                
                let okAction = UIAlertAction(title:"Ok", style:UIAlertActionStyle.default){ action in
                }
                
                myAlert.addAction(okAction);
                self.present(myAlert, animated:true, completion:nil);
                
            }
            
            
        })
        
    }
    @IBAction func unwindToLogin(segue:UIStoryboardSegue){
        
    }
//    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
//        if let destination = segue.destination as? LoginViewController {
//            destination.delegate = self
//        }
//    }
    
    
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
       
        guard let identifier = segue.identifier else {
            return
        }
        if identifier == "loginToShowingTable"{
            let vc = segue.destination as! ShowingViewController
            vc.uid = Auth.auth().currentUser?.uid
           // vc.userLabel.text = vc.uid as! String
        }
        else if identifier == "RegisterViewController"{
            let vc = segue.destination as! RegisterViewController
        }
        
    }


}
