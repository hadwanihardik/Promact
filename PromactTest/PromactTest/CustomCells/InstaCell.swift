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
    
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
