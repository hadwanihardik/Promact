//
//  InstaCell.swift
//  PromactTest
//
//  Created by Hardik on 4/6/18.
//  Copyright © 2018 Hardik. All rights reserved.
//

import UIKit

class InstaCell: UITableViewCell {

    // Outlets for  feed data
    @IBOutlet weak var lblAutor: UILabel!
    @IBOutlet weak var lblPostUrl: UILabel!
    @IBOutlet weak var imageFeed: UIImageView!
    @IBOutlet weak var loader: UIActivityIndicatorView!
    var feed: InstaModel! = nil
    let imageLoader =  ImageDownloader()
    override func awakeFromNib() {
        super.awakeFromNib()
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(self.openInSafari))
        self.lblPostUrl.addGestureRecognizer(tapGesture)
        self.lblPostUrl.isUserInteractionEnabled = true
        
        // Initialization code
    }
    @objc func openInSafari() {
        guard let url = URL(string: feed.postUrl) else {
            return //be safe
        }
        
        if #available(iOS 10.0, *) {
            UIApplication.shared.open(url, options: [:], completionHandler: nil)
        } else {
            UIApplication.shared.openURL(url)
        }
        //Causes the view (or one of its embedded text fields) to resign the first responder status.
    }

    func configureCell()
    {
        self.lblAutor.text = "Author: \(feed.author)"
        let myString = NSMutableAttributedString(string:  "URL: \(feed.postUrl)")
        let myRange = NSRange(location: 5, length: feed.postUrl.count)
        myString.addAttribute(NSAttributedStringKey.foregroundColor, value: UIColor.blue, range: myRange)
        // set attributed text on a UILabel
        self.lblPostUrl.attributedText = myString
        //Start loader
        self.imageFeed.image = #imageLiteral(resourceName: "placeholderThumb")
        self.loader.startAnimating()
        imageLoader.downloadImageForPath(imgPath: self.createImageUrl(feed: feed)) { (image) in
            self.loader.stopAnimating()
            self.imageFeed.image = image
        }
        
        
    }
    
    func createImageUrl(feed : InstaModel) -> String
    {
        return "\(Constants.BaseURL)\(feed.width)/\(feed.height)?image=\(feed.imageId)"
    }
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
