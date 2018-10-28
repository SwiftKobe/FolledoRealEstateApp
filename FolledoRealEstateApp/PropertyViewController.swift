//
//  PropertyViewController.swift
//  FolledoRealEstateApp
//
//  Created by Samuel Folledo on 10/27/18.
//  Copyright © 2018 Samuel Folledo. All rights reserved.
//

import UIKit
import MapKit

class PropertyViewController: UIViewController { //RE ep.69 5mins fileis created
    
    var property: Property! //RE ep.72 4mins our property that has to have a value
    var propertyCoordinate: CLLocationCoordinate2D? //RE ep.72 4mins
    var imageArray: [UIImage] = [] //RE ep.72 7mins
    
    
    @IBOutlet weak var callBackButton: UIButton! //RE ep.71
    @IBOutlet weak var propertyTitleLabel: UILabel! //RE ep.71 nav's title label
    
    
    @IBOutlet weak var activityIndicator: UIActivityIndicatorView! //RE ep.72 
    @IBOutlet weak var imageScrollView: UIScrollView! //RE ep.71
    @IBOutlet weak var mainScrollView: UIScrollView! //RE ep.71
    
    @IBOutlet weak var mainStackView: UIStackView! //RE ep.71
    @IBOutlet weak var descriptionLabel: UILabel! //RE ep.71
    @IBOutlet weak var descriptionTextView: UITextView! //RE ep.71
    @IBOutlet weak var addressLabel: UILabel! //RE ep.71
    @IBOutlet weak var mapView: MKMapView! //RE ep.71
    
    
    @IBOutlet weak var priceLabel: UILabel! //RE ep.71
    @IBOutlet weak var propertyTypeLabel: UILabel! //RE ep.71
    @IBOutlet weak var shortInformationLabel: UILabel! //RE ep.71
    @IBOutlet weak var balconySizeLabel: UILabel! //RE ep.71
    @IBOutlet weak var roomLabel: UILabel! //RE ep.71
    @IBOutlet weak var bathroomLabel: UILabel! //RE ep.71
    @IBOutlet weak var parkingLabel: UILabel! //RE ep.71
    @IBOutlet weak var floorLabel: UILabel! //RE ep.71
    @IBOutlet weak var availableDateLabel: UILabel! //RE ep.71
    @IBOutlet weak var constructionYearLabel: UILabel! //RE ep.71
    @IBOutlet weak var titleDeedsLabel: UILabel! //RE ep.71
    @IBOutlet weak var centralHeatingLabel: UILabel! //RE ep.71
    @IBOutlet weak var solarWaterHeatingLabel: UILabel! //RE ep.71
    @IBOutlet weak var airConditionLabel: UILabel! //RE ep.71
    @IBOutlet weak var storeRoomLabel: UILabel! //RE ep.71
    @IBOutlet weak var furnishedLabel: UILabel! //RE ep.71 f
    
    
    
    
    override func viewDidLoad() { //RE ep.69
        super.viewDidLoad()
        
        getPropertyImages() //RE ep.73 1min
        setupUI() //RE ep.75 0min
        
        mainScrollView.contentSize = CGSize(width: view.frame.width, height: 950) //RE ep.72 2mins
        
        
    }
    
    
//MARK: IBActions
    @IBAction func phoneButtonTapped(_ sender: Any) { //RE ep.71
        Service.presentAlert(on: self, title: "Can't call yet", message: "Wait for future update")
    }
    
    @IBAction func backButtonTapped(_ sender: Any) { //RE ep.71
        self.dismiss(animated: true, completion: nil) //RE ep.71
    }
    
//MARK: Helpers
    func getPropertyImages(){ //RE ep.72 5mins
        if property.imageLinks != "" && property.imageLinks != nil { //RE ep.72 5mins
            downloadImages(urls: property.imageLinks!) { (images) in //RE ep.72 6mins if there is imageLinks then downloadImages using those links and get our image and store them in an array
                self.imageArray = images as! [UIImage] //RE ep.72 7mins
                self.setSlideShow() //RE ep.72 7mins
                self.activityIndicator.stopAnimating() //RE ep.72 8mins
                self.activityIndicator.isHidden = true //RE ep.72 8mins
            }
        } else { //RE ep.72 else theres no imageLinks
            self.imageArray.append(UIImage(named: "propertyPlaceholder")!) //RE ep.72 9mins
            self.setSlideShow() //RE ep.72 9mins
            self.activityIndicator.stopAnimating() //RE ep.72 9mins
            self.activityIndicator.isHidden = true //RE ep.72 9mins
        }
    }
    
    func setSlideShow() { //RE ep.72 7mins
        for i in 0 ..< imageArray.count { //RE ep.72 9mins check the number of images we have in our array, lesser than its count
            let imageView = UIImageView() //RE ep.72 10mins
            imageView.image = imageArray[i] //RE ep.72 10mins
            imageView.contentMode = .scaleAspectFit //RE ep.72 11mins
            
            let xPos = self.view.frame.width * CGFloat(i) //RE ep.72 11mins the xPosition is the screen's frame * i so it is dynamic for every slide
            imageView.frame = CGRect(x: xPos, y: 0, width: imageScrollView.frame.width, height: imageScrollView.frame.height) //RE ep.72 12mins
            
            imageScrollView.contentSize.width = imageScrollView.frame.width * CGFloat(i +  1) //RE ep.73 0mins everytime we add an image, we are changing the width of our scrollView
            imageScrollView.addSubview(imageView) //RE ep.73 add the imageView to the scrollView
            
        }
    }
    
    
    func setupUI(){ //RE ep.75 0mins
        if FUser.currentUser() != nil { //RE ep.75 1min if we have a logged in user...
            self.callBackButton.isEnabled = true //RE ep.75 1min enable our disabled callButton
        }
        
    //set properties
        propertyTitleLabel.text = property.title! //RE ep.75 2mins
        priceLabel.text = "\(property.price)" //RE ep.75 2mins
        shortInformationLabel.text = "\(property.size) m² - \(property.numberOfRooms) Bedroom(s)" //RE ep.75 3mins
        propertyTypeLabel.text = property.propertyType //RE ep.75 4mins
        furnishedLabel.text = property.isFurnished ? "YES" : "NO" //RE ep.75 4mins YES if isFurnished is true
        storeRoomLabel.text = property.storeRoom ? "YES" : "NO" //RE ep.75 5mins
        airConditionLabel.text = property.airconditioner ? "YES" : "NO" //RE ep.75 5mins
        solarWaterHeatingLabel.text = property.solarWaterHeating ? "YES" : "NO" //RE ep.75 5mins
        titleDeedsLabel.text = property.titleDeeds ? "YES" : "NO" //RE ep.75 5mins
        centralHeatingLabel.text = property.centralHeating ? "YES" : "NO" //RE ep.75 5mins
        constructionYearLabel.text = property.buildYear //RE ep.75 6mins
        floorLabel.text = "\(property.floor)" //RE ep.75 6mins
        parkingLabel.text = "\(property.parking)" //RE ep.75 7mins
        bathroomLabel.text = "\(property.numberOfBathrooms)" //RE ep.75 7mins
        balconySizeLabel.text = "\(property.balconySize)" //RE ep.75 7mins
        availableDateLabel.text = property.availableFrom //RE ep.75 7mins
        
        //hide these optional values
        descriptionLabel.isHidden = true //RE ep.75 8mins
        descriptionTextView.isHidden = true //RE ep.75 8mins
        addressLabel.isHidden = true //RE ep.75 8mins
        mapView.isHidden = true //RE ep.75 8mins
        
        if property.propertyDescription != nil { //RE ep.75 9mins if propertyDescription has a value, then show the label
            descriptionLabel.isHidden = false //RE ep.75 10mins
            descriptionTextView.isHidden = false //RE ep.75 10mins
            descriptionTextView.text = property.propertyDescription //RE ep.75 10mins
        }
        
        if property.address != nil && property.address != "" { //RE ep.75 11mins
            addressLabel.isHidden = false //RE ep.75 11mins
            addressLabel.text = property.address //RE ep.75 11mins
        }
        
        if property.latitude != 0 && property.latitude != nil { //RE ep.75 12mins
            mapView.isHidden = false //RE ep.75 12mins
            propertyCoordinate = CLLocationCoordinate2D(latitude: property.latitude, longitude: property.longitude) //RE ep.75 12mins
            
            let annotation = MKPointAnnotation() //RE ep.75 13mins
            annotation.title = property.title //RE ep.75 13mins
            annotation.subtitle = "\(property.numberOfRooms)-bedroom \(property.propertyType!)"
            annotation.coordinate = propertyCoordinate! //RE ep.75 14mins
            self.mapView.addAnnotation(annotation) //RE ep.75 14mins add the property's annotation
        }
        mainScrollView.contentSize = CGSize(width: view.frame.width, height: mainStackView.frame.size.height + 50) //RE ep.76 3mins
    }

}
