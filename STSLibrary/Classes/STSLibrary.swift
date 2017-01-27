//
//  ServerNetworkInterface.swift
//  ServerManagerDemo
//
//  Created by Chetu-macmini-27 on 22/12/16.
//  Copyright © 2016 Chetu-macmini-27. All rights reserved.
//

import Foundation
import UIKit


public class STSLibrary:NSObject{
    
    /*
     @author Chetu India
     @date 2 dec 2016
     @description some new keys are added to implement changes in web services.
     */
    let kApiKey = "j*gkNkUv55Csw"
    let kActioncodeForAddCash = "02"
    let kActioncodeForAddCashEGift = "06"
    let kActioncodeForDeduceCash = "01"
    let kActioncodeForRedeemLoyality = "03"
    let kActioncodeForAddLoyality = "04"
    let kActioncodeForBalanceEnquiry = "05"
    let kActioncodeForBalanceTransfer = "09"
    let kActioncodeForAddTrip = "10"
    let kActioncodeForVoidTransaction = "11"
    let kActioncodeForRedemptionSale = "19"
    let kReportCardholderDetailViewURL = "giftcard.card_report.php"
    let kReportLoyaltyDetailViewURL = "giftcard.loyalty_report.php"
    let kSetUpMerchantURL = "giftcard.setup_merchant.php"
    let kActivateEGiftURL = "giftcard.activate_e_gift.php"
    let kReportGiftDetailViewURL = "giftcard.detail_report.php"
    let kTransactiontypeNonLoyality = "N"
    let kTransactiontypeLoyality = "L"
    let kBusinessTypeRetail = "R"
    let kBusinessTypeRestaurent = "F"
    let kPosEntryModeSwipe = "S"
    let kPosEntryModeManual = "M"
    
    let kBaseURLForMerchantDetail = "https://www.smart-transactions.com/xmlapi/" //client URL
    
    let kBaseURL = "https://smarttransactions.net/gateway_no_lrc.php"
    
    var merchantID = ""
    var terminalID = ""
    var transactionID = ""
    var serverManager:ServerManager
    var delegate:UIViewController
    
    public enum BalanceOption {
        case BalanceOfGiftCard
        case LoyaltyBalanceEnquiry
    }
    
    public enum EntryMode {
        case Manual
        case Swipe
    }
    
    public init(merchantID:String,terminalID:String,transactionID:String,delegate:UIViewController) {
        serverManager = ServerManager(delegate: delegate as NSObject, successBlock: {_ in }, failureBlock: {_ in })
        self.merchantID = merchantID
        self.terminalID = terminalID
        self.transactionID = transactionID
        self.delegate = delegate
        super.init()
    }
    
    public func sendDataToActivateGiftCard(cardNumber:String,amount:String,entryMode:EntryMode,clerkID:String?,onSuccess:@escaping (_ successResponse:NSDictionary) -> Void,onFailure:@escaping (_ failureResponse:String)->Void){
        
        let dict = NSMutableDictionary()
        serverManager = ServerManager(delegate: delegate, successBlock: onSuccess, failureBlock: onFailure)
        dict["Merchant_Number"] = merchantID
        dict["Terminal_ID"] = terminalID
        dict["Transaction_Amount"] = amount
        dict["Card_Number"] = cardNumber
        dict["API_Key"] = kApiKey
        dict["Action_Code"] = kActioncodeForAddCash
        dict["Trans_Type"] = kTransactiontypeNonLoyality
        if(entryMode == EntryMode.Manual){
            dict["POS_Entry_Mode"] = kPosEntryModeManual
        }else{
            dict["POS_Entry_Mode"] = kPosEntryModeSwipe
        }
        
        if(clerkID != nil)
        {
            dict["Clerk_ID"] = clerkID
        }
        serverManager.makePostRequest(url: kBaseURL, postDataDic: dict, viewControllerContext: delegate )
    }
    
    public func sendDataToActivateEGiftCard(amount:String,clerkID:String?,entryMode:EntryMode,onSuccess: @escaping (_ successResponse:NSDictionary) -> Void,onFailure:@escaping (_ failureResponse:String)->Void){
        serverManager = ServerManager(delegate: delegate, successBlock: onSuccess, failureBlock: onFailure)
        let dict = NSMutableDictionary()
        dict["Merchant_Number"] = merchantID
        dict["Terminal_ID"] = terminalID
        dict["Transaction_Amount"] = amount
        dict["Card_Number"] = "NewAccountRQ"
        dict["API_Key"] = kApiKey
        dict["Action_Code"] = kActioncodeForAddCashEGift
        dict["Trans_Type"] = kTransactiontypeNonLoyality
        if(entryMode == EntryMode.Manual){
            dict["POS_Entry_Mode"] = kPosEntryModeManual
        }else{
            dict["POS_Entry_Mode"] = kPosEntryModeSwipe
        }
        
        if(clerkID != nil)
        {
            dict["Clerk_ID"] = clerkID
        }
        serverManager.makePostRequest(url: kBaseURL, postDataDic: dict, viewControllerContext: delegate )
    }
    
    public func sendDataToRedeemGiftCard(cardNumber:String,amount:String,entryMode:EntryMode,clerkID:String?,onSuccess: @escaping (_ successResponse:NSDictionary) -> Void,onFailure:@escaping (_ failureResponse:String)->Void){
        
        serverManager = ServerManager(delegate: delegate, successBlock: onSuccess, failureBlock: onFailure)
        let dict = NSMutableDictionary()
        dict["Merchant_Number"] = merchantID
        dict["Terminal_ID"] = terminalID
        dict["Transaction_Amount"] = amount
        dict["Card_Number"] = cardNumber
        dict["API_Key"] = kApiKey
        dict["Action_Code"] = kActioncodeForDeduceCash
        dict["Business_Type"] = kBusinessTypeRestaurent
        dict["Trans_Type"] = kTransactiontypeNonLoyality
        if(entryMode == EntryMode.Manual){
            dict["POS_Entry_Mode"] = kPosEntryModeManual
        }else{
            dict["POS_Entry_Mode"] = kPosEntryModeSwipe
        }
        
        if(clerkID != nil)
        {
            dict["Clerk_ID"] = clerkID
        }
        serverManager.makePostRequest(url: kBaseURL, postDataDic: dict, viewControllerContext: delegate )
    }
    
    public func sendDataToRedeemLoyalty(cardNumber:String,amount:String,entryMode:EntryMode,clerkID:String?,onSuccess:@escaping (_ successResponse:NSDictionary) -> Void,onFailure:@escaping (_ failureResponse:String)->Void){
        
        serverManager = ServerManager(delegate: delegate, successBlock: onSuccess, failureBlock: onFailure)
        
        let dict = NSMutableDictionary()
        dict["Merchant_Number"] = merchantID
        dict["Terminal_ID"] = terminalID
        dict["Transaction_Amount"] = amount
        dict["Card_Number"] = cardNumber
        dict["API_Key"] = kApiKey
        dict["Action_Code"] = kActioncodeForRedeemLoyality
        dict["Business_Type"] = kBusinessTypeRestaurent
        dict["Trans_Type"] = kTransactiontypeLoyality
        if(entryMode == EntryMode.Manual){
            dict["POS_Entry_Mode"] = kPosEntryModeManual
        }else{
            dict["POS_Entry_Mode"] = kPosEntryModeSwipe
        }
        dict["Transaction_ID"] = transactionID
        if(clerkID != nil)
        {
            dict["Clerk_ID"] = clerkID
        }
        serverManager.makePostRequest(url: kBaseURL, postDataDic: dict, viewControllerContext: delegate )
    }
    
    public func sendDataToLoyaltyAccural(cardNumber:String,amount:String,entryMode:EntryMode,clerkID:String?,onSuccess:@escaping (_ successResponse:NSDictionary) -> Void,onFailure:@escaping (_ failureResponse:String)->Void){
        serverManager = ServerManager(delegate: delegate, successBlock: onSuccess, failureBlock: onFailure)
        let dict = NSMutableDictionary()
        dict["Merchant_Number"] = merchantID
        dict["Terminal_ID"] = terminalID
        dict["Transaction_Amount"] = amount
        dict["Card_Number"] = cardNumber
        dict["API_Key"] = kApiKey
        dict["Action_Code"] = kActioncodeForAddLoyality
        dict["Business_Type"] = kBusinessTypeRestaurent
        dict["Trans_Type"] = kTransactiontypeLoyality
        if(entryMode == EntryMode.Manual){
            dict["POS_Entry_Mode"] = kPosEntryModeManual
        }else{
            dict["POS_Entry_Mode"] = kPosEntryModeSwipe
        }
        dict["Transaction_ID"] = transactionID
        dict["Ticket"] = ""
        if(clerkID != nil)
        {
            dict["Clerk_ID"] = clerkID
        }
        serverManager.makePostRequest(url: kBaseURL, postDataDic: dict, viewControllerContext: delegate )
    }
    
    public func sendDataToEnquireBalance(cardNumber:String,clerkID:String?,entryMode:EntryMode,option:BalanceOption,onSuccess:@escaping (_ successResponse:NSDictionary) -> Void,onFailure:@escaping (_ failureResponse:String)->Void){
        
        serverManager = ServerManager(delegate: delegate, successBlock: onSuccess, failureBlock: onFailure)
        let dict = NSMutableDictionary()
        dict["Merchant_Number"] = merchantID
        dict["Terminal_ID"] = terminalID
        
        
        dict["API_Key"] = kApiKey
        dict["Action_Code"] = kActioncodeForBalanceEnquiry
        
        if(option == BalanceOption.BalanceOfGiftCard){
            dict["Trans_Type"] = kTransactiontypeNonLoyality
        }else{
            dict["Trans_Type"] = kTransactiontypeLoyality
        }
        
        if(entryMode == EntryMode.Manual){
            dict["POS_Entry_Mode"] = kPosEntryModeManual
        }else{
            dict["POS_Entry_Mode"] = kPosEntryModeSwipe
        }
        
        if(clerkID != nil)
        {
            dict["Clerk_ID"] = clerkID
        }
        if((dict["POS_Entry_Mode"] as! String) == kPosEntryModeSwipe){
            dict["Track_Data2"] = cardNumber
        }else{
            dict["Card_Number"] = cardNumber
        }
        serverManager.makePostRequest(url: kBaseURL, postDataDic: dict, viewControllerContext: delegate )
    }
    
    public func sendDataToVoidGiftCardItem(item:String,clerkID:String?,entryMode:EntryMode,onSuccess:@escaping (_ successResponse:NSDictionary) -> Void,onFailure:@escaping (_ failureResponse:String)->Void){
        
        serverManager = ServerManager(delegate: delegate, successBlock: onSuccess, failureBlock: onFailure)
        let dict = NSMutableDictionary()
        dict["Merchant_Number"] = merchantID
        dict["Terminal_ID"] = terminalID
        dict["Auth_Reference"] = item
        dict["API_Key"] = kApiKey
        dict["Action_Code"] = kActioncodeForVoidTransaction
        dict["Trans_Type"] = kTransactiontypeNonLoyality
        if(entryMode == EntryMode.Manual){
            dict["POS_Entry_Mode"] = kPosEntryModeManual
        }else{
            dict["POS_Entry_Mode"] = kPosEntryModeSwipe
        }
        dict["Transaction_ID"] = transactionID
        if(clerkID != nil)
        {
            dict["Clerk_ID"] = clerkID
        }
        serverManager.makePostRequest(url: kBaseURL, postDataDic: dict, viewControllerContext: delegate )
        
    }
    
    public func getGiftCardDetailReport(forDate date:String,isForGift:Bool,onSuccess:@escaping (_ successResponse:String) -> Void,onFailure:@escaping (_ failureResponse:String)->Void){
        
        
        let dict = NSMutableDictionary()
        dict["Merchant_Number"] = merchantID
        dict["Terminal_ID"] = terminalID
        dict["Transaction_ID"] = transactionID
        dict["fullDate"] = date
        dict["get"] = "false"
        var url = ""
        if(isForGift){
            url =  kBaseURLForMerchantDetail.appending(kReportGiftDetailViewURL)
        }else{
            url =  kBaseURLForMerchantDetail.appending(kReportLoyaltyDetailViewURL)
        }
        serverManager = ServerManager(delegate: delegate, successBlockForReport: onSuccess, failureBlock: onFailure)
        serverManager.makePostRequestForReport(url: url, postDataDic: dict, viewControllerContext: delegate)
    }
    
    public func getCardDetailStatement(forCard cardNumber:String,onSuccess:@escaping (_ successResponse:String) -> Void,onFailure:@escaping (_ failureResponse:String)->Void){
        let dict = NSMutableDictionary()
        dict["Merchant_Number"] = merchantID
        dict["Terminal_ID"] = terminalID
        dict["Transaction_ID"] = transactionID
        dict["Card_Number"] = cardNumber
        dict["fullDate"] = ""
        dict["get"] = "false"
        let url = kBaseURLForMerchantDetail.appending(kReportCardholderDetailViewURL)
        serverManager = ServerManager(delegate: delegate, successBlockForReport: onSuccess, failureBlock: onFailure)
        serverManager.makePostRequestForReport(url: url, postDataDic: dict, viewControllerContext: delegate)
        
    }
    public func sendContactInfoToServer(merchantName:String,firstName:String,lastName:String,address1:String,address2:String,city:String,state:String,zip:String,phone:String,email:String,onSuccess:@escaping (_ successResponse:NSDictionary) -> Void,onFailure:@escaping (_ failureResponse:String)->Void){
        let dict = NSMutableDictionary()
        dict["merchant_number"] = "571141001001"
        dict["terminal_id"] = "001"
        dict["Transaction_ID"] = transactionID
        dict["merchant_name"] = merchantName
        dict["contact_fname"] = firstName
        dict["contact_lname"] = lastName
        dict["address1"] = address1
        dict["address2"] = address2
        dict["city"] = city
        dict["state"] = state
        dict["zip"] = zip
        dict["country"] = "USA"
        dict["phone"] = phone
        dict["email"] = email
        dict["get"] = "true"
        
        let url = kBaseURLForMerchantDetail.appending(kSetUpMerchantURL)
        serverManager = ServerManager(delegate: delegate, successBlock: onSuccess, failureBlock: onFailure)
        serverManager.makePostRequest(url: url, postDataDic: dict, viewControllerContext: delegate)
    }
}
