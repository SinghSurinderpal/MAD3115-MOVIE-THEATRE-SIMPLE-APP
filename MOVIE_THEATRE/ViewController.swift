//
//  ViewController.swift
//  MOVIE_THEATRE
//
//  Created by surinder pal singh sidhu on 2017-12-10.
//  Copyright © 2017 surinder pal singh sidhu. All rights reserved.
//

import UIKit
import CoreData
import CoreLocation
import MapKit
/*ViewController class that is child class of UIViewController,UINavigationControllerDelegate, UIImagePickerControllerDelegate and CLLocationManagerDelegate*/
class ViewController: UIViewController,UINavigationControllerDelegate, UIImagePickerControllerDelegate , CLLocationManagerDelegate{

    @IBOutlet weak var name: UITextField!   //outlet for textfield to to store name
    @IBOutlet weak var age: UITextField!  //outlet for textfield to store age
    @IBOutlet weak var address: UITextField!   //outlet for textfield to store address
    @IBOutlet weak var movie_name: UITextField!// //outlet for textfield to store name of movie
    @IBOutlet weak var cinema_name: UITextField!  // //outlet for textfield to store cinema_name
    
    @IBOutlet weak var current_location: UITextField! // //outlet for textfield to store latitude and longitude
   
    @IBOutlet weak var movie_description: UITextField! //outlet for textfield to store description
    
    
    @IBOutlet weak var imgPicked: UIImageView!  //outlet for imageview to store image
    var movie_data = [Movie_Data]()   //creating array of database
    var index = 0   //Integer variable for index of array
    let locationManager = CLLocationManager()   //Creating instance of CLLocationManager
    /*this method is called after view is loaded in memory*/
    override func viewDidLoad() {
        super.viewDidLoad()
        self.locationManager.requestAlwaysAuthorization() //setting location access to always
        
        // For use in foreground
        self.locationManager.requestWhenInUseAuthorization() //this method requests permission to use location services
        /*using if condition when location servies are enabled*/
        if CLLocationManager.locationServicesEnabled() {
            locationManager.delegate = self
            locationManager.desiredAccuracy = kCLLocationAccuracyNearestTenMeters
            locationManager.startUpdatingLocation()
        }
    }
    /*this method is called after detction of memory warning*/
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    /*learInputs method to clear input fields after adding data to database*/
    func clearInputs() {
        /*setting textfields to empty string*/
        name.text = ""
        age.text = ""
        address.text = ""
        movie_description.text = ""
        movie_name.text = ""
        cinema_name.text = ""
        imgPicked.image = nil
    }
    
    
   /*method to add record in database on clicking add button*/
    @IBAction func addRecord(_ sender: UIButton) {
        let data = Movie_Data(context : contxt)
        /*if condition is true when all fields are filled */
        if !name.text!.isEmpty && !age.text!.isEmpty && !address.text!.isEmpty && !movie_name.text!.isEmpty && !cinema_name.text!.isEmpty && !movie_description.text!.isEmpty{
            /*adding data of all input fields to database*/
            data.name = name.text
            data.age = age.text
            data.address = address.text
            data.movie_name = movie_name.text
            data.cinema_name = cinema_name.text
            data.movie_description = movie_description.text
            data.picture = UIImageJPEGRepresentation(imgPicked.image!, 1);
            data.current_location = current_location.text
            appDelegate.saveContext()  //calling saveContext method of appDelegates
            clearInputs()  //calling clearInputs method to clear input fields
    }
    }
    /*method to perform action on click of button to pick image from gallery*/
    @IBAction func pickImage(_ sender: UIButton) {
        let libPhoto = UIImagePickerController()
        libPhoto.delegate = self
        libPhoto.sourceType = UIImagePickerControllerSourceType.photoLibrary//setting source for image
        self.present(libPhoto, animated: true)
    }
    /*method to fetch image from local storage*/
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [String : Any]) {
        if let gotImgfrmLib = info[UIImagePickerControllerOriginalImage] as? UIImage {
        imgPicked.image = gotImgfrmLib
        }
        else {
            print("Error picking an image")
             }
        self.dismiss(animated: true, completion: nil)
    }
    /*method to go to other viewwcontroller on pressing button*/
    @IBAction func showRecords(_ sender: UIButton) {
         performSegue(withIdentifier: "segue", sender: self)
    }
    /*prepare method to set destination to send control*/
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        /*Creating instance of DisplayViewController*/
        let displayviewcont = segue.destination as! DisplayViewController
        //displayviewcont.data = movie_data
        }
    /*method to get latitude and longitude*/
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        current_location.text = "\(locations[0].coordinate.latitude),\(locations[0].coordinate.longitude)"
        //setting latitude and longitude to textfields
        }
    }
