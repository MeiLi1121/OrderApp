//
//  OAJSONHelper.swift
//  OrderApp
//
//  Created by Shawn Xu on 12/31/16.
//  Copyright © 2016 Shawn Xu. All rights reserved.
//

import UIKit

class OAJSONHelper: NSObject {
  class func syncFrom(_ file: String) -> Any? {
    let documentsDirectoryPathString = NSSearchPathForDirectoriesInDomains(.documentDirectory, .userDomainMask, true).first!
    let documentsDirectoryPath = URL(string: documentsDirectoryPathString)!
    let jsonFilePath = documentsDirectoryPath.appendingPathComponent(file)
    let fileManager = FileManager.default
    var isDirectory: ObjCBool = false
    
    if !fileManager.fileExists(atPath: jsonFilePath.absoluteString, isDirectory: &isDirectory) {
      return nil
    }
    do {
      let file = try FileHandle(forReadingFrom: jsonFilePath)
      let jsonData: Data! = file.readDataToEndOfFile()
      do {
        let json = try JSONSerialization.jsonObject(with: jsonData, options: JSONSerialization.ReadingOptions())
        return json
      } catch let error as NSError {
        print("JSON to Dictionary conversion failed: \(error.localizedDescription)")
      }
    } catch let error as NSError {
      print("Couldn't write to file: \(error.localizedDescription)")
    }
    return nil
  }
  
  class func syncTo(_ file: String, withJSON json:[String:String]?) {
    guard let json = json else {
      return
    }
    let documentsDirectoryPathString = NSSearchPathForDirectoriesInDomains(.documentDirectory, .userDomainMask, true).first!
    let documentsDirectoryPath = URL(string: documentsDirectoryPathString)!
    let jsonFilePath = documentsDirectoryPath.appendingPathComponent(file)
    let fileManager = FileManager.default
    var isDirectory: ObjCBool = false
    
    // creating a .json file in the Documents folder
    if !fileManager.fileExists(atPath: jsonFilePath.absoluteString, isDirectory: &isDirectory) {
      let created = fileManager.createFile(atPath: jsonFilePath.absoluteString, contents: nil, attributes: nil)
      if !created {
        return
      }
    }
    
    var jsonData: Data!
    do {
      jsonData = try JSONSerialization.data(withJSONObject: json, options: JSONSerialization.WritingOptions())
    } catch let error as NSError {
      print("Array to JSON conversion failed: \(error.localizedDescription)")
    }
    
    // Write that JSON to the file created earlier
    do {
      let file = try FileHandle(forWritingTo: jsonFilePath)
      file.truncateFile(atOffset: 0)
      file.write(jsonData)
    } catch let error as NSError {
      print("Couldn't write to file: \(error.localizedDescription)")
    }
  }
}
