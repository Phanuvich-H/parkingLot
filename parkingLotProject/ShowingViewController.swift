//
//  ShowingViewController.swift
//  parkingLotProject
//
//  Created by Phanuvich Hirunsirisombut on 10/28/2560 BE.
//  Copyright © 2560 Phanuvich Hirunsirisombut. All rights reserved.
//

import UIKit
import FirebaseDatabase
import FirebaseAuth
class ShowingViewController: UIViewController {
    @IBOutlet weak var balanceLabel: UILabel!
    @IBOutlet weak var showTable: UITableView!
    var timeEntry = [TimeTableEntry]()
    
    @IBOutlet weak var topView: UIView!
    var uid : String!
    var QRCode : String!
    @IBOutlet weak var userLabel: UILabel!
    

    var refer: DatabaseReference{
        return Database.database().reference().child("user")
    }
    var ref: DatabaseReference{
        return Database.database().reference().child("parkinglot")
    }
    var createRef : DatabaseReference{
        return Database.database().reference().child("qr_ref_id")
    }
    var bookingRef : DatabaseReference{
        return Database.database().reference().child("booking_history")
    }
    var balance : Int!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.showTable.reloadData()
        refer.child(uid).observeSingleEvent(of: .value, with: {(snapshot) in
            let value = snapshot.value as? NSDictionary
            self.balance = (value!["balance"]) as! Int
            self.userLabel.text = value?["carid"] as! String
            self.balanceLabel.text = "\(self.balance) Baht."
            
        })
        
        
        ref.observe(DataEventType.value, with: { (snapshot) in
            if snapshot.childrenCount > 0 {
            for time in snapshot.children.allObjects as!
                    [DataSnapshot] {
                        if time.value != nil{
                            let timeEntryObject = time.value as? NSDictionary
                            let ids = timeEntryObject!["startTime"] as? String
                            let time = timeEntryObject!["endTime"] as? String
                            let timetable = TimeTableEntry(ids: ids as? String , endTime: time as? String)
                            self.timeEntry.append(timetable)
                        }
                }
                self.showTable.reloadData()
            }
        })
        
    }
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

  

    // MARK: - Navigation

    // In a storyboard-based application, you will
    //often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        guard let identifier = segue.identifier else {
            return
        }
        if identifier == "clickCell"{
            if self.balance >= 10{
            self.balance = self.balance-10
            self.refer.child(self.uid).child("balance").setValue(self.balance)
            let vc = segue.destination as! QRViewController
            
            let date = NSDate()
            let dateFormat = DateFormatter()
            dateFormat.dateStyle = .medium
            let time = dateFormat.string(from: date as Date)
            if let data = self.showTable.indexPathForSelectedRow{
                let cell = self.showTable.cellForRow(at: data) as! showingTableViewCell
                let qrCode = self.createRef.childByAutoId()
                qrCode.setValue(["status":0])
                let key = qrCode.key
                self.self.bookingRef.childByAutoId().setValue(["start_time":cell.idLabel.text!,"end_time":cell.timeLabel.text!,"qr_ref_id":key,"user_id":self.uid,"date" : time])
                vc.QRCode = qrCode.key
            
            }
        }
            else{
                let myAlert = UIAlertController(title:"Sorry!", message:"not enough money.", preferredStyle: UIAlertControllerStyle.alert);
                
                let okAction = UIAlertAction(title:"Ok", style:UIAlertActionStyle.default){ action in
                    self.showTable.reloadData()
                }
                
                myAlert.addAction(okAction);
                self.present(myAlert, animated:true, completion:nil);
                print("low money")
            }
            
        }
        else if identifier == "refilmoney"{
            let vc = segue.destination as! RefilMoneyViewController
            vc.uidValue = self.uid
        }
        else if identifier == "register"{
            let vc = segue.destination as! RegisterViewController
        }
        
        else if identifier == "clickCell"{
            
        }
        
    }
 

    @IBAction func unwind_getback(segue:UIStoryboardSegue){
        self.showTable.reloadData()
    }
    
    override func viewWillAppear(_ animated: Bool){
        refer.child(uid).observeSingleEvent(of: .value, with: {(snapshot) in
            let value = snapshot.value as? NSDictionary
            let balance = (value!["balance"])!
            self.balance = balance as! Int
            self.balanceLabel.text = "\(balance) Baht."
            
        })
    }
    
   
}
extension ShowingViewController: UITableViewDelegate,UITableViewDataSource{
    
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = showTable.dequeueReusableCell(withIdentifier: "cellTable", for: indexPath) as! showingTableViewCell
        
        let timing : TimeTableEntry
        timing = timeEntry[indexPath.row]
        if timing.id != nil && timing.endTime != nil{
            cell.idLabel.text = timing.id
            cell.timeLabel.text = timing.endTime
        }
        
        return cell
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
    
        return timeEntry.count
    }
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
    }
}

