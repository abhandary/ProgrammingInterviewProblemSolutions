//
//  Parser.swift
//  LeetCode
//
//  Created by Akshay Bhandary on 3/23/17.
//  Copyright © 2017 Akshay Bhandary. All rights reserved.
//

import Foundation

class Parser {
    
    
    func decode(_ str : String) -> String {
        guard str.characters.count > 0 else { return ""; }
        
        let schars = Array(str.characters);
        var num : Int?
        var repeatNum : Int?
        var result = "";
        
        for c in schars {
            switch c {
            case "0"..."9":
                if repeatNum != nil { result += "\(repeatNum!)x"; repeatNum = nil; }
                num = num == nil ? Int(String(c)) : num! * 10 + Int(String(c))!;
                break;
            case "x":
                if num != nil { repeatNum = num; num = nil; }
                else { result += String(c); }
                break;
            default:
                if  repeatNum != nil {
                    result += String(repeating: String(c), count : repeatNum!);
                    repeatNum = nil;
                } else {
                    if let numVal = num { result += String(numVal); num = nil; }
                    result += String(c);
                }
                break;
            }
        }
        if let num = num { result += String(num); }
        if repeatNum != nil { result += "\(repeatNum!)x" }
        return result;
    }
    
    
    
}
