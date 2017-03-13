//
//  AboutTableViewController.swift
//  PinFood
//
//  Created by Mahmoud RACHID on 24/02/2017.
//  Copyright © 2017 Mahmoud RACHID. All rights reserved.
//

import UIKit
import SafariServices

class AboutTableViewController: UITableViewController {
    
    
    var sectionTitles = ["Leave Feedback", "Follow Us"]
    
    var sectionContent = [
        ["Rate us on App Store", "Tell us your feedback"],
        ["Twitter", "Facebook", "Pinterest"]
    ]
    
    var links = [
        "https://twitter.com/appcodamobile",
        "https://facebook.com/appcodamobile",
        "https://www.pinterest.com/appcoda/"
    ]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.tableFooterView = UIView(frame: CGRect.zero)
    }
    
    
    // MARK: - Table view data source
    
    override func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return sectionTitles.count
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return sectionContent[section].count
    }
    
    override func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        return sectionTitles[section]
    }
    
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "Cell", for: indexPath)
        cell.textLabel?.text = sectionContent[indexPath.section][indexPath.row]
        
        return cell
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        switch indexPath.section {
        case 0:
            if indexPath.row == 0{
                if let url = URL(string: "http://www.apple.com/itunes/charts/paid-apps/"){
                    UIApplication.shared.open(url, options: [:], completionHandler: nil)
                }
            }else if indexPath.row == 1{
                performSegue(withIdentifier: "showWebView", sender: self)
            }
        case 1:
            if let url = URL(string: links[indexPath.row]){
                let safariController = SFSafariViewController(url: url)
                present(safariController, animated: true, completion: nil)
            }
        default:
            break
        }
        tableView.deselectRow(at: indexPath, animated: false)
    }
    
}
