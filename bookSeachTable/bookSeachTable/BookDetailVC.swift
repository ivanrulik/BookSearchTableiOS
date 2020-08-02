//
//  BookDetailVC.swift
//  bookSeachTable
//
//  Created by Ivan Rulik on 7/30/20.
//  Copyright © 2020 Ivan Rulik. All rights reserved.
//

import UIKit

class BookDetailVC: UIViewController {
    
    var detailBook: BookTVC.bookFile = BookTVC.bookFile(title: "", authors: "", ISBN: "", cover: UIImage())

    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var authorsLabel: UILabel!
    @IBOutlet weak var coverImageView: UIImageView!
    @IBOutlet weak var ISBNLabel: UILabel!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        self.titleLabel.text = detailBook.title
        self.authorsLabel.text = detailBook.authors
        self.ISBNLabel.text = "ISBN:"+detailBook.ISBN
        self.coverImageView.image = detailBook.cover
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
