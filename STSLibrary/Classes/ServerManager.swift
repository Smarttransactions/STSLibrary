//
//  ServerManager.swift
//  ServerManagerDemo
//
//  Created by Chetu-macmini-27 on 22/12/16.
//  Copyright © 2016 Chetu-macmini-27. All rights reserved.
//

import Foundation
import UIKit

class ServerManager: NSObject {
    var receivedData = NSMutableData();
    var isForReport = false
    var successBlockForReport:(_ responseDict:String)->Void = {_ in }
    var successBlock:(_ responseDict:NSDictionary)->Void = {_ in }
    var failureBlock:(_ responseDict:String)->Void
    var delegate = NSObject()
    var loaderView:LoaderView = LoaderView()
    init(delegate:NSObject,successBlock:@escaping (_ responseDict:NSDictionary)->Void,failureBlock:@escaping (_ responseDict:String)->Void) {
        self.delegate = delegate
        self.failureBlock = failureBlock
        self.successBlock = successBlock
    }
    
    init(delegate:NSObject,successBlockForReport:@escaping (_ responseDict:String)->Void,failureBlock:@escaping (_ responseDict:String)->Void) {
        self.delegate = delegate
        self.failureBlock = failureBlock
        self.successBlockForReport = successBlockForReport
        isForReport = true
    }
    
    /***********************************************************************************************************
     <Name> makePostRequest </Name>
     <Input Type>   url:String, postDataDic:NSDictionary, viewControllerContext:UIViewController </Input Type>
     <Return>  </Return>
     <Purpose> This method post request on the specified url with dictionary as action parameter and initialize the spinner </Purpose>
     <History>
     <Header> Version 1.0 </Header>
     <Date>   29/12/16 </Date>
     </History>
     ***********************************************************************************************************/
    func makePostRequest(url:String, postDataDic:NSDictionary, viewControllerContext:UIViewController){
        if(validateDictionary(dict: postDataDic)){
            var postString = self.getXMLFromDict(dict: postDataDic)
            let msgLength = "\(postString.characters.count)"
            
            let request = NSMutableURLRequest(url: URL(string: url)!)
            request.httpMethod = "POST"
            request.addValue(msgLength, forHTTPHeaderField: "Content-Length")
            request.httpBody = postString.data(using: String.Encoding.utf8)
            loaderView.initLoader()
            (delegate as! UIViewController).view.addSubview(loaderView)
            let connection = NSURLConnection(request: request as URLRequest, delegate: self)
            
            if(connection != nil){
                receivedData = NSMutableData()
            }else{
                let errorAlert = UIAlertController(title: "NSURLConnection", message: "Failed to make connection", preferredStyle: UIAlertControllerStyle.alert)
                errorAlert.addAction(UIAlertAction(title: "OK", style: UIAlertActionStyle.cancel, handler: { (alert) in
                    
                }))
                viewControllerContext.present(errorAlert, animated: true, completion: nil)
            }
        }
    }
    
    
    /***********************************************************************************************************
     <Name> makePostRequestForReport </Name>
     <Input Type>   url:String, postDataDic:NSDictionary, viewControllerContext:UIViewController </Input Type>
     <Return>  </Return>
     <Purpose> This method post request for Report on the specified url with dictionary as action parameter and initialize the spinner </Purpose>
     <History>
     <Header> Version 1.0 </Header>
     <Date>  22/12/16 </Date>
     </History>
     ***********************************************************************************************************/
    func makePostRequestForReport(url:String, postDataDic:NSDictionary, viewControllerContext:UIViewController){
        if(validateDictionary(dict: postDataDic)){
            var postString =  getXMLFromDict(dict: postDataDic) // self.createStringUsingDictionary(dataDic: postDataDic)//
            let msgLength = "\(postString.characters.count)"
            
            let request = NSMutableURLRequest(url: URL(string: url)!)
            request.httpMethod = "POST"
            request.addValue(msgLength, forHTTPHeaderField: "Content-Length")
            request.httpBody = postString.data(using: String.Encoding.utf8)
            loaderView.initLoader()
            (delegate as! UIViewController).view.addSubview(loaderView)
            let connection = NSURLConnection(request: request as URLRequest, delegate: self)
            
            if(connection != nil){
                receivedData = NSMutableData()
            }else{
                let errorAlert = UIAlertController(title: "NSURLConnection", message: "Failed to make connection", preferredStyle: UIAlertControllerStyle.alert)
                errorAlert.addAction(UIAlertAction(title: "OK", style: UIAlertActionStyle.cancel, handler: { (alert) in
                    
                }))
                viewControllerContext.present(errorAlert, animated: true, completion: nil)
            }
        }
    }
    
    
    /***********************************************************************************************************
     <Name> validateDictionary </Name>
     <Input Type>   NSDictionary </Input Type>
     <Return> Bool </Return>
     <Purpose> This method validate the dictionary and return true if specified dictionary is valid (Avoid Nil parameter in HTTP action code) </Purpose>
     <History>
     <Header> Version 1.0 </Header>
     <Date>   22/12/16 </Date>
     </History>
     ***********************************************************************************************************/
    func validateDictionary(dict:NSDictionary) -> Bool {
        for (key,value) in dict{
            if((value as AnyObject) == nil){
                let errorAlert = UIAlertController(title: "Request error!", message: (key as! String)+" is missing.", preferredStyle: UIAlertControllerStyle.alert)
                errorAlert.addAction(UIAlertAction(title: "OK", style: UIAlertActionStyle.cancel, handler: { (alert) in
                    
                }))
                (delegate as! UIViewController).present(errorAlert, animated: true, completion: nil)
                return false
            }
        }
        return true
    }
    
    /***********************************************************************************************************
     <Name> getXMLFromDict </Name>
     <Input Type>   NSDictionary </Input Type>
     <Return> String </Return>
     <Purpose> This method validate the dictionary and return true if specified dictionary is valid (Avoid Nil parameter in HTTP action code) </Purpose>
     <History>
     <Header> Version 1.0 </Header>
     <Date>   22/12/16 </Date>
     </History>
     ***********************************************************************************************************/

    func getXMLFromDict(dict:NSDictionary)->String{
        var xmlString = "<Request>"
        for(key, value) in dict{
            
            xmlString = xmlString+"<"+(key as! String)+">"+(value as! String)+"</"+(key as! String)+">"
        }
        xmlString = xmlString+"</Request>"
        return xmlString;
        
    }
    
    /***********************************************************************************************************
     <Name> showAlertView </Name>
     <Input Type>   onView:UIViewController,messageString:String,cancelText:String,otherText:String?,titleString:String) </Input Type>
     <Return>  </Return>
     <Purpose> This method present an alert view on the current ViewController </Purpose>
     <History>
     <Header> Version 1.0 </Header>
     <Date>   22/12/16 </Date>
     </History>
     ***********************************************************************************************************/
    
    func showAlertView(onView:UIViewController,messageString:String,cancelText:String,otherText:String?,titleString:String){
        let alertController = UIAlertController(title: titleString, message: messageString, preferredStyle:.alert)
        alertController.addAction(UIAlertAction(title: cancelText, style: .cancel){ action -> Void in
            alertController.dismiss(animated: true, completion: nil)
        })
        onView.present(alertController, animated: true, completion: nil)
    }
    
    
    /***********************************************************************************************************
     <Name> urlEncodeString </Name>
     <Input Type> String </Input Type>
     <Return> String </Return>
     <Purpose> This method varify the url , if it contain any unspecified character </Purpose>
     <History>
     <Header> Version 1.0 </Header>
     <Date>   22/12/16 </Date>
     </History>
     ***********************************************************************************************************/
    func urlEncodeString(str:(String)) -> String {
        let unreserved = "!*'();:@&=+$,/?%#[]"
        let allowed = NSMutableCharacterSet.alphanumeric()
        allowed.addCharacters(in: unreserved)
        
        return str.addingPercentEncoding( withAllowedCharacters: allowed as CharacterSet)!
    }
    
    
    /***********************************************************************************************************
     <Name> createStringUsingDictionary </Name>
     <Input Type>   NSDictionary </Input Type>
     <Return> String </Return>
     <Purpose> This method return the post url by accpting the dictionary </Purpose>
     <History>
     <Header> Version 1.0 </Header>
     <Date>   22/12/16 </Date>
     </History>
     ***********************************************************************************************************/

    func createStringUsingDictionary(dataDic:NSDictionary) -> String {
        var string = ""
        var keyCounter = 0
        for key in dataDic.allKeys{
            
            let val = dataDic[key]
            if(keyCounter == 0){
                string = string+(key as! String)+"="+(val as! String)
            }
            else{
                string = string+"&"+(key as! String)+"="+(val as! String)
                
            }
            keyCounter += 1;
            
        }
        return string
    }
    
}

extension ServerManager:NSURLConnectionDelegate{
    func connection(_ connection: NSURLConnection, didFailWithError error: Error) {
        //[self HideLoadingLoaderView];
        
        self.showAlertView(onView: delegate as! UIViewController, messageString: error.localizedDescription, cancelText: "OK", otherText: nil, titleString: "Error")
        loaderView.removeFromSuperview()
        self.failureBlock(error.localizedDescription)
        
    }

    func connectionDidFinishLoading(_ connection: NSURLConnection) {
        
        let dataString = String(data: receivedData as Data, encoding: String.Encoding.utf8);
        let error = NSError()
        
        //Hiding loading view
        loaderView.removeFromSuperview()
        if(isForReport){
            self.successBlockForReport(dataString!)
        }
        else{
            let searchData = XmlReader.dictionaryForXMLString(string: dataString!, error: error)
            self.successBlock(searchData)
        }
    }
}


extension ServerManager:NSURLConnectionDataDelegate{
    func connection(_ connection: NSURLConnection, didReceive response: URLResponse) {
        _ = response as! HTTPURLResponse;
        receivedData.length = 0
        
    }
    
    func connection(_ connection: NSURLConnection, didReceive data: Data) {
        
        receivedData.append(data as Data)

    }
    
}

