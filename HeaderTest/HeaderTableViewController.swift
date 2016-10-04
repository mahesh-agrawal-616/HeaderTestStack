//
//  HeaderTableViewController.swift
//
//

import UIKit
import CoreData

class HeaderTableViewController: UITableViewController {
    
    
    var data: [String: [String]] = [:]
    
    var nonDefaultTitle : String?
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        tableView.sectionHeaderHeight = UITableViewAutomaticDimension;
        tableView.estimatedSectionHeaderHeight = 25;
        
        tableView.registerNib(UINib(nibName: "DefaultCustomCell", bundle: nil), forCellReuseIdentifier: "DefaultCustomCell")
        tableView.estimatedRowHeight = 50
        tableView.rowHeight = UITableViewAutomaticDimension
        
        let nib = UINib(nibName: "HeaderTableHeaderView", bundle: nil)
        tableView.registerNib(nib, forHeaderFooterViewReuseIdentifier: "HeaderTableHeaderView")
    }
    
    override func viewWillAppear(animated: Bool) {
        super.viewWillAppear(animated)
        
        let header = HeaderTableLargeHeaderView.instanceFromNib() as! HeaderTableLargeHeaderView
        header.titleLabel.text = "here is a bunch of words that are awesome here we go.."
        tableView.tableHeaderView = header
    }
    
}

//
// MARK: - I tried this as well to size the header which didn't work ;(
//
extension UITableView {
    //set the tableHeaderView so that the required height can be determined, update the header's frame and set it again
    
    func setAndLayoutTableHeaderView(header: UIView) {
        self.tableHeaderView = header
        header.setNeedsLayout()
        header.layoutIfNeeded()
        let height = header.systemLayoutSizeFittingSize(UILayoutFittingCompressedSize).height
        var frame = header.frame
        frame.size.height = height
        header.frame = frame
        self.tableHeaderView = header
    }
}


//
// MARK: Class that handles the HeaderTableLargeHeaderView (sorry for the terrible naming conventions)
//
class HeaderTableLargeHeaderView: UIView {
    
    // Our title label with autolayout constraints
    @IBOutlet weak var titleLabel: UILabel!
    
    // Convience method to load for xib
    class func instanceFromNib() -> UIView {
        return UINib(nibName: "HeaderTableLargeHeaderView", bundle: nil).instantiateWithOwner(nil, options: nil)[0] as! UIView
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        //titleLabel.preferredMaxLayoutWidth = titleLabel.bounds.width
    }
}

class HeaderTableHeaderView: UITableViewHeaderFooterView {
    @IBOutlet weak var titleLabel: UILabel!
}


//
// MARK : Table view data
//
extension HeaderTableViewController {
    // MARK: - Table View
    
    override func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return 2
    }
    
    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 4
    }
    
    override func tableView(tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        
        let cell = self.tableView.dequeueReusableHeaderFooterViewWithIdentifier("HeaderTableHeaderView")
        let header = cell as? HeaderTableHeaderView
        
        if (section == 0) {
            header!.titleLabel.text = "The quick brown fox"
        }
        else {
            header!.titleLabel.text = "Jumped over the extremly lazy dog. This should be a multiline section header"
        }
        
        return cell
    }
    
    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = UITableViewCell(style: .Default, reuseIdentifier: "Cell")
        
        cell.textLabel?.text = "-"
        
        return cell
    }
    
    override func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        
    }
    
    //DetailViewController
    
    override func tableView(tableView: UITableView, canEditRowAtIndexPath indexPath: NSIndexPath) -> Bool {
        // Return false if you do not want the specified item to be editable.
        return true
    }
}

