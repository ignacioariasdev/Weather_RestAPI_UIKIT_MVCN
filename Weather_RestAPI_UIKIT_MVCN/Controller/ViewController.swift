//
//  ViewController.swift
//  Weather_RestAPI_UIKIT_MVCN
//
//  Created by Ignacio Arias on 2020-07-11.
//  Copyright © 2020 Ignacio Arias. All rights reserved.
//

import UIKit
import Network
import CoreData

class ViewController: UIViewController {
    
    //CoreData object being presented
    var coreDataController: CoreDataController!
    
    //Weather object being presented
    var weathers: [Weather]!
    
    let txtField: UITextField = {
        let textField = UITextField()
        textField.backgroundColor = .white
        textField.borderStyle = .roundedRect
        textField.placeholder = "Type a city name..."
        textField.adjustsFontSizeToFitWidth = true
        textField.font = UIFont.systemFont(ofSize: 16)
        textField.autocorrectionType = .yes
//        textField.addTarget(self, action: #selector(handleSearch), for: .touchUpInside)
        
        return textField
    }()
    
    @objc func handleSearch() {
        //Make sure this is not empty
       guard let userTyped = txtField.text else {
           return
       }
       
               
       //Pass the userTyped to a function
       searchUserTyped(userTyped)
               
    }
    
    func searchUserTyped(_ location: String) {
            
            let weatherEndPoint = WeatherAPI.EndPoints.getWeatherInfo(cityName: location).url
            
            NetworkController.requestWeatherData(url: weatherEndPoint) { (data, error) in
                
                guard let data = data else { return }
                
                //data print bytes
                
                let decoder = JSONDecoder()
                
                do {
                    
                    let weatherData = try decoder.decode(WeatherJSON.self, from: data)
                    
                    DispatchQueue.main.async {
                        //Activity stop animating
                        self.cityName.text = weatherData.name
                        self.citySpeed.text = String(weatherData.wind.speed)
                    }
                } catch {
                    DispatchQueue.main.async {
    //                    self.activityIndicator.stopAnimating()
                        self.txtField.text = "That's not a city, try again!"
                    }
                    print("That's not a city!, " + error.localizedDescription)
                }
            }
            
            
        }
    
    let searchBtn: UIButton = {
        let button = UIButton(type: .system)
        button.setTitle("Search", for: .normal)
        button.setTitleColor(.black, for: .normal)
        button.clipsToBounds = true
        button.layer.cornerRadius = 8
        button.backgroundColor = #colorLiteral(red: 0.721568644, green: 0.8862745166, blue: 0.5921568871, alpha: 1)
        button.addTarget(self, action: #selector(handleSearch), for: .touchUpInside)
        button.contentHorizontalAlignment = .center
        
        return button
    }()
    
    let cityName: UILabel = {
        let label = UILabel()
        label.font = label.font.withSize(14)
        label.translatesAutoresizingMaskIntoConstraints = false
        label.text = "City name"
        label.textColor = .white
        return label
    }()
    
    let citySpeed: UILabel = {
        let label = UILabel()
        label.font = label.font.withSize(14)
        label.translatesAutoresizingMaskIntoConstraints = false
        label.text = "City speed"
        label.textColor = .white
        return label
    }()
    
    
    lazy var barBtnItem = UIBarButtonItem(title: "Add", style: .done, target: self, action: #selector(handleAdd))

    @objc func handleAdd() {
        addingRow()
    }
    
    @available(iOS 12.0, *)
       func statusDidChange(status: NWPath.Status) {
           if status == .satisfied {
               // Internet connection is back on
               cityName.text = ""
           } else {
               // No internet connection
               cityName.text = "NO NETWORK"
               
           }
       }
    
    var myTableView = UITableView()
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
    
        view.backgroundColor = .systemTeal
        
            
        myTableView.delegate = self
        myTableView.dataSource = self
        
        myTableView.register(ViewControllerTableViewCell.self, forCellReuseIdentifier: "cellID")
        
        myTableView.allowsSelection = false
        
        
        view.addSubview(txtField)
        view.addSubview(searchBtn)
        view.addSubview(cityName)
        view.addSubview(citySpeed)
        view.addSubview(myTableView)
        
        self.navigationItem.rightBarButtonItem  = barBtnItem
        
        
        txtField.setUpAnchor(top: view.safeAreaLayoutGuide.topAnchor, left: view.leftAnchor, bottom: nil, right: view.rightAnchor, topPadding: 20, leftPadding: 8, bottomPadding: 0, rightPadding: 8, width: 0, height: 0)
        
        searchBtn.setUpAnchor(top: txtField.bottomAnchor, left: txtField.leftAnchor, bottom: nil, right: txtField.rightAnchor, topPadding: 20, leftPadding: 0, bottomPadding: 0, rightPadding: 0, width: 50, height: 50)
        
        cityName.setUpAnchor(top: searchBtn.bottomAnchor, left: txtField.leftAnchor, bottom: nil, right: nil, topPadding: 30, leftPadding: 0, bottomPadding: 0, rightPadding: 0, width: 0, height: 0)
        
        citySpeed.setUpAnchor(top: cityName.bottomAnchor, left: txtField.leftAnchor, bottom: nil, right: nil, topPadding: 20, leftPadding: 0, bottomPadding: 0, rightPadding: 0, width: 0, height: 0)
        
        myTableView.setUpAnchor(top: citySpeed.bottomAnchor, left: txtField.leftAnchor, bottom: view.bottomAnchor, right: txtField.rightAnchor, topPadding: 20, leftPadding: 0, bottomPadding: 50, rightPadding: 0, width: 0, height: 0)
        
        coreDataLogic()
        
    }
    
    fileprivate func coreDataLogic() {
        
        //NSManagedContext, this is step 10.
        let fetchRequest: NSFetchRequest<Weather> = Weather.fetchRequest()
        
        //step 10.1
        let sortDescriptor = NSSortDescriptor(key: "name", ascending: false)
        
        fetchRequest.sortDescriptors = [sortDescriptor]
        
        if let result = try? coreDataController.viewContext.fetch(fetchRequest) {
            
            // Array from dataSource fetched with coreData
            weathers = result
            //refresh UI by repopulating the data
            myTableView.reloadData()
            
        }
        
    }
    
    func addingRow() {
            let name = cityName.text
            let num = citySpeed.text
            self.addWeather(name: name!, num: num!)
        }
        
        
        
        //Adds a new weather to the end of the `weathers`  array
        func addWeather(name: String, num: String) {
            
            //Create
            let weather = Weather(context: coreDataController.viewContext)
            
            weather.name = name
            weather.speed = num
            
            
            //Save to persistent store
            try? coreDataController.viewContext.save()
            
            //Append adds to the end, insert adds to the init
            weathers.insert(weather, at: 0)
            
            myTableView.insertRows(at: [IndexPath(row: 0, section: 0)], with: .fade)
            
        }
        
        
        
        // MARK: - Helpers
        var numberOfWeathers: Int { return weathers.count }
        
        func weather(at indexPath: IndexPath) -> Weather {
            return weathers[indexPath.row]
        }
    
}


extension ViewController: UITableViewDataSource, UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 100
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return numberOfWeathers
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let aWeather = weather(at: indexPath)
        
        let cell = myTableView.dequeueReusableCell(withIdentifier: "cellID", for: indexPath) as! ViewControllerTableViewCell
        
        cell.cityName.text = aWeather.name
        cell.citySpeed.text = aWeather.speed
        
        return cell
        
    }
    
    
}
