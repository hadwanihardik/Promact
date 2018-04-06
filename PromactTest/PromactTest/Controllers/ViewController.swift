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
    let imageLoader =  ImageDownloader()

    var feedsArray = [InstaModel]()

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        //get Feeds from server
        feedTableView.estimatedRowHeight = 170.0
        feedTableView.rowHeight = UITableViewAutomaticDimension
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
        
        cell.lblAutor.text = "\(cell.feed.imageId) Author: \(cell.feed.author)"
        let myString = NSMutableAttributedString(string:  "URL: \(cell.feed.postUrl)")
        let myRange = NSRange(location: 5, length: cell.feed.postUrl.count)
        myString.addAttribute(NSAttributedStringKey.foregroundColor, value: UIColor.blue, range: myRange)
        // set attributed text on a UILabel
        cell.lblPostUrl.attributedText = myString
        //Start loader
        cell.imageFeed.image = #imageLiteral(resourceName: "placeholderThumb")
        cell.loader.startAnimating()
        imageLoader.downloadImageForPath(imgPath: self.createImageUrl(feed: cell.feed)) { (image) in
            if tableView.cellForRow(at: indexPath) != nil {
                cell.imageFeed.image = image
                //Stop loader
                cell.loader.stopAnimating()
            }
        }
        return cell
    }
    func createImageUrl(feed : InstaModel) -> String
    {
        return "\(Constants.BaseURL)\(feed.width)/\(feed.height)?image=\(feed.imageId)"
    }
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

