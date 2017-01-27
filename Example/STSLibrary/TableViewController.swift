//
//  ViewController.swift
//  ServerNetworkInterface
//
//  Created by ankitkumar2 on 01/24/2017.
//  Copyright (c) 2017 ankitkumar2. All rights reserved.
//

import UIKit
import Foundation
import STSLibrary

class TableViewController: UITableViewController {

  
  var lServerManagerInterface:ServerNetworkInterface? = nil
  override func viewDidLoad() {
    super.viewDidLoad()
    self.title = "Demo"
    //"747756"
    lServerManagerInterface = ServerNetworkInterface(merchantID: "111111111111", terminalID: "245", transactionID: "747756", delegate: self as UIViewController)
  }
  
  override func didReceiveMemoryWarning() {
    super.didReceiveMemoryWarning()
    // Dispose of any resources that can be recreated.
  }
  func presentAlert(withMessage message:String)  {
    let alertController = UIAlertController(title: "Response", message: message, preferredStyle: UIAlertControllerStyle.alert)
    alertController.addAction(UIAlertAction(title: "OK", style: UIAlertActionStyle.cancel, handler: { (action) in
      alertController.dismiss(animated: true, completion: {
        
      })
    }))
    self.present(alertController, animated: true, completion: {
      
    })
  }
  @IBAction func activateGiftCard(_ sender: AnyObject) {
    lServerManagerInterface?.sendDataToActivateGiftCard(cardNumber: "711111001198730", amount: "0.2", entryMode: ServerNetworkInterface.EntryMode.Manual, clerkID: nil, onSuccess: { (serverResponse) in
      self.presentAlert(withMessage: serverResponse.description)
      
    }) { (serverResponse) in
      self.presentAlert(withMessage: serverResponse)
    }
    
  }
  
  
  @IBAction func activateEGiftCard(_ sender: AnyObject) {
    
    lServerManagerInterface?.sendDataToActivateEGiftCard(amount: "711111001198730", clerkID: nil,entryMode: ServerNetworkInterface.EntryMode.Manual, onSuccess: { (serverResponse) in
      self.presentAlert(withMessage: serverResponse.description)
      
    }) { (serverResponse) in
      self.presentAlert(withMessage: serverResponse)
    }
  }
  
  @IBAction func redeemGiftcard(_ sender: AnyObject) {
    
    lServerManagerInterface?.sendDataToRedeemGiftCard(cardNumber: "711111001198730", amount: "0.2",entryMode: ServerNetworkInterface.EntryMode.Manual, clerkID: nil, onSuccess: { (serverResponse) in
      self.presentAlert(withMessage: serverResponse.description)
    }) { (serverResponse) in
      self.presentAlert(withMessage: serverResponse)
    }
  }
  
  @IBAction func voidGiftcard(_ sender: AnyObject) {
    
    lServerManagerInterface?.sendDataToVoidGiftCardItem(item: "0001", clerkID: nil,entryMode: ServerNetworkInterface.EntryMode.Manual, onSuccess: { (serverResponse) in
      self.presentAlert(withMessage: serverResponse.description)
    }) { (serverResponse) in
      self.presentAlert(withMessage: serverResponse)
    }
  }
  
  @IBAction func giftBalanceEnquiry(_ sender: AnyObject) {
    lServerManagerInterface?.sendDataToEnquireBalance(cardNumber: "711111001198730", clerkID: nil,entryMode: ServerNetworkInterface.EntryMode.Manual, option: ServerNetworkInterface.BalanceOption.BalanceOfGiftCard, onSuccess: { (serverResponse) in
      self.presentAlert(withMessage: serverResponse.description)
    }) { (serverResponse) in
      self.presentAlert(withMessage: serverResponse)
    }
  }
  
  @IBAction func loyaltyAccural(_ sender: AnyObject) {
    lServerManagerInterface?.sendDataToLoyaltyAccural(cardNumber: "711111001198730", amount: "0.2",entryMode: ServerNetworkInterface.EntryMode.Manual, clerkID: nil, onSuccess: { (serverResponse) in
      self.presentAlert(withMessage: serverResponse.description)
    }) { (serverResponse) in
      self.presentAlert(withMessage: serverResponse)
    }
  }
  
  @IBAction func loyaltyRedemption(_ sender: AnyObject) {
    lServerManagerInterface?.sendDataToRedeemLoyalty(cardNumber: "711111001198730", amount: "0.2",entryMode: ServerNetworkInterface.EntryMode.Manual, clerkID: nil, onSuccess: { (serverResponse) in
      self.presentAlert(withMessage: serverResponse.description)
    }) { (serverResponse) in
      self.presentAlert(withMessage: serverResponse)
    }
  }
  
  @IBAction func loyaltyBalanceEnquiry(_ sender: AnyObject) {
    lServerManagerInterface?.sendDataToEnquireBalance(cardNumber: "711111001198730", clerkID: nil,entryMode: ServerNetworkInterface.EntryMode.Manual, option: ServerNetworkInterface.BalanceOption.LoyaltyBalanceEnquiry, onSuccess: { (serverResponse) in
      self.presentAlert(withMessage: serverResponse.description)
    }) { (serverResponse) in
      self.presentAlert(withMessage: serverResponse)
    }
  }
}
