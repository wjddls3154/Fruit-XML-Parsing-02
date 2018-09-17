//
//  ViewController.swift
//  Fruit XML Parsing 02
//
//  Created by D7702_10 on 2018. 9. 17..
//  Copyright © 2018년 jik. All rights reserved.
//

import UIKit

class ViewController: UIViewController, XMLParserDelegate {

    //딕셔너리 배열
    var elements:[[String:String]] = []
    
    //배열
    var item:[String:String] = [:]
    
    var currentElement = ""
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        if let path = Bundle.main.url(forResource: "Fruit", withExtension: "xml") {
            if let myParser = XMLParser(contentsOf: path) {
                //XMLParsetDelegate와 ViewController 와 connection
                myParser.delegate = self
                
                if myParser.parse() {
                    print("Parsing succed!")
                    print(elements)
                    
                } else {
                    print("Parsing failed!")
                }
            } else {
                print("parser nil")
            }
            
        } else {
            print("XML file not found!")
        }
    
        
    }

  // XMLParserDelegate 메소드 호출
  // 1. tag(element)를 만났을때 호출
    func parser(_ parser: XMLParser, didStartElement elementName: String, namespaceURI: String?, qualifiedName qName: String?, attributes attributeDict: [String : String] = [:]) {
        currentElement = elementName
        print("currentElement = \(currentElement)")
        
    }
    
 // 2. 문자열을 만났을때 호출
    func parser(_ parser: XMLParser, foundCharacters string: String) {
        let data = string.trimmingCharacters(in: CharacterSet.whitespacesAndNewlines)
        if !data.isEmpty{
            item[currentElement] = data
         
            
        }
    }
    
 // 3. tag을 끝을 만났을때 호출(/tag)
    func parser(_ parser: XMLParser, didEndElement elementName: String, namespaceURI: String?, qualifiedName qName: String?) {
        if elementName == "item" {
            elements.append(item)
        }
    }
    
    
}

