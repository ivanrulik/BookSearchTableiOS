//
//  SearchVC.swift
//  bookSeachTable
//
//  Created by Ivan Rulik on 7/30/20.
//  Copyright © 2020 Ivan Rulik. All rights reserved.
//

import UIKit

protocol VCSearchDelegate {
    func updateData(data: BookTVC.bookFile)
}

class SearchVC: UIViewController {
    var delegate: VCSearchDelegate?
        
    var bookTitle : String = ""
    var bookAuthors : String = ""
    var bookCover : UIImage!
    var bookISBN : String = ""
    
    @IBOutlet weak var searchTitleLabel: UILabel!
    @IBOutlet weak var searchAuthorsLabel: UILabel!
    @IBOutlet weak var searchCoverImageView: UIImageView!
    @IBOutlet weak var searchtextField: UITextField!
    
    
    func webSearchBook(inputTextView:UITextField) {
        print("Searching...")
        let ISBN = inputTextView.text!
        let ISBNKey = "ISBN:"+ISBN
        let urls = "https://openlibrary.org/api/books?jscmd=data&format=json&bibkeys=ISBN:" + ISBN
        let url = URL(string : urls)!
        
        let bookData = NSData(contentsOf: url)
        //print(bookData)

        bookISBN = ISBN
        do {
            let jsonData = try JSONSerialization.jsonObject(with: bookData! as Data, options: JSONSerialization.ReadingOptions.mutableLeaves) as! NSDictionary
            if(jsonData[ISBNKey] != nil){
                let bookDict = jsonData[ISBNKey] as! NSDictionary
                bookTitle = bookDict["title"] as! String
                if (bookDict["authors"] != nil){
                    let authorsArray = bookDict["authors"] as! NSArray
                    let numAuthors = authorsArray.count as Int
                    for index in 0...(numAuthors-1){
                        let author1 = authorsArray[index] as! NSDictionary
                        let tempauthor = author1["name"] as! String
                        if (index > 0){
                            bookAuthors = bookAuthors + ", " + tempauthor
                        }
                        else{
                            bookAuthors = tempauthor
                        }
                    }
                }
                else{
                    bookAuthors = "No registered Authors"
                }
                
                if bookDict["cover"] == nil {
                     print("there is no cover")
                    bookCover = UIImage()
                }
                else{
                    let coverDict = bookDict["cover"] as! NSDictionary
                    let coverString = coverDict["medium"] as! String
                    let coverURL = URL(string: coverString)
                    guard let bookCoverData = try? Data(contentsOf: coverURL!) else{return}
                    bookCover = UIImage(data: bookCoverData)!
                }

                print(bookDict)
                
                self.searchTitleLabel.text = bookTitle
                self.searchAuthorsLabel.text = bookAuthors
                self.searchCoverImageView.image = bookCover
                
                let searchedBook = BookTVC.bookFile(title: bookTitle, authors: bookAuthors, ISBN: bookISBN, cover: bookCover)
                self.delegate?.updateData(data: searchedBook)
            }
            else{
                self.searchTitleLabel.text = ""
                self.searchAuthorsLabel.text = "Wrong ISBN, type it again"
                self.searchCoverImageView.image = nil
            }
            
            
        }
        catch _ {
            
        }
        
        
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        
    }
    

    
    @IBAction func searchByKB(_ sender: UITextField) {
        print("Search started")
        webSearchBook(inputTextView: searchtextField)
    }
    
    @IBAction func searchByBtnn(_ sender: Any) {
        self.searchtextField.resignFirstResponder()
        print("Search started")
        webSearchBook(inputTextView: searchtextField)
    }
    
    @IBAction func clearBttn(_ sender: Any) {
        self.searchtextField.text = ""
        self.searchTitleLabel.text = "Title"
        self.searchAuthorsLabel.text = "Author(s)"
        self.searchCoverImageView.image = nil
    }
    
    

    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
        //if (bookTitle != ""){
//        print("Performing segue back to main view")
//        let searchedBook = BookTVC.bookFile(title: bookTitle, authors: bookAuthors, ISBN: bookISBN, cover: bookCover)
//
//        let detailTableViewSegue =  segue.destination as! BookTVC
//        detailTableViewSegue.bookCollection.append(searchedBook)
            
        //}
    }


}
