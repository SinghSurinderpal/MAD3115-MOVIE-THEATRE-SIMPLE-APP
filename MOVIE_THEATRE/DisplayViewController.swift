//
//  DisplayViewController.swift
//  MOVIE_THEATRE
//
//  Created by surinder pal singh sidhu on 2017-12-10.
//  Copyright © 2017 surinder pal singh sidhu. All rights reserved.
//

import UIKit
import  CoreData
/*DisplayViewController class that is sub class of UIViewController and UINavigationControllerDelegate */
class DisplayViewController: UIViewController,UINavigationControllerDelegate {

    @IBOutlet weak var name: UILabel! //outlet for label to show name
    @IBOutlet weak var age: UILabel!  //outlet for label to show age
    @IBOutlet weak var address: UILabel!   //outlet for label to show address
    @IBOutlet weak var movie_name: UILabel! //outlet for label to show moviename
    @IBOutlet weak var cinema_name: UILabel!  //outlet for label to show name of theatre
    @IBOutlet weak var movie_description: UILabel!  //outlet for label to show description
    
    
    var currentlocation:String?  //variable to store location
    @IBOutlet weak var imgPicked: UIImageView!  ////outlet for label to show image
    var data  = [Movie_Data]()  //creating array for database
    
  
    var indx = 0  //variable for array index
    /*method is called after view is loaded in memory*/
    override func viewDidLoad() {
        super.viewDidLoad()
        showData()  //calling showData method
    }
    /*method is called after detecting memory warning*/
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning() //calling method of super class
    }
    /*method to show data from database to labels*/
    func showData()
    {
      data = try! contxt.fetch(Movie_Data.fetchRequest())  //request for fetching data
        if data.count > indx {
        let data1 = data[indx]  //variable to store array element at index 0
        name.text = "Name- "+data1.name!  //getting name from database to label
        currentlocation = data1.current_location //getting location from database to label
        age.text = "Age- "+data1.age!+"years"  //getting age from database to label
        address.text = "Address- "+data1.address!//getting address from database to label
        movie_name.text = "Name of Movie- "+data1.movie_name!//getting location from database to label
        cinema_name.text = "Theatre- "+data1.cinema_name! //getting theatre name from database to label
        movie_description.text = "Review- "+data1.movie_description! //getting description from database to label
        imgPicked.image = UIImage(data:data1.picture!)  //setting image of imageview
        indx = indx + 1
        }
    }
    /*method perform action on clicking button to fetch next record*/
    @IBAction func showNextRecors(_ sender: UIButton) {
        data = try! contxt.fetch(Movie_Data.fetchRequest())
        if data.count > indx {
            let data1 = data[indx] //getting array element at specific index
            name.text = "Name- "+data1.name!  //getting name from database to label
            currentlocation = data1.current_location //getting location from database to label
            age.text = "Age- "+data1.age!+"years"  //getting age from database to label
            address.text = "Address- "+data1.address!//getting address from database to label
            movie_name.text = "Name of Movie- "+data1.movie_name!//getting location from database to label
            cinema_name.text = "Theatre- "+data1.cinema_name! //getting theatre name from database to label
            movie_description.text = "Review- "+data1.movie_description! //getting description from database to label
            imgPicked.image = UIImage(data:data1.picture!)  //setting image of imageview
            indx = indx + 1  //incrementing index
            if indx >= data.count {
            indx = 0
            }
            }
    }
    /*method to go to another viewcontroller*/
    @IBAction func showMap(_ sender: UIButton) {
        performSegue(withIdentifier: "segue1", sender: self) //passing segue
        }
    /*prepare method to send values to another controller*/
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "segue1"{
        let mapviewcontroller = segue.destination as! MapViewController //creating instance of MapViewController
        mapviewcontroller.current_location = currentlocation //updating variable of receiving class
        }
    }
}


