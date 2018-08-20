//
//  DocumentOperations.swift
//  Report
//
//  Created by Nicholas Edward Barnhart on 12/5/16.
//  Copyright © 2016 Nicholas Edward Barnhart. All rights reserved.
//


import Foundation
import UIKit


protocol DocumentOperations {
    
    // Takes your image tags and the base url and generates a html string
    func generateHTMLString(imageTags: [String], baseURL: String, action: String, observation: String, impact: String, location: String, workers: String, date: String, imageAmount: Int) -> String
    
    // Uses UIViewPrintFormatter to generate pdf and returns pdf location
    func createPDF(html: String, formmatter: UIViewPrintFormatter, filename: String) -> String
    
    
    // Wraps your image filename in a HTML img tag
    func imageTags(filenames: [String], settings: [String]) -> [String]
}


extension DocumentOperations  {
    
    
    func imageTags(filenames: [String], settings: [String]) -> [String] {
        
        var tags: [String] = ["Dovahkin","Wander","Rathalos"]
        
        if(settings[0] == "Portrait"){
            tags[0] =   "<img src=\"\(filenames[0])\" style='width:180px;height:230px;margin:5px;margin-left:100px'>"

        
        }
        else{
            tags[0] =   "<img src=\"\(filenames[0])\" style='width:270px;height:160px;margin:5px;margin-left:50px'>"
        
        }
        
        if(settings[1] == "Portrait"){
            tags[1] =   "<img src=\"\(filenames[1])\" style='width:180px;height:230px;margin:5px;margin-left:100px'>"

        }
        else{
            tags[1] =   "<img src=\"\(filenames[1])\" style='width:270px;height:160px;margin:5px;margin-left:50px'>"

        
        }
        
        if(settings[2] == "Portrait"){
            tags[2] =   "<img src=\"\(filenames[2])\" style='width:180px;height:230px;margin:5px;margin-left:100px'>"

        
        }
        else{
            tags[2] =   "<img src=\"\(filenames[2])\" style='width:270px;height:160px;margin:5px;margin-left:50px'>"

        }
        
        return tags
    }
    
    
    func generateHTMLString(imageTags: [String], baseURL: String, action: String, observation: String, impact: String, location: String, workers: String, date: String, imageAmount: Int) -> String {
        
        var power: Int? = Int(workers)
        
        if (power == nil){
            power = 0
        }
        
        
        
        
        
        
        
        
        // Example: just using the first element in the array
        var html = "<!DOCTYPE html><head><base href=\"\(baseURL)\"></head>\n<html>\n<body style='margin:70px;margin-left:80px;margin-right:80px;font-family:Arial'>\n"
        html = html + "<h1 style='font-family: colaborate, bold, sans-serif;color:#008C95;letter-spacing:-1px;'>SIEMENS</h1> <hr> <h3 style='margin:0px'>Site Photo</h3> <table border ='1' style='width:100%;border-collapse: collapse;padding:0px;margin-top:5%'> <tbody> <tr style='background-color:#f2f2f2;font-size:50%'> <td> "
        
        
             html = html + "<b>\(location) -- \(workers) Personnel"
        
        
        html = html + "</td><td><b style='margin-left:0px'>Date: \(date)</b> </td> </tr> <tr style=''> <td style='margin:0px;width:62%'>\(imageTags[0]) </td>"
        
        if(imageAmount == 1){
            html = html + "<td rowspan='1' style='vertical-align:top'>"
        }
        if(imageAmount == 2){
            html = html + "<td rowspan='2' style='vertical-align:top'>"
        }
        if(imageAmount == 3){
            html = html + "<td rowspan='3' style='vertical-align:top'>"
            
        }
        
        html = html + "<p> <u> OBSERVATION:</u></p> <p>\(observation)</p>"
        html = html + "<p style='margin-top:10px'><u>ACTION:</u></p> <p>\(action)</p><p style='margin-top:10px'><u>IMPACT:</u></p> <p>\(impact)</p> </td> </tr>"
        
        if(imageAmount == 2){
            html = html + "<tr> <td>\(imageTags[1])</td> </tr>"
        }
        
        if(imageAmount == 3){
            
            html = html + "<tr> <td>\(imageTags[1])</td></tr> <tr><td> \(imageTags[2]) </td></tr>"
        }
        
        html = html + "</tbody> </table>"

        html = html + "</body>\n</html>\n"
        
       /* html = html + "<footer style='position:absolute;right:0;bottom:0;left:0;margin-top:100%;background-color:#efefef;'> <hr> <p style='text-align:center;'>End of Page</p></footer>"*/
        
        
        return html
    }
    
    ////////////
    
    func createPDF(html: String, formmatter: UIViewPrintFormatter, filename: String) -> String {
        
        
        print("createPDF: \(html)")
        
        // 2. Assign print formatter to UIPrintPageRenderer
        let render = UIPrintPageRenderer()
        render.addPrintFormatter(formmatter, startingAtPageAt: 0)
        
        // 3. Assign paperRect and printableRect
        let page = CGRect(x: 0, y: 0, width: 595.2, height: 841.8) // A4, 72 dpi
        let printable = page.insetBy(dx: 0, dy: 0)
        
        render.setValue(NSValue(cgRect: page), forKey: "paperRect")
        render.setValue(NSValue(cgRect: printable), forKey: "printableRect")
        
        // 4. Create PDF context and draw
        let pdfData = NSMutableData()
        UIGraphicsBeginPDFContextToData(pdfData, CGRect.zero, nil)
        
        for i in 1...render.numberOfPages {
            
            UIGraphicsBeginPDFPage();
            let bounds = UIGraphicsGetPDFContextBounds()
            render.drawPage(at: i - 1, in: bounds)
        }
        
        UIGraphicsEndPDFContext();
        
        // 5. Save PDF file
        let path = "\(NSTemporaryDirectory())\(filename).pdf"
        pdfData.write(toFile: path, atomically: true)
        print("open \(path)")
        
        return path
    }
    
}
