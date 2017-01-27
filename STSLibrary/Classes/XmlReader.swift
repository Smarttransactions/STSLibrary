//
//  XmlReader.swift
//  ServerManagerDemo
//
//  Created by Chetu-macmini-27 on 22/12/16.
//  Copyright © 2016 Chetu-macmini-27. All rights reserved.
//

import Foundation
class XmlReader: NSObject,XMLParserDelegate {
    var errorPointer:NSError;
    var dictionaryStack:NSMutableArray;
    var textInProgress:NSMutableString;
    let kXMLReaderTextNodeKey = "text";
    init(error:NSError) {
        dictionaryStack = NSMutableArray()
        textInProgress = NSMutableString()
        errorPointer = error
    }
    
    static func dictionaryForXMLString(string:String,error:NSError)->NSDictionary{
        let data = string.data(using: String.Encoding.utf8)
        return XmlReader.dictionaryForXMLData(data: data!, error: error)
    }
    
    static func dictionaryForXMLData(data:Data,error:NSError)->NSDictionary{
        let reader = XmlReader.init(error: error)
        return reader.objectWithData(data: data)
    }
    
    
    
    func objectWithData(data:Data) -> NSDictionary{
        dictionaryStack = NSMutableArray()
        textInProgress = NSMutableString()
        dictionaryStack.add(NSMutableDictionary())
        let parser = XMLParser(data: data)
        parser.delegate = self;
        let success = parser.parse();
        
        if (success)
        {
            let resultDict = dictionaryStack[0];
            
            return resultDict as! NSDictionary;
        }
        
        return NSDictionary();
    }
    
    func parser(_ parser: XMLParser, didStartElement elementName: String, namespaceURI: String?, qualifiedName qName: String?, attributes attributeDict: [String : String] = [:]) {
        // Get the dictionary for the current level in the stack
        let parentDict = dictionaryStack.lastObject as! NSMutableDictionary
        
        // Create the child dictionary for the new element
        let childDict = NSMutableDictionary()
        
        // Initialize child dictionary with the attributes, prefixed with '@'
        for (key,value) in attributeDict {
            childDict[key] = value
            
        }
        
        // If there's already an item for this key, it means we need to create an array
        let existingValue = parentDict[elementName]
        
        if ((existingValue) != nil)
        {
            var array:NSMutableArray? = nil;
            
            if(existingValue is NSMutableArray)
            {
                // The array exists, so use it
                array = existingValue as? NSMutableArray;
            }
            else
            {
                // Create an array if it doesn't exist
                array = NSMutableArray()
                array?.add(existingValue)
                
                
                // Replace the child dictionary with an array of children dictionaries
                parentDict[elementName] = array
            }
            
            // Add the new child dictionary to the array
            array?.add(childDict)
        }
        else
        {
            // No existing value, so update the dictionary
            parentDict[elementName] = childDict
        }
        
        // Update the stack
        dictionaryStack.add(childDict)
    }
    
    func parser(_ parser: XMLParser, didEndElement elementName: String, namespaceURI: String?, qualifiedName qName: String?) {
        // Update the parent dict with text info
        let dictInProgress = dictionaryStack.lastObject as! NSMutableDictionary
        
        // Pop the current dict
        dictionaryStack.removeLastObject()
        
        // Set the text property
        if (textInProgress.length > 0)
        {
            if (dictInProgress.count > 0)
            {
                dictInProgress[kXMLReaderTextNodeKey] = textInProgress
            }
            else
            {
                // Given that there will only ever be a single value in this dictionary, let's replace the dictionary with a simple string.
                let parentDict = dictionaryStack.lastObject as! NSMutableDictionary
                let parentObject = parentDict[elementName] as AnyObject
                
                // Parent is an Array
                if (parentObject is NSMutableArray)
                {
                    parentObject.removeLastObject()
                    parentObject.add(textInProgress)
                }
                    
                    // Parent is a Dictionary
                else
                {
                    parentDict.removeObject(forKey: elementName)
                    parentDict[elementName] = textInProgress
                }
            }
            
            // Reset the text
            //[textInProgress release];
            textInProgress = NSMutableString()
        }
            
            // If there was no value for the tag, and no attribute, then remove it from the dictionary.
        else if (dictInProgress.count == 0)
        {
            let parentDict = dictionaryStack.lastObject as! NSMutableDictionary
            parentDict.removeObject(forKey: elementName)
        }
        
    }
    
    func parser(_ parser: XMLParser, foundCharacters string: String) {
        textInProgress.append(string)
    }
    func parser(_ parser: XMLParser, parseErrorOccurred parseError: Error) {
        if (errorPointer != nil){
            errorPointer = parseError as NSError;
        }
    }
}
