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
    
    let kBaseURL = "https://smarttransactions.net/gateway_app.php"    //"https://smarttransactions.net/gateway_no_lrc.php" -> old URL
    let emptyString = ""
    var merchantID = ""
    var terminalID = ""
    var transactionID = ""
    var serverManager:ServerManager
    var delegate:UIViewController
    
    // Dictionary Key Identifier
    let kTrackData2 = "Track_Data2"
    let kMerchant_Number = "Merchant_Number"
    let kTerminal_ID = "Terminal_ID"
    let kTransaction_ID = "Transaction_ID"
    let kMerchant_name = "merchant_name"
    let kContact_fname = "contact_fname"
    let kContact_lname = "contact_lname"
    let kAddress1 = "address1"
    let kAddress2 = "address2"
    let kCity = "city"
    let kState = "state"
    let kZip = "zip"
    let kCountry = "country"
    let kPhone = "phone"
    let kEmail = "email"
    let kGet = "get"
    let kActionCode = "Action_Code"
    let kCardNumber = "Card_Number"
    let kTrue = "true"
    let kFalse = "false"
    let defaultActionCodeForReport = "23"
    let defaultActionCodeForMerchant = "30"
    let defaultTerminalID = "046"
    let defaultMerchantID = "400000000001"
    let defaultTerminalIDForNewMerchant = "001"
    let defaultCountry = "USA"
    let kFullDate = "fullDate"
    let kAuthReference = "Auth_Reference"
    let kAPIKey = "API_Key"
    let kTransationType = "Trans_Type"
    let kPOSEntryMode = "POS_Entry_Mode"
    let kClerkID = "Clerk_ID"
    let kTicket = "Ticket"
    let kBussinessType = "Business_Type"
    let kTransactionAmount = "Transaction_Amount"
    let kNewAccountRequired = "NewAccountRQ"
    

    let kGift = "Gift"
    let kHouseAccount = "House_Account"
    let kServiceCard = "Service_Card"
    let kLoyalty = "Loyalty"
    let kLayaway = "Layaway"
    
    let kNo = "N"
    let kYes = "Y"
    
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
    
    
    
    /***********************************************************************************************************
     <Name> sendDataToActivateGiftCard </Name>
     <Input Type>   cardNumber:String,amount:String,entryMode:EntryMode,clerkID:String?,onSuccess:@escaping (_ successResponse:NSDictionary) -> Void,onFailure:@escaping (_ failureResponse:String)->Void </Input Type>
     <Return>   </Return>
     <Purpose> This method make post request for ADD/ACTIVATE gift option of Gift section</Purpose>
     <History>
     <Header> Version 1.0 </Header>
     <Date>   22/12/16 </Date>
     </History>
     ***********************************************************************************************************/
    public func sendDataToActivateGiftCard(cardNumber:String,amount:String,entryMode:EntryMode,clerkID:String?,onSuccess:@escaping (_ successResponse:NSDictionary) -> Void,onFailure:@escaping (_ failureResponse:String)->Void){
        
        let dict = NSMutableDictionary()
        serverManager = ServerManager(delegate: delegate, successBlock: onSuccess, failureBlock: onFailure)
        dict[kMerchant_Number] = merchantID
        dict[kTerminal_ID] = terminalID
        dict[kTransactionAmount] = amount
        dict[kCardNumber] = cardNumber
        dict[kAPIKey] = kApiKey
        dict[kActionCode] = kActioncodeForAddCash
        dict[kTransationType] = kTransactiontypeNonLoyality
        if(entryMode == EntryMode.Manual){
            dict[kPOSEntryMode] = kPosEntryModeManual
        }else{
            dict[kPOSEntryMode] = kPosEntryModeSwipe
        }
        
        if(clerkID != nil)
        {
            dict[kClerkID] = clerkID
        }
        serverManager.makePostRequest(url: kBaseURL, postDataDic: dict, viewControllerContext: delegate )
    }
    
    
    /***********************************************************************************************************
     <Name> sendDataToActivateEGiftCard </Name>
     <Input Type>   amount:String,clerkID:String?,entryMode:EntryMode,onSuccess: @escaping (_ successResponse:NSDictionary) -> Void,onFailure:@escaping (_ failureResponse:String)->Void){
     serverManager = ServerManager(delegate: delegate, successBlock: onSuccess, failureBlock: onFailure </Input Type>
     <Return>   </Return>
     <Purpose> This method make post request for ACTIVATE E-GIFT gift option of Gift section</Purpose>
     <History>
     <Header> Version 1.0 </Header>
     <Date>   22/12/16 </Date>
     </History>
     ***********************************************************************************************************/
    public func sendDataToActivateEGiftCard(amount:String,clerkID:String?,entryMode:EntryMode,onSuccess: @escaping (_ successResponse:NSDictionary) -> Void,onFailure:@escaping (_ failureResponse:String)->Void){
        serverManager = ServerManager(delegate: delegate, successBlock: onSuccess, failureBlock: onFailure)
        let dict = NSMutableDictionary()
        dict[kMerchant_Number] = merchantID
        dict[kTerminal_ID] = terminalID
        dict[kTransactionAmount] = amount
        dict[kCardNumber] = kNewAccountRequired
        dict[kAPIKey] = kApiKey
        dict[kActionCode] = kActioncodeForAddCashEGift
        dict[kTransationType] = kTransactiontypeNonLoyality
        if(entryMode == EntryMode.Manual){
            dict[kPOSEntryMode] = kPosEntryModeManual
        }else{
            dict[kPOSEntryMode] = kPosEntryModeSwipe
        }
        
        if(clerkID != nil)
        {
            dict[kClerkID] = clerkID
        }
        serverManager.makePostRequest(url: kBaseURL, postDataDic: dict, viewControllerContext: delegate )
    }
    
    
    /***********************************************************************************************************
     <Name> sendDataToRedeemGiftCard </Name>
     <Input Type>  cardNumber:String,amount:String,entryMode:EntryMode,clerkID:String?,onSuccess: @escaping (_ successResponse:NSDictionary) -> Void,onFailure:@escaping (_ failureResponse:String)->Void </Input Type>
     <Return>   </Return>
     <Purpose> This method make post request for REDEEM gift option of Gift section</Purpose>
     <History>
     <Header> Version 1.0 </Header>
     <Date>   22/12/16 </Date>
     </History>
     ***********************************************************************************************************/

    public func sendDataToRedeemGiftCard(cardNumber:String,amount:String,entryMode:EntryMode,clerkID:String?,onSuccess: @escaping (_ successResponse:NSDictionary) -> Void,onFailure:@escaping (_ failureResponse:String)->Void){
        
        serverManager = ServerManager(delegate: delegate, successBlock: onSuccess, failureBlock: onFailure)
        let dict = NSMutableDictionary()
        dict[kMerchant_Number] = merchantID
        dict[kTerminal_ID] = terminalID
        dict[kTransactionAmount] = amount
        dict[kCardNumber] = cardNumber
        dict[kAPIKey] = kApiKey
        dict[kActionCode] = kActioncodeForDeduceCash
        dict[kBussinessType] = kBusinessTypeRestaurent
        dict[kTransationType] = kTransactiontypeNonLoyality
        if(entryMode == EntryMode.Manual){
            dict[kPOSEntryMode] = kPosEntryModeManual
        }else{
            dict[kPOSEntryMode] = kPosEntryModeSwipe
        }
        
        if(clerkID != nil)
        {
            dict[kClerkID] = clerkID
        }
        serverManager.makePostRequest(url: kBaseURL, postDataDic: dict, viewControllerContext: delegate )
    }
    
    
    
    /***********************************************************************************************************
     <Name> sendDataToRedeemLoyalty </Name>
     <Input Type>  cardNumber:String,amount:String,entryMode:EntryMode,clerkID:String?,onSuccess:@escaping (_ successResponse:NSDictionary) -> Void,onFailure:@escaping (_ failureResponse:String)->Void </Input Type>
     <Return>   </Return>
     <Purpose> This method make post request for REDEEM gift option of LOYALTY section</Purpose>
     <History>
     <Header> Version 1.0 </Header>
     <Date>   22/12/16 </Date>
     </History>
     ***********************************************************************************************************/

    public func sendDataToRedeemLoyalty(cardNumber:String,amount:String,entryMode:EntryMode,clerkID:String?,onSuccess:@escaping (_ successResponse:NSDictionary) -> Void,onFailure:@escaping (_ failureResponse:String)->Void){
        
        serverManager = ServerManager(delegate: delegate, successBlock: onSuccess, failureBlock: onFailure)
        
        let dict = NSMutableDictionary()
        dict[kMerchant_Number] = merchantID
        dict[kTerminal_ID] = terminalID
        dict[kTransactionAmount] = amount
        dict[kCardNumber] = cardNumber
        dict[kAPIKey] = kApiKey
        dict[kActionCode] = kActioncodeForRedeemLoyality
        dict[kBussinessType] = kBusinessTypeRestaurent
        dict[kTransationType] = kTransactiontypeLoyality
        if(entryMode == EntryMode.Manual){
            dict[kPOSEntryMode] = kPosEntryModeManual
        }else{
            dict[kPOSEntryMode] = kPosEntryModeSwipe
        }
        dict[kTransaction_ID] = transactionID
        if(clerkID != nil)
        {
            dict[kClerkID] = clerkID
        }
        serverManager.makePostRequest(url: kBaseURL, postDataDic: dict, viewControllerContext: delegate )
    }
    
    
    /***********************************************************************************************************
     <Name> sendDataToLoyaltyAccural </Name>
     <Input Type>  cardNumber:String,amount:String,entryMode:EntryMode,clerkID:String?,onSuccess:@escaping (_ successResponse:NSDictionary) -> Void,onFailure:@escaping (_ failureResponse:String)->Void </Input Type>
     <Return>   </Return>
     <Purpose> This method make post request for ACCRUAL gift option of LOYALTY section</Purpose>
     <History>
     <Header> Version 1.0 </Header>
     <Date>   22/12/16 </Date>
     </History>
     ***********************************************************************************************************/
    public func sendDataToLoyaltyAccural(cardNumber:String,amount:String,entryMode:EntryMode,clerkID:String?,onSuccess:@escaping (_ successResponse:NSDictionary) -> Void,onFailure:@escaping (_ failureResponse:String)->Void){
        serverManager = ServerManager(delegate: delegate, successBlock: onSuccess, failureBlock: onFailure)
        let dict = NSMutableDictionary()
        dict[kMerchant_Number] = merchantID
        dict[kTerminal_ID] = terminalID
        dict[kTransactionAmount] = amount
        dict[kCardNumber] = cardNumber
        dict[kAPIKey] = kApiKey
        dict[kActionCode] = kActioncodeForAddLoyality
        dict[kBussinessType] = kBusinessTypeRestaurent
        dict[kTransationType] = kTransactiontypeLoyality
        if(entryMode == EntryMode.Manual){
            dict[kPOSEntryMode] = kPosEntryModeManual
        }else{
            dict[kPOSEntryMode] = kPosEntryModeSwipe
        }
        dict[kTransaction_ID] = transactionID
        dict[kTicket] = emptyString
        if(clerkID != nil)
        {
            dict[kClerkID] = clerkID
        }
        serverManager.makePostRequest(url: kBaseURL, postDataDic: dict, viewControllerContext: delegate )
    }
   
    

    /***********************************************************************************************************
     <Name> sendDataToEnquireBalance </Name>
     <Input Type>  cardNumber:String,amount:String,entryMode:EntryMode,clerkID:String?,onSuccess:@escaping (_ successResponse:NSDictionary) -> Void,onFailure:@escaping (_ failureResponse:String)->Void </Input Type>
     <Return>   </Return>
     <Purpose> This method make post request for BALANCE ENQUIRY option of LOYALTY and GIFT section</Purpose>
     <History>
     <Header> Version 1.0 </Header>
     <Date>   22/12/16 </Date>
     </History>
     ***********************************************************************************************************/

    public func sendDataToEnquireBalance(cardNumber:String,clerkID:String?,entryMode:EntryMode,option:BalanceOption,onSuccess:@escaping (_ successResponse:NSDictionary) -> Void,onFailure:@escaping (_ failureResponse:String)->Void){
        
        serverManager = ServerManager(delegate: delegate, successBlock: onSuccess, failureBlock: onFailure)
        let dict = NSMutableDictionary()
        dict[kMerchant_Number] = merchantID
        dict[kTerminal_ID] = terminalID
        
        
        dict[kAPIKey] = kApiKey
        dict[kActionCode] = kActioncodeForBalanceEnquiry
        
        if(option == BalanceOption.BalanceOfGiftCard){
            dict[kTransationType] = kTransactiontypeNonLoyality
        }else{
            dict[kTransationType] = kTransactiontypeLoyality
        }
        
        if(entryMode == EntryMode.Manual){
            dict[kPOSEntryMode] = kPosEntryModeManual
        }else{
            dict[kPOSEntryMode] = kPosEntryModeSwipe
        }
        
        if(clerkID != nil)
        {
            dict[kClerkID] = clerkID
        }
        if((dict[kPOSEntryMode] as! String) == kPosEntryModeSwipe){
            dict[kTrackData2] = cardNumber
        }else{
            dict[kCardNumber] = cardNumber
        }
        serverManager.makePostRequest(url: kBaseURL, postDataDic: dict, viewControllerContext: delegate )
    }
    
    /***********************************************************************************************************
     <Name> sendDataToVoidGiftCardItem </Name>
     <Input Type> item:String,clerkID:String?,entryMode:EntryMode,onSuccess:@escaping (_ successResponse:NSDictionary) -> Void,onFailure:@escaping (_ failureResponse:String)->Void </Input Type>
     <Return>   </Return>
     <Purpose> This method make post request for VOID gift option of GIFT section</Purpose>
     <History>
     <Header> Version 1.0 </Header>
     <Date>   22/12/16 </Date>
     </History>
     ***********************************************************************************************************/
    public func sendDataToVoidGiftCardItem(item:String,clerkID:String?,entryMode:EntryMode,onSuccess:@escaping (_ successResponse:NSDictionary) -> Void,onFailure:@escaping (_ failureResponse:String)->Void){
        
        serverManager = ServerManager(delegate: delegate, successBlock: onSuccess, failureBlock: onFailure)
        let dict = NSMutableDictionary()
        dict[kMerchant_Number] = merchantID
        dict[kTerminal_ID] = terminalID
        dict[kAuthReference] = item
        dict[kAPIKey] = kApiKey
        dict[kActionCode] = kActioncodeForVoidTransaction
        dict[kTransationType] = kTransactiontypeNonLoyality
        if(entryMode == EntryMode.Manual){
            dict[kPOSEntryMode] = kPosEntryModeManual
        }else{
            dict[kPOSEntryMode] = kPosEntryModeSwipe
        }
        dict[kTransaction_ID] = transactionID
        if(clerkID != nil)
        {
            dict[kClerkID] = clerkID
        }
        serverManager.makePostRequest(url: kBaseURL, postDataDic: dict, viewControllerContext: delegate )
        
    }
    
    
    /***********************************************************************************************************
     <Name> getGiftCardDetailReport </Name>
     <Input Type> forDate date:String,isForGift:Bool,onSuccess:@escaping (_ successResponse:String) -> Void,onFailure:@escaping (_ failureResponse:String </Input Type>
     <Return>   </Return>
     <Purpose> This method make post request for GIFT CARD DETAIL REPORT gift option of REPORT section</Purpose>
     <History>
     <Header> Version 1.0 </Header>
     <Date>   22/12/16 </Date>
     </History>
     ***********************************************************************************************************/
    public func getGiftCardDetailReport(forDate date:String,isForGift:Bool,onSuccess:@escaping (_ successResponse:String) -> Void,onFailure:@escaping (_ failureResponse:String)->Void){
        
        
        let dict = NSMutableDictionary()
        dict[kMerchant_Number] = merchantID
        dict[kTerminal_ID] = terminalID
        dict[kTransaction_ID] = transactionID
        dict[kFullDate] = date
        dict[kGet] = kFalse
        var url = emptyString
        if(isForGift){
            url =  kBaseURLForMerchantDetail.appending(kReportGiftDetailViewURL)
        }else{
            url =  kBaseURLForMerchantDetail.appending(kReportLoyaltyDetailViewURL)
        }
        serverManager = ServerManager(delegate: delegate, successBlockForReport: onSuccess, failureBlock: onFailure)
        serverManager.makePostRequestForReport(url: url, postDataDic: dict, viewControllerContext: delegate)
    }
    

    
    /***********************************************************************************************************
     <Name> getCardDetailStatement </Name>
     <Input Type> forCard cardNumber:String,onSuccess:@escaping (_ successResponse:String) -> Void,onFailure:@escaping (_ failureResponse:String)->Void </Input Type>
     <Return>   </Return>
     <Purpose> This method make post request for GIFT CARD STATEMENT gift option of REPORT section</Purpose>
     <History>
     <Header> Version 1.0 </Header>
     <Date>   22/12/16 </Date>
     </History>
     ***********************************************************************************************************/
    public func getCardDetailStatement(forCard cardNumber:String,onSuccess:@escaping (_ successResponse:String) -> Void,onFailure:@escaping (_ failureResponse:String)->Void){
        let dict = NSMutableDictionary()
        dict[kMerchant_Number] = merchantID
        dict[kTerminal_ID] = terminalID
        dict[kTransaction_ID] = transactionID
        dict[kCardNumber] = cardNumber
        dict[kFullDate] = emptyString
        dict[kGet] = kFalse
        dict[kPOSEntryMode] = kPosEntryModeManual
        dict[kActionCode] = defaultActionCodeForReport
        
        let url = kBaseURL//ForMerchantDetail.appending(kReportCardholderDetailViewURL)
        serverManager = ServerManager(delegate: delegate, successBlockForReport: onSuccess, failureBlock: onFailure)
        serverManager.makePostRequestForReport(url: url, postDataDic: dict, viewControllerContext: delegate)
        
    }
    
   
    
    /***********************************************************************************************************
     <Name> sendContactInfoToServer </Name>
     <Input Type> merchantName:String,firstName:String,lastName:String,address1:String,address2:String,city:String,state:String,zip:String,phone:String,email:String,onSuccess:@escaping (_ successResponse:NSDictionary) -> Void,onFailure:@escaping (_ failureResponse:String)->Void </Input Type>
     <Return>   </Return>
     <Purpose> This method make post whenever user tap on NEW MERCHANT Option</Purpose>
     <History>
     <Header> Version 1.0 </Header>
     <Date>   22/12/16 </Date>
     </History>
     ***********************************************************************************************************/
    public func sendContactInfoToServer(merchantName:String,firstName:String,lastName:String,address1:String,address2:String,city:String,state:String,zip:String,phone:String,email:String,onSuccess:@escaping (_ successResponse:NSDictionary) -> Void,onFailure:@escaping (_ failureResponse:String)->Void){
        let dict = NSMutableDictionary()
        dict[kMerchant_Number] = defaultMerchantID //merchantID
        dict[kTerminal_ID] = defaultTerminalIDForNewMerchant//defaultTerminalID
        dict[kTransaction_ID] = emptyString
        dict[kMerchant_name] = merchantName
        dict[kContact_fname] = firstName
        dict[kContact_lname] = lastName
        dict[kAddress1] = address1
        dict[kAddress2] = address2
        dict[kCity] = city
        dict[kState] = state
        dict[kZip] = zip
        dict[kCountry] = defaultCountry
        dict[kPhone] = phone
        dict[kEmail] = email
        dict[kGet] = kTrue
        dict[kActionCode] = defaultActionCodeForMerchant
        dict[kPOSEntryMode] = kPosEntryModeManual
        dict[kGift] = kYes
        dict[kHouseAccount] = kNo
        dict[kServiceCard] = kNo
        dict[kLoyalty] = kYes
        dict[kLayaway] = kNo
        
        
        let url = kBaseURL//kBaseURLForMerchantDetail.appending(kSetUpMerchantURL)
        serverManager = ServerManager(delegate: delegate, successBlock: onSuccess, failureBlock: onFailure)
        serverManager.makePostRequest(url: url, postDataDic: dict, viewControllerContext: delegate)
    }
}
