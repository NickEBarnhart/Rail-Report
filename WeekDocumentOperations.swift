//
//  WeekDocumentOperations.swift
//  Report
//
//  Created by Nicholas Edward Barnhart on 12/19/16.
//  Copyright © 2016 Nicholas Edward Barnhart. All rights reserved.
//

import Foundation
import UIKit


protocol WeekDocumentOperations {
    
    // Takes your image tags and the base url and generates a html string
    func generateHTMLString(baseURL: String, week: String, team: String, reports: Array<weekChildReport>, ImageTags: [String]) -> String
    
    // Uses UIViewPrintFormatter to generate pdf and returns pdf location
    func createPDF(html: String, formmatter: UIViewPrintFormatter, filename: String) -> String
    
    func imageTags(reports: Array<weekChildReport>) -> [String]

    
}


extension WeekDocumentOperations  {
    
    
    func imageTags(reports: Array<weekChildReport>) -> [String] {
        
        var tags: [String] = []
        var imageString: String
        var stringEnd: Int = 0
        
        
        
        for b in reports{
            
            var pngImageData  = UIImageJPEGRepresentation(b.image1, 0.25)
            
            var filename = getDocumentsDirectory().appendingPathComponent("copy\(stringEnd).png")
            stringEnd += 1
            
            try? pngImageData!.write(to: filename)
            
             pngImageData  = UIImageJPEGRepresentation(b.image2, 0.25)
            
             filename = getDocumentsDirectory().appendingPathComponent("copy\(stringEnd).png")
            stringEnd += 1
            
            try? pngImageData!.write(to: filename)
            
            pngImageData  = UIImageJPEGRepresentation(b.image3, 0.25)
            
            filename = getDocumentsDirectory().appendingPathComponent("copy\(stringEnd).png")
            stringEnd += 1
            
            try? pngImageData!.write(to: filename)
            
            
            
            
            if(b.orientation1 == "Portrait"){
                imageString =   "<img src=\"copy\(stringEnd-3).png\" style='width:180px;height:230px;margin:5px;margin-left:100px'>"
                tags.append(imageString)
            }
            
            else{
                imageString =   "<img src=\"copy\(stringEnd-3).png\" style='width:270px;height:160px;margin:5px;margin-left:75px'>"
                tags.append(imageString)

                
            }
            
            if(b.orientation2 == "Portrait"){
                imageString =   "<img src=\"copy\(stringEnd-2).png\" style='width:180px;height:230px;margin:5px;margin-left:100px'>"
                tags.append(imageString)
            }
                
            else{
                imageString =   "<img src=\"copy\(stringEnd-2).png\" style='width:270px;height:160px;margin:5px;margin-left:75px'>"
                tags.append(imageString)
                
                
            }
            
            if(b.orientation3 == "Portrait"){
                imageString =   "<img src=\"copy\(stringEnd-1).png\" style='width:180px;height:230px;margin:5px;margin-left:100px'>"
                tags.append(imageString)
            }
                
            else{
                imageString =   "<img src=\"copy\(stringEnd-1).png\" style='width:270px;height:160px;margin:5px;margin-left:75px'>"
                tags.append(imageString)
                
                
            }
            
        }
        
        
        return tags
    }
    
    func getDocumentsDirectory() -> URL{ //Function to return a file path
        let paths = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask)
        let documentsDirectory = paths[0]
        return documentsDirectory
    }
    
    
    
    func generateHTMLString(baseURL: String, week: String, team: String, reports: Array<weekChildReport>, ImageTags: [String]) -> String {
        
        var imageCounter: Int = 0;
        var locationLister = [String]()
        
       
        for counter in reports{
            var checker: Bool = false
            print("location lister")
            print(locationLister.count)
            if(locationLister.count < 1){
               locationLister.append(counter.location)
            }
            
            for counter2 in locationLister{
                
                if(counter2 == counter.location){
                    checker = true
                }
                
                
            }
            
            if (!checker){
                locationLister.append(counter.location)
                
            }
            
        }
        
        
        var html = "<!DOCTYPE html><head><base href=\"\(baseURL)\"></head>\n<html>\n<body style='margin:100px;font-family:Arial'>\n"
        
        
        html = html + "<h1 style='font-family: colaborate, bold, sans-serif;color:#008C95;letter-spacing:-1px'>SIEMENS</h1> <hr> <h3> Weekly Site Inspection Records for : \(team)</h3> <p>Work Site(s) : "
        
        for catman in 0..<(locationLister.count-1){
            html = html + "\(locationLister[catman]), "
            
        }
        
        html = html + "\(locationLister[locationLister.count-1])"
        
        
        html = html + " </p> <p>Week No. : \(week)</p> <p> Date : \(reports[0].date) to \(reports[reports.count-1].date) </p> <p>Time : 09:00 to 18:00 </p>"
        
        
        html = html + "<table border='1' width='90%' style='height:400px;border-collapse: collapse;padding:5px;text-align:center;'> <tbody> <tr style='background-color:#f2f2f2'> <td>Day</td> <td>Date</td> <td>Location </td> <td>Description</td> <td> No. of Workers </td> </tr>"
        
        var kratos = false
        for counter in 0..<(reports.count){
        
            let calculon = counter%10
            print(calculon)
            
            if(calculon == 8){
                kratos = true
            }
            
            if(calculon == 8 && kratos){
               html = html + "</tbody> </table>  <table border='1' width='90%' style='height:400px;border-collapse: collapse;padding:5px;text-align:center;margin-top:700px '> <tbody> <tr style='background-color:#f2f2f2'> <td>Day</td> <td>Date</td> <td>Location </td> <td>Description</td> <td> No. of Workers </td> </tr>"
                
            }
            
            html = html + "<tr> <td>\(reports[counter].day)</td> <td>\(reports[counter].date)</td> <td> \(reports[counter].location)</td> <td style ='font-size: 50%;'>\(reports[counter].description1)</td> <td>\(reports[counter].worker)</td> </tr>"
            
            
        
        }
        
        var workerTotal: Int = 0
        for counter in 0..<(reports.count){
            let workerCount = reports[counter].worker
            
            if(Int(workerCount) ==  nil)
            {
                workerTotal = workerTotal + 0
            }
            
            else{
            workerTotal = workerTotal + Int(workerCount)!
            }
            
        }
        
        html = html + "</tbody> </table> <h3>Total Personnel: \(workerTotal) Workers</h3> \n"
        
        
        for b in reports{
        
            let x = Int(b.imageCount)
            print("Image Counter")
            print(imageCounter)
            
            html = html + "<h1 style='font-family: colaborate, bold, sans-serif;color:#008C95;letter-spacing:-1px;margin-top:700px'>SIEMENS</h1> <hr> <h3 style='margin:0px'>Site Photo</h3> <table border ='1' style='width:100%;border-collapse: collapse;padding:0px;margin-top:5%'> <tbody> <tr style='background-color:#f2f2f2;font-size:50%'> <td> "
            
            
            html = html + "<b>\(b.location) -- \(b.worker) Personnel"
        
        
        
        
            html = html + "</td><td><b style='margin-left:0px'>Date : \(b.date)</b> </td> </tr> <tr style=''> <td style='margin:0px;width:62%'>\(ImageTags[imageCounter]) </td>"
            
            imageCounter+=1
        
            
            
            if(x == 1){
                html = html + "<td rowspan='1' style='vertical-align:top'>"
            }
            if(x == 2){
                html = html + "<td rowspan='2' style='vertical-align:top'>"
            }
            if(x == 3){
                html = html + "<td rowspan='3' style='vertical-align:top'>"
            
            }
        
            html = html + "<p> <u> OBSERVATION:</u></p> <p>\(b.observation)</p>"
            html = html + "<p style='margin-top:10px'><u>ACTION:</u></p> <p>\(b.action)</p><p style='margin-top:10px'><u>IMPACT:</u></p> <p>\(b.impact)</p> </td> </tr>"
        
            if(x == 2){
                html = html + "<tr> <td>\(ImageTags[imageCounter])</td> </tr>"
                imageCounter+=2  

            }
        
            if(x == 3){
            
                html = html + "<tr> <td>\(ImageTags[imageCounter])</td></tr> <tr><td> \(ImageTags[imageCounter+1]) </td></tr>"
                imageCounter+=2

            }
            
            html = html + "</tbody> </table>"
            
    }

        
        
        
       html = html + "<footer style='margin-top:20%;background-color:#efefef;padding:0px'> <hr> <p style='text-align:center;'>End of Page</p></footer>"
        
        
        html = html + "</body>\n</html>\n"
        
        return html
    }
    
    
    func createPDF(html: String, formmatter: UIViewPrintFormatter, filename: String) -> String {
        // From: https://gist.github.com/nyg/b8cd742250826cb1471f
        
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
