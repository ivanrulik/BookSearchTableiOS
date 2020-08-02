//
//  BookTVC.swift
//  bookSeachTable
//
//  Created by Ivan Rulik on 7/30/20.
//  Copyright © 2020 Ivan Rulik. All rights reserved.
//

import UIKit

class BookTVC: UITableViewController {
    
    struct bookFile {
        var title:String
        var authors:String
        var ISBN:String
        var cover:UIImage
        
        init(title:String,authors:String,ISBN:String,cover:UIImage) {
            self.title = title
            self.authors = authors
            self.ISBN = ISBN
            self.cover = cover
        }
        
    }
    
    var bookCollection : [bookFile] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false

        // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
        // self.navigationItem.rightBarButtonItem = self.editButtonItem
    }

    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return self.bookCollection.count
    }

   
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "BookCell", for: indexPath)

        // Configure the cell...
        cell.textLabel?.text = self.bookCollection[indexPath.row].title
        return cell
    }
  

    /*
    // Override to support conditional editing of the table view.
    override func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the specified item to be editable.
        return true
    }
    */

    /*
    // Override to support editing the table view.
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            // Delete the row from the data source
            tableView.deleteRows(at: [indexPath], with: .fade)
        } else if editingStyle == .insert {
            // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
        }    
    }
    */

    /*
    // Override to support rearranging the table view.
    override func tableView(_ tableView: UITableView, moveRowAt fromIndexPath: IndexPath, to: IndexPath) {

    }
    */

    /*
    // Override to support conditional rearranging of the table view.
    override func tableView(_ tableView: UITableView, canMoveRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the item to be re-orderable.
        return true
    }
    */


    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
        if (segue.identifier == "goToDetail"){
            let detailViewSegue =  segue.destination as! BookDetailVC
            let indexBookTable = self.tableView.indexPathForSelectedRow
            
            detailViewSegue.detailBook = bookCollection[indexBookTable!.row]
        }
        if segue.identifier == "goToSearch" {
            (segue.destination as! SearchVC).delegate = self
        }
    }

}
extension BookTVC: VCSearchDelegate {
    func updateData(data: bookFile) {
        self.bookCollection.append(data)
        print("Book collection updated, number of books: \(bookCollection.count)")
        self.title = "List of Saved Book (\(bookCollection.count))"
        DispatchQueue.main.async { self.tableView.reloadData() }
    }
}
