//
//  ViewController.swift
//  PromactTest
//
//  Created by Hardik on 4/6/18.
//  Copyright © 2018 Hardik. All rights reserved.
//
import UIKit
class ViewController: UIViewController,UITableViewDelegate,UITableViewDataSource {

    @IBOutlet var feedTableView: UITableView!
    @IBOutlet weak var activityIndicator: UIActivityIndicatorView!

    var feedsArray = [InstaModel]()

    override func viewDidLoad() {
        super.viewDidLoad()
        self.title =  "Feed List"
        // Do any additional setup after loading the view, typically from a nib.
        //get Feeds from server
        self.loadFeeds()
    }
    
    func loadFeeds()
    {
        self.activityIndicator.startAnimating()
        ApiHandler.GetAPI(apiName: Constants.GetFeeds) { (status, feedsData) in
            
            DispatchQueue.main.async
                {
                    self.activityIndicator.stopAnimating()

                    if(feedsData.count > 0)
                    {
                        print(self.feedsArray)
                        for feed in feedsData
                        {
                            self.feedsArray.append(InstaModel(dict: feed as! NSDictionary))
                        }
                    }
                    else
                    {
                        Utility.showAlert(title: "Error", Message:"No feeds available", buttonText: "Ok", viewController: self)
                    }
                        self.feedTableView.reloadData()
            }
        }
    }
    

    //#pragma mark - Table view delegate and data source.
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.feedsArray.count;
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
       let cell = tableView.dequeueReusableCell(withIdentifier: "InstaCell", for: indexPath) as! InstaCell
        cell.feed = feedsArray[indexPath.row]
        cell.configureCell()
        return cell
    }
    
   
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

