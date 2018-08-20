//
//  ViewControlle/Users/HolySquidz/Desktop/Report/Reportr.swift
//  Report
//
//  Created by Nicholas Edward Barnhart on 10/23/16.
//  Copyright © 2016 Nicholas Edward Barnhart. All rights reserved.
//

import UIKit
import MessageUI
import os.log


class ViewController: UIViewController, DocumentOperations, UITextFieldDelegate, UIImagePickerControllerDelegate, UINavigationControllerDelegate, MFMailComposeViewControllerDelegate, UITextViewDelegate{
    
    var report: Reports? //##########
    
    //Photo Items
    @IBOutlet weak var photoImageViewer1: UIImageView!
    @IBOutlet weak var photoImageViewer2: UIImageView!
    @IBOutlet weak var photoImageViewer3: UIImageView!
    
    var recentImage: UIImageView?
    
    //Email Recipient Items
    @IBOutlet weak var mailRecipient: UITextField!
    @IBOutlet weak var CCRecipient: UITextField!

    //Text Field Items
    @IBOutlet weak var teamIdentifier: UITextField!
    @IBOutlet weak var location: UITextField!
    @IBOutlet weak var dateOf: UITextField!
    @IBOutlet weak var Observation: UITextView!
    @IBOutlet weak var Action: UITextView!
    @IBOutlet weak var Impact: UITextView!
    @IBOutlet weak var workerCount: UITextField?
    @IBOutlet weak var descriptionBox: UITextView!
    @IBOutlet weak var day: UITextField!
    
    //Misc Items
    @IBOutlet weak var emailSender: UIButton!
    @IBOutlet weak var pdfNet: UIWebView!
    @IBOutlet weak var saveButton: UIBarButtonItem!
    @IBOutlet weak var updateWeek: UIBarButtonItem!
    @IBOutlet weak var createPDF: UIButton!
    
    
    //Photo Edit BUttons
    @IBOutlet weak var orientationButton1: UILabel!
    @IBOutlet weak var orientationButton2: UILabel!
    @IBOutlet weak var orientationButton3: UILabel!
    @IBOutlet weak var photoCount: UIButton!
    @IBOutlet weak var photoDecrease: UIButton!

    
    
    
    //Background Items
    @IBOutlet weak var backgroundItem1: UIView!
    @IBOutlet weak var backgroundItem2: UIView!
    @IBOutlet weak var backgroundItem3: UIView!
    @IBOutlet weak var backgroundItem4: UIView!
    
    
    //Section Labels
    @IBOutlet weak var basicInfo: UILabel!
    @IBOutlet weak var sectionOne: UILabel!
    @IBOutlet weak var sectionTwo: UILabel!
    @IBOutlet weak var actualSectionThree: UILabel!
    @IBOutlet weak var sectionThree: UILabel!
    @IBOutlet weak var sectionFour: UILabel!
    
    
    //Variables
    var teamNet: String?
    var siteNet: String?
    var dayCountNet: String?
    var weekChange = false
    var row = -1
    var weekRow = -1
    var photoAmount1 = 1
    var photoSelctor = 0
    var recordCreated = false
    var camActive = false
    var reportItem: weekChildReport?
    var weekReports = [weekChildReport]()
    var previousView: ReportsTableViewController?
    var teamCatcher: String?
    var weekCatcher: String?
    
    
    //Beginning

    override func viewDidLoad() { //Setting Delegates and calling functions to set borders
        super.viewDidLoad()
        
        teamIdentifier?.text = teamNet
        location?.text = siteNet
        descriptionBox?.delegate = self
        day.delegate = self
        
        mailRecipient?.delegate = self
        CCRecipient?.delegate = self
        teamIdentifier?.delegate = self
        location?.delegate = self
        dateOf?.delegate = self
        Action?.delegate = self
        Impact?.delegate = self
        Observation?.delegate = self
        workerCount?.delegate = self
        
        
        photoImageViewer2.alpha = 0
        photoImageViewer2.isUserInteractionEnabled = false
        
        photoImageViewer3.alpha = 0
        photoImageViewer3.isUserInteractionEnabled = false
        
        
        setBorders()
        updateSaveButtonState()
        
        //Load Information
        if let report = report{
            teamIdentifier.text = report.team
            descriptionBox.text = report.description1
            day.text = report.day
            location.text = report.location
            dateOf.text = report.date
            Observation?.text = report.observation
            Impact?.text = report.impact
            Action?.text = report.action
            workerCount?.text = report.workers
            orientationButton1.text = report.orientation1
            orientationButton2.text = report.orientation2
            orientationButton3.text = report.orientation3

            
            let x: Int? = Int(report.counter1)
            
            photoAmount1 = x!
            
            let imageData1 = UIImageJPEGRepresentation(report.photo!, 0)
            let imageData2 = UIImageJPEGRepresentation(report.photo2!, 0)
            let imageData3 = UIImageJPEGRepresentation(report.photo3!, 0)
            
            let data1 = UIImage(data: imageData1!)
            let data2 = UIImage(data: imageData2!)
            let data3 = UIImage(data: imageData3!)
            
            photoImageViewer1.image = data1
            photoImageViewer2.image = data2
            photoImageViewer3.image = data3

            
            
            if(photoAmount1 == 2){
                photoImageViewer2.alpha = 1
                photoImageViewer2.isUserInteractionEnabled = true
            }
            
            if(photoAmount1 == 3){
                photoImageViewer2.alpha = 1
                photoImageViewer2.isUserInteractionEnabled = true
                
                photoImageViewer3.alpha = 1
                photoImageViewer3.isUserInteractionEnabled = true
            }
            
            

            
        }
        
        //Disable Inputs during Record Selection
        if(weekChange){
        navigationItem.rightBarButtonItems = [updateWeek]
            teamIdentifier.isEnabled = false
            dateOf.isEnabled = false
            day.isEnabled = false
            location.isEnabled = false
            workerCount?.isEnabled = false
            mailRecipient.isEnabled = false
            CCRecipient.isEnabled = false
            
        }
        
        else{
            navigationItem.rightBarButtonItems = [saveButton]
        }
        
        
        
    }
    
    

    
    func setBorders() //Sets borders for objects
    {
        backgroundItem1.layer.borderColor = UIColor.orange.cgColor
        backgroundItem1.layer.borderWidth = 1.0
        backgroundItem1.layer.cornerRadius = 5.0
        
        backgroundItem2.layer.borderColor = UIColor.blue.cgColor
        backgroundItem2.layer.borderWidth = 1.0
        backgroundItem2.layer.cornerRadius = 5.0
        
        backgroundItem3.layer.borderColor = UIColor.orange.cgColor
        backgroundItem3.layer.borderWidth = 1.0
        backgroundItem3.layer.cornerRadius = 5.0
        
        backgroundItem4.layer.borderColor = UIColor.blue.cgColor
        backgroundItem4.layer.borderWidth = 1.0
        backgroundItem4.layer.cornerRadius = 5.0
        
        
        
        
        
        sectionThree.layer.borderColor = UIColor.black.cgColor
        sectionThree.layer.borderWidth = 1.0
        sectionThree.layer.cornerRadius = 5.0
        
        sectionFour.layer.borderColor = UIColor.black.cgColor
        sectionFour.layer.borderWidth = 1.0
        sectionFour.layer.cornerRadius = 5.0
        
        photoImageViewer1.layer.borderWidth = 3.0
        photoImageViewer1.layer.cornerRadius = 5.0
        
        photoImageViewer2.layer.borderWidth = 3.0
        photoImageViewer2.layer.cornerRadius = 5.0
        photoImageViewer2.layer.backgroundColor = UIColor.white.cgColor

        
        photoImageViewer3.layer.borderWidth = 3.0
        photoImageViewer3.layer.cornerRadius = 5.0
        photoImageViewer3.layer.backgroundColor = UIColor.white.cgColor

        

        
        photoCount.layer.borderWidth = 1.0
        photoCount.layer.cornerRadius = 5.0
        
        photoDecrease.layer.borderWidth = 1.0
        photoDecrease.layer.cornerRadius = 5.0
        
        
        createPDF.layer.cornerRadius = 5.0
      
        descriptionBox.layer.backgroundColor = UIColor.white.cgColor
        descriptionBox.layer.borderWidth = 1.0
        descriptionBox.layer.cornerRadius = 5.0
        
        
        orientationButton1.layer.borderColor = UIColor.blue.cgColor
        orientationButton1.layer.borderWidth = 1.0
        orientationButton1.layer.cornerRadius = 5.0
        orientationButton1.textColor = UIColor.blue
        
        orientationButton2.layer.borderColor = UIColor.blue.cgColor
        orientationButton2.layer.borderWidth = 1.0
        orientationButton2.layer.cornerRadius = 5.0
        orientationButton2.textColor = UIColor.blue
        
        orientationButton3.layer.borderColor = UIColor.blue.cgColor
        orientationButton3.layer.borderWidth = 1.0
        orientationButton3.layer.cornerRadius = 5.0
        orientationButton3.textColor = UIColor.blue
        
        descriptionBox.layer.borderColor = UIColor.blue.cgColor
        descriptionBox.layer.borderWidth = 1.0
        descriptionBox.layer.cornerRadius = 5.0


        
        

        
        
    }
    
    //Orientation Factors
    @IBAction func changeOrientation1(_ sender: Any) {
        
        if(orientationButton1.text == "Portrait"){
            orientationButton1.text = "Landscape"
        }
        
        else{
            orientationButton1.text = "Portrait"
        }
    }
    
    @IBAction func changeOrientation2(_ sender: Any) {
        
        if(orientationButton2.text == "Portrait"){
            orientationButton2.text = "Landscape"
        }
            
        else{
            orientationButton2.text = "Portrait"
        }
    }
    
    @IBAction func changeOrientation3(_ sender: Any) {
        
        if(orientationButton3.text == "Portrait"){
            orientationButton3.text = "Landscape"
        }
            
        else{
            orientationButton3.text = "Portrait"
        }
    }
    
    
    
    //Nothing
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        navigationController?.popToRootViewController(animated: true)
    }
    
    
    //Change amount of images +
    @IBAction func photoCounter(_ sender: Any) {
        
        if(photoAmount1 != 3){
            photoAmount1 = photoAmount1 + 1
        }
        
        
        if(photoAmount1 == 2)
        {
            photoImageViewer2.alpha = 1.00
            photoImageViewer2.isUserInteractionEnabled = true
        }
        
        if(photoAmount1 == 3)
        {
            photoImageViewer3.alpha = 1
            photoImageViewer3.isUserInteractionEnabled = true
        }
    }
    
    

    
    
    
    
    //Subtract Images
    @IBAction func photoDeduct(_ sender: Any) {
        
        if(photoAmount1 != 1){
            photoAmount1 = photoAmount1 - 1
        }
        
        if(photoAmount1 == 1)
        {
            photoImageViewer2.alpha = 0
            photoImageViewer2.isUserInteractionEnabled = false
        }
        
        
        if(photoAmount1 == 2)
        {
            photoImageViewer3.alpha = 0
            photoImageViewer3.isUserInteractionEnabled = false
        }
        
    }
    
    
    
    
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool { //Resigns Keyboard
        // Hide the keyboard.
        textField.resignFirstResponder()
        
        return true
    }
    
    func textFieldDidEndEditing(_ textField: UITextField) {
        updateSaveButtonState()
        //navigationItem.title = dateOf.text
    }
    
    func textViewDidEndEditing(_ textField: UITextView) {
        updateSaveButtonState()
        //navigationItem.title = dateOf.text
    }
    
    
    func textView(_ textView: UITextView, shouldChangeTextIn range: NSRange, replacementText text: String) -> Bool {
        if(text == "\n") {
            textView.resignFirstResponder()
            return false
        }
        return true
    }
    
    
    
    
    
    func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
        // Dismiss the picker if the user canceled.
        dismiss(animated: true, completion: nil)
    }
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [String : Any]) {
        // The info dictionary contains multiple representations of the image, and this uses the original.
        let selectedImage = info[UIImagePickerControllerOriginalImage] as! UIImage
        
        // Set photoImageView to display the selected image from library.
        if(photoSelctor == 1)
        {
            recentImage = photoImageViewer1

            photoImageViewer1?.image = selectedImage
            if(camActive){
                camActive = false
                saveImage()
            }
        }
        
        if(photoSelctor == 2)
        {
            recentImage = photoImageViewer3

            photoImageViewer3?.image = selectedImage
            if(camActive){
                camActive = false
                saveImage()
            }
        }
        
        if(photoSelctor == 3)
        {
            recentImage = photoImageViewer2

            photoImageViewer2?.image = selectedImage
            if(camActive){
                camActive = false
                saveImage()
            }
        }
        
        
        // Dismiss the picker.
        dismiss(animated: true, completion: nil)
    }
    
    //Handling actions to move to library or camera
    @IBAction func photoImageTapped(_ sender: UITapGestureRecognizer) {
        
        recentImage = photoImageViewer1
        photoSelctor = 1

        
        let alertController = UIAlertController(title: "Access Photo Library or Camera?", message: "", preferredStyle: UIAlertControllerStyle.alert)
        
        let accept = UIAlertAction(title: "Photo Library", style: UIAlertActionStyle.default){
            (result: UIAlertAction) in self.showPhoto()
            
            
        }
        let deny = UIAlertAction(title: "Camera", style: UIAlertActionStyle.destructive){
            (result: UIAlertAction) in self.accessCameraTapped()
        }
        
        alertController.addAction(accept)
        alertController.addAction(deny)
        
        
        self.present(alertController, animated: true, completion: nil)
    }
    
    func showPhoto()
    {
        // Hide the keyboard.
        //nameTextField.resignFirstResponder()
        
        photoSelctor = 1
        
        // UIImagePickerController is a view controller that lets a user pick media from their photo library.
        let imagePickerController = UIImagePickerController()
        
        // Only allow photos to be picked, not taken.
        imagePickerController.sourceType = .photoLibrary
        
        // Make sure ViewController is notified when the user picks an image.
        imagePickerController.delegate = self
        
        present(imagePickerController, animated: true, completion: nil)
    }
    
    @IBAction func photoImagedTapped2(_ sender: UITapGestureRecognizer) {
        
        recentImage = photoImageViewer2
        photoSelctor = 2

        
        let alertController = UIAlertController(title: "Access Photo Library or Camera?", message: "", preferredStyle: UIAlertControllerStyle.alert)
        
        let accept = UIAlertAction(title: "Photo Library", style: UIAlertActionStyle.default){
            (result: UIAlertAction) in self.showPhoto2()
            
            
        }
        let deny = UIAlertAction(title: "Camera", style: UIAlertActionStyle.destructive){
            (result: UIAlertAction) in self.accessCameraTapped()
        }
        
        alertController.addAction(accept)
        alertController.addAction(deny)
        
        
        self.present(alertController, animated: true, completion: nil)
    }
    
    func showPhoto2(){
        // Hide the keyboard.
        //nameTextField.resignFirstResponder()
        
        photoSelctor = 2
        
        // UIImagePickerController is a view controller that lets a user pick media from their photo library.
        let imagePickerController = UIImagePickerController()
        
        // Only allow photos to be picked, not taken.
        imagePickerController.sourceType = .photoLibrary
        
        // Make sure ViewController is notified when the user picks an image.
        imagePickerController.delegate = self
        
        present(imagePickerController, animated: true, completion: nil)
    }
    
    
    @IBAction func photoImageTapped3(_ sender: UITapGestureRecognizer) {
        
        recentImage = photoImageViewer3
        photoSelctor = 3

        
        let alertController = UIAlertController(title: "Access Photo Library or Camera?", message: "", preferredStyle: UIAlertControllerStyle.alert)
        
        let accept = UIAlertAction(title: "Photo Library", style: UIAlertActionStyle.default){
            (result: UIAlertAction) in self.showPhoto3()
            
            
        }
        let deny = UIAlertAction(title: "Camera", style: UIAlertActionStyle.destructive){
            (result: UIAlertAction) in self.accessCameraTapped()
        }
        
        alertController.addAction(accept)
        alertController.addAction(deny)
        
        
        self.present(alertController, animated: true, completion: nil)
    }
    
    
    func showPhoto3()
    {
        
        photoSelctor = 3
        
        // UIImagePickerController is a view controller that lets a user pick media from their photo library.
        let imagePickerController = UIImagePickerController()
        
        // Only allow photos to be picked, not taken.
        imagePickerController.sourceType = .photoLibrary
        
        // Make sure ViewController is notified when the user picks an image.
        imagePickerController.delegate = self
        
        present(imagePickerController, animated: true, completion: nil)
        
    }
    
    
    func accessCameraTapped() { //Recognize access to phone camera
        
        camActive = true
        if UIImagePickerController.isSourceTypeAvailable(UIImagePickerControllerSourceType.camera) {
            let imagePicker = UIImagePickerController()
            
            imagePicker.delegate = self
            imagePicker.sourceType = UIImagePickerControllerSourceType.camera;
            imagePicker.allowsEditing = false
            
            
            self.present(imagePicker, animated: true, completion: nil)
            
        }
    }
    
    
     func saveImage() { //Takes UIImage recently accessed and stores photo into library
        let imageData = UIImageJPEGRepresentation((recentImage?.image!)!, 0.6)
        let compressedJPGImage = UIImage(data: imageData!)
        UIImageWriteToSavedPhotosAlbum(compressedJPGImage!, nil, nil, nil)
        
        //sendAlertImageSaved()// Call function to send alert
        
    }
    
    func sendAlertImageSaved(){//Sends Alert
        let alertController = UIAlertController(title: "Image Saved to Photo Library", message: "", preferredStyle: UIAlertControllerStyle.alert)
        let pdfAccept = UIAlertAction(title: "OK", style: UIAlertActionStyle.default){
            (result: UIAlertAction) -> Void in}
        
        alertController.addAction(pdfAccept)
        self.present(alertController, animated: true, completion: nil)
        
    }
    
  
    
    
    @IBAction func emailSender(_ sender: Any) { //Checks if record has been created or not before email
        
        if(recordCreated == true){//Checks if a record has been created in the current page session
            verifiedFileCreated()
        }
        
        else{
            createRecordError() //Send error
        }
        
            
    }
    
    func verifiedFileCreated() //Prepare information and open email client
    {
        let mailObject = configuredMailComposeViewController()

        
        if MFMailComposeViewController.canSendMail(){
            self.present(mailObject, animated: true, completion: nil)
        }
        else{
            self.sendShowErrorReport()
        }
        
        
       

    }
    
    func createRecordError(){
        let alertController = UIAlertController(title: "Error:", message: "A record has not been created for the current session.", preferredStyle: UIAlertControllerStyle.alert)
        let pdfAccept = UIAlertAction(title: "OK", style: UIAlertActionStyle.default){
            (result: UIAlertAction) -> Void in}
        
        alertController.addAction(pdfAccept)
        self.present(alertController, animated: true, completion: nil)
        
    }

 
    //Open email client and insert information and attach document.
    func configuredMailComposeViewController() -> MFMailComposeViewController{
        let mailControllerVC = MFMailComposeViewController()
        mailControllerVC.mailComposeDelegate = self
        
        mailControllerVC.setToRecipients(["\(mailRecipient.text!)"])
        mailControllerVC.setCcRecipients(["\(CCRecipient.text!)"])
        mailControllerVC.setSubject("\(teamIdentifier.text!) : Daily Report at \(location.text!), \(dateOf.text!)")
        
        let path = "\(NSTemporaryDirectory())DailyReport.pdf"
        
        let newData = NSData(contentsOfFile: path)
                
        mailControllerVC.addAttachmentData(newData! as Data, mimeType: "application/pdf", fileName: "\(teamIdentifier.text!)_DailyReport_\(dateOf.text!)")
        
        
        
        return mailControllerVC
        
    }
    
    func sendShowErrorReport(){
        let alertController = UIAlertController(title: "Destruction", message: "Error Catch", preferredStyle: UIAlertControllerStyle.alert)
        let destructiveAction = UIAlertAction(title: "Destructive", style: UIAlertActionStyle.destructive) { (result: UIAlertAction) -> Void in
            print("Destructive")
        }
        let okAction = UIAlertAction(title: "OK", style: UIAlertActionStyle.default) { (result: UIAlertAction) -> Void in
            print("OK")
        }
        alertController.addAction(destructiveAction)
        alertController.addAction(okAction)
        self.present(alertController, animated: true, completion: nil)
        
    }
    
    func sendAlertPDFCreated(){
        let alertController = UIAlertController(title: "Daily Report PDF Created", message: "", preferredStyle: UIAlertControllerStyle.alert)
        let pdfAccept = UIAlertAction(title: "OK", style: UIAlertActionStyle.default){
            (result: UIAlertAction) -> Void in}
    
        alertController.addAction(pdfAccept)
        self.present(alertController, animated: true, completion: nil)
    
    }
    
    //Alert: Not Important
    func sendAlertPDFViewable(){
        let alertController = UIAlertController(title: "Report View Created", message: "", preferredStyle: UIAlertControllerStyle.alert)
        let pdfAccept = UIAlertAction(title: "OK", style: UIAlertActionStyle.default){
            (result: UIAlertAction) -> Void in}
        
        alertController.addAction(pdfAccept)
        self.present(alertController, animated: true, completion: nil)
        
    }
    
    @IBAction func toolTipCreate(_ sender: Any) { //Button to send alert for tooltips.
        createRecordTT()
    }
    
    //Tool Tip: Not Important
    func createRecordTT(){
        let alertController = UIAlertController(title: "Tip:", message: "The Create Record button will generate your report and store it on your phone.", preferredStyle: UIAlertControllerStyle.alert)
        let pdfAccept = UIAlertAction(title: "OK", style: UIAlertActionStyle.default){
            (result: UIAlertAction) -> Void in}
        
        alertController.addAction(pdfAccept)
        self.present(alertController, animated: true, completion: nil)
        
    }
   
    @IBAction func toolTipEmail(_ sender: Any) {
        sendEmailTT()
    }
    
    //Email Tool Tip: Not Important
    func sendEmailTT(){
        let alertController = UIAlertController(title: "Tip:", message: "The Send Email button will attach the information you've input to an email, along with your report.", preferredStyle: UIAlertControllerStyle.alert)
        let pdfAccept = UIAlertAction(title: "OK", style: UIAlertActionStyle.default){
            (result: UIAlertAction) -> Void in}
        
        alertController.addAction(pdfAccept)
        self.present(alertController, animated: true, completion: nil)
        
    }
    
    
    //Not Important
    @IBAction func toolTipS1(_ sender: Any) {
        sectionOneTT()
    }
    
    //Not Important
    func sectionOneTT(){
        let alertController = UIAlertController(title: "Tip:", message: "Add photos to be included in the daily report. You can either add photos through your camera or your photo libary; If you've used your camera to add a photo you can keep it by tapping the 'Save Photo' button. The 'Add Photo' button will add or subtract the extra photo at interaction.", preferredStyle: UIAlertControllerStyle.alert)
        let pdfAccept = UIAlertAction(title: "OK", style: UIAlertActionStyle.default){
            (result: UIAlertAction) -> Void in}
        
        alertController.addAction(pdfAccept)
        self.present(alertController, animated: true, completion: nil)
        
    }
    //Not Important
    @IBAction func toolTipS2(_ sender: Any) {
        sectionTwoTT()
    }
    
    //Not Important
    func sectionTwoTT(){
        let alertController = UIAlertController(title: "Section Two:", message: "Here you enter the information that needs to be present on the report, if you want to enter multiple locations just add a comma between the sites. The 'Holiday' Button will automatically fill out the fields with default information to placehold for public holidays.", preferredStyle: UIAlertControllerStyle.alert)
        let pdfAccept = UIAlertAction(title: "OK", style: UIAlertActionStyle.default){
            (result: UIAlertAction) -> Void in}
        
        alertController.addAction(pdfAccept)
        self.present(alertController, animated: true, completion: nil)
        
    }
    
    //Not Important
    @IBAction func toolTipS3(_ sender: Any) {
        sectionThreeTT()
    }
    
    //Not Important
    func sectionThreeTT(){
        let alertController = UIAlertController(title: "Section Three:", message: "This section shows your Daily Report if you've tapped 'Create PDF.", preferredStyle: UIAlertControllerStyle.alert)
        let pdfAccept = UIAlertAction(title: "OK", style: UIAlertActionStyle.default){
            (result: UIAlertAction) -> Void in}
        
        alertController.addAction(pdfAccept)
        self.present(alertController, animated: true, completion: nil)
        
    }
    
    //Not Important
    @IBAction func toolTipS4(_ sender: Any) {
        sectionFourTT()
    }
    
    //Not Important
    func sectionFourTT(){
        let alertController = UIAlertController(title: "Final Section:", message: "In this section you can fill out the intended recipients, open and prepare an email to send with the 'Send Email' button.", preferredStyle: UIAlertControllerStyle.alert)
        let pdfAccept = UIAlertAction(title: "OK", style: UIAlertActionStyle.default){
            (result: UIAlertAction) -> Void in}
        
        alertController.addAction(pdfAccept)
        self.present(alertController, animated: true, completion: nil)
        
    }
    
    func mailComposeController(_ controller: MFMailComposeViewController, didFinishWith result: MFMailComposeResult, error: Error?) {
        controller.dismiss(animated: true, completion: nil)
    }
    
    //Important : Prevents PDF Generation if lack of Info
    @IBAction func genPDFTapped(_ sender: Any) {
        
        if((teamIdentifier.text == "") || (location.text == "") || (dateOf.text == "") || (workerCount?.text == "")){
            
            sendAlertNeedInfo()
            
        }
        
        else{
            recordCreated = true
            
            saveImage(image: photoImageViewer1.image)
            if(photoAmount1 == 2){
                saveImage1(image: photoImageViewer2.image)
                
            }
            
            if (photoAmount1 == 3)
            {
                saveImage1(image: photoImageViewer2.image)
                saveImage2(image: photoImageViewer3.image)
            }
            
            
            sendAlertPDFCreated()
            loadPDFView()
        }
    }
    
    
    func sendAlertNeedInfo(){
        let alertController = UIAlertController(title: "Tip:", message: "Please fill out the team and date data fields and the first location and worker count.", preferredStyle: UIAlertControllerStyle.alert)
        let pdfAccept = UIAlertAction(title: "OK", style: UIAlertActionStyle.default){
            (result: UIAlertAction) -> Void in}
        
        alertController.addAction(pdfAccept)
        self.present(alertController, animated: true, completion: nil)
        
    }
    
    
    //Important : Loads document into preview
    func loadPDF(filename: String) {
        
        let documentsPath = NSSearchPathForDirectoriesInDomains(.documentDirectory, .userDomainMask, true)[0]
       let filePath = "\(documentsPath)/\(filename).pdf"
        let url = NSURL(fileURLWithPath: filePath)
        let urlRequest = NSURLRequest(url: url as URL)
        pdfNet.loadRequest(urlRequest as URLRequest)
        
        }
    
    //Returning a filepath
    func getDocumentsDirectory() -> URL{
        let paths = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask)
        let documentsDirectory = paths[0]
        return documentsDirectory
    }
    
    
    func saveImage(image: UIImage!) //Writes a UIImage's source to file
    {
        
        let pngImageData  = UIImageJPEGRepresentation(image, 0.25)
        
        let filename = getDocumentsDirectory().appendingPathComponent("copy.png")
        
        try? pngImageData!.write(to: filename)
        
    }
    
    func saveImage1(image: UIImage!)
    {
        
        let pngImageData  = UIImageJPEGRepresentation(image, 0.25)
        
        let filename = getDocumentsDirectory().appendingPathComponent("copy1.png")
        
        try? pngImageData!.write(to: filename)
        
    }
    
    func saveImage2(image: UIImage!)
    {
        
        let pngImageData  = UIImageJPEGRepresentation(image, 0.25)
        
        let filename = getDocumentsDirectory().appendingPathComponent("copy2.png")
        
        try? pngImageData!.write(to: filename)
        
    }
    
    
 
    
    func loadPDFView() { //
        pdfNet.delegate = self as UIWebViewDelegate
        //pdfNet.alpha = 0
        
        if let html = prepareHTML() {
            print("html document:\(html)")
            pdfNet.loadHTMLString(html, baseURL: nil)
            
        }
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
    }
    
    fileprivate func prepareHTML() -> String? {
        
        // Create Your Image tags here
        let tags = imageTags(filenames: ["copy.png","copy1.png","copy2.png"], settings: [orientationButton1.text!, orientationButton2.text!, orientationButton3.text!])
        var html: String?
        
        // html
        let url = getDocumentsDirectory()
            
            // Images are stored in the app bundle under the 'www' directory
        html = generateHTMLString(imageTags: tags, baseURL: url.absoluteString, action: Action!.text!, observation: Observation!.text!, impact: Impact!.text!, location: (location?.text!)!, workers: (workerCount?.text!)!, date: (dateOf?.text)!, imageAmount: photoAmount1)
        
        return html
    }
    
    
   
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
    
        super.prepare(for: segue, sender: sender)
    
        if(weekChange){
            let destinationVC: WeekTableViewController = segue.destination as! WeekTableViewController
            
            if(teamCatcher != nil){
                destinationVC.teamPlaceholder = teamCatcher!

            }
            
            if(weekCatcher != nil){
                destinationVC.weekBox.text = weekCatcher

            }
            
            let x = String(photoAmount1)
            
            let imageData1 = UIImageJPEGRepresentation(photoImageViewer1.image!, 0)
            let imageData2 = UIImageJPEGRepresentation(photoImageViewer2.image!, 0)
            let imageData3 = UIImageJPEGRepresentation(photoImageViewer3.image!, 0)
            
            let data1 = UIImage(data: imageData1!)
            let data2 = UIImage(data: imageData2!)
            let data3 = UIImage(data: imageData3!)


            
            reportItem = weekChildReport(date: dateOf.text!, location: location.text!, worker: (workerCount?.text!)!, description1:descriptionBox.text!, day:day.text!, image1: data1!, image2: data2!, image3: data3!, imageCount: x, orientation1: orientationButton1.text!, orientation2: orientationButton2.text!, orientation3: orientationButton3.text!, observation: (Observation?.text)!, action: (Action?.text!)!, impact: (Impact?.text)!)
            
            if(row == -1){
                weekReports.append(reportItem!)
            }
            
            else{
                weekReports[row] = reportItem!
            }
            
            destinationVC.reports = weekReports
            destinationVC.weekListRow = weekRow
            
        }
        
        else{
        
        guard let button = sender as? UIBarButtonItem, button == saveButton else {
            os_log("The save button was not pressed, cancelling", log: OSLog.default, type: .debug)
            
            return
        }
        
        let description1 = descriptionBox.text
        let dayItem = day.text
        let team = teamIdentifier.text
        let date = dateOf.text
        let site = location.text
        let obsv = Observation?.text
        let imp = Impact?.text
        let act = Action?.text
        let work = workerCount?.text
        let count1 = String(photoAmount1)
            
        let imageData1 = UIImageJPEGRepresentation(photoImageViewer1.image!, 0)
        let imageData2 = UIImageJPEGRepresentation(photoImageViewer2.image!, 0)
        let imageData3 = UIImageJPEGRepresentation(photoImageViewer3.image!, 0)
        
        let data1 = UIImage(data: imageData1!)
        let data2 = UIImage(data: imageData2!)
        let data3 = UIImage(data: imageData3!)
            
        
            report = Reports(team: team!, date: date!, location: site!, observation: obsv!, action: act!, impact: imp!, workers: work!, photo: data1, photo2: data2, photo3: data3, counter1: count1, description1: description1!, day: dayItem!, orientation1: orientationButton1.text!, orientation2: orientationButton2.text!, orientation3: orientationButton3.text!)
        }
    
        
    
        
    }
    
    func textFieldDidBeginEditing(_ textField: UITextField) {
        // Disable the Save button while editing.
        saveButton.isEnabled = false
    }
    
    private func updateSaveButtonState(){
        let text = teamIdentifier.text ?? ""
        let datey = dateOf.text ?? ""
        saveButton.isEnabled = !text.isEmpty && !datey.isEmpty
        
    }
    
    
    @IBAction func Cancel(_ sender: UIBarButtonItem) {
        
        let isPresentingInAddReportMode = presentingViewController is UINavigationController
        
        if isPresentingInAddReportMode{
            dismiss(animated: true, completion: nil)

        }
        else if let owningNavigationController = navigationController {
            owningNavigationController.popViewController(animated: true)
        }
        
        else {
            fatalError("The ReportViewController is not inside a navigaton controller.")
        }
        
    }
    
    
    
}


extension ViewController: UIWebViewDelegate {
    
    func webViewDidFinishLoad(_ webView: UIWebView) {
        if let content = prepareHTML() {
            let path = createPDF(html: content, formmatter: webView.viewPrintFormatter(), filename: "DailyReport")
            print("PDF location: \(path)")
        }
    }
}

extension UIImage{
    enum JPEGQuality: CGFloat{
        case lowest = 0
        case low = 0.25
        case medium = 0.5
        case high = 0.75
        case highest = 1
    }
    
    
    var pngData: Data? {
        return UIImagePNGRepresentation(self)
    }
    
    func jpegData(_ quality: JPEGQuality) -> Data? {
        return UIImageJPEGRepresentation(self, quality.rawValue)
    }
    
    
    
}

