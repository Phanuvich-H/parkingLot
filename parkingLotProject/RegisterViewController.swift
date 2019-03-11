//
//  RegisterViewController.swift
//  parkingLotProject
//
//  Created by Phanuvich Hirunsirisombut on 11/17/2560 BE.
//  Copyright © 2560 Phanuvich Hirunsirisombut. All rights reserved.
//

import UIKit
import FirebaseDatabase
import FirebaseAuth

class RegisterViewController: UIViewController {
    
    @IBOutlet weak var emailTxtField: UITextField!
    @IBOutlet weak var passTxtField: UITextField!
    @IBOutlet weak var confirmTxtField: UITextField!
    @IBOutlet weak var carIDTxtField: UITextField!
    
    var mRootRef:DatabaseReference {
        return Database.database().reference()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func displayMyAlertMessage(_ userMessage:String)
    {

        let myAlert = UIAlertController(title:"Alert", message:userMessage, preferredStyle: UIAlertControllerStyle.alert);

        let okAction = UIAlertAction(title:"Ok", style:UIAlertActionStyle.default, handler:nil);

        myAlert.addAction(okAction);

        self.present(myAlert, animated:true, completion:nil);

    }
    
    @IBAction func submitBtn(_ sender: Any) {
        let userEmail = emailTxtField.text;
        let userPassword = passTxtField.text;
        let userRepeatPassword = confirmTxtField.text;
        let carID: String = carIDTxtField.text!
        
        // Check for empty fields
        if((userEmail?.isEmpty)! || (userPassword?.isEmpty)! || (userRepeatPassword?.isEmpty)!)
        {
            
            // Display alert message
            
            displayMyAlertMessage("All fields are required");
        }
        //check password length
        if((userPassword?.count)! < 6){
            displayMyAlertMessage("Password should has at least 6 character")
        }
        //Check if passwords match
        if(userPassword != userRepeatPassword)
        {
            // Display an alert message
            displayMyAlertMessage("Passwords do not match")
            
        }
        //check if carID has specail char
        if carID.range(of: "^(?=.{6,20}$)(?![_.])(?!.*[_.]{2})[a-zA-Z0-9._]+(?<![_.])$", options: .regularExpression) == nil {
            print("carID can't use bacause have special character")
            displayMyAlertMessage("Car ID can't use bacause have special character")
        }
        
        else{
            Auth.auth().signIn(withEmail: userEmail!, password: userPassword!, completion:{ (user, error) in
                
                if error == nil{
                    //user is exist

                    let myAlert = UIAlertController(title:"Alert", message:"E-mail is Exist", preferredStyle: UIAlertControllerStyle.alert);
                    
                    let okAction = UIAlertAction(title:"Ok", style:UIAlertActionStyle.default){ action in
                        self.dismiss(animated: true, completion:nil);
                    }
                    
                    myAlert.addAction(okAction);
                    self.present(myAlert, animated:true, completion:nil);
                }
                else{
                            Auth.auth().createUser(withEmail: userEmail!, password: userPassword!, completion: { (user, error) in
                                if error == nil {

                                    if Auth.auth().currentUser != nil {
                                        let uidval: String = (Auth.auth().currentUser?.uid)!

                                        print(uidval as Any)
                                    self.mRootRef.child("user").child(uidval).setValue(["carid":carID,"balance":0])
                                       

                                        let myAlert = UIAlertController(title:"Alert", message:"Registration is successful. Thank you!", preferredStyle: UIAlertControllerStyle.alert);

                                        let okAction = UIAlertAction(title:"Ok", style:UIAlertActionStyle.default){ action in
                                            self.dismiss(animated: true, completion:nil);
                                        }

                                        myAlert.addAction(okAction);
                                        self.present(myAlert, animated:true, completion:nil);


                                        print("User registered in Firebase")
                                    }else{
                                        //alert if can't create new user
                                        let myAlert = UIAlertController(title:"Alert", message:error as? String, preferredStyle: UIAlertControllerStyle.alert);
                                        
                                        let okAction = UIAlertAction(title:"Ok", style:UIAlertActionStyle.default){ action in
                                            self.dismiss(animated: true, completion:nil);
                                        }
                                        
                                        myAlert.addAction(okAction);
                                        self.present(myAlert, animated:true, completion:nil);
                                    }
                                }
                            })
                    }
            })
        }
    }
    @IBAction func cancelBtn(_ sender: Any) {
        //back to login page
        self.dismiss(animated: true, completion:nil)
    }
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
