//
//  BookTableViewCell.swift
//  BooksApp
//
//  Created by Aravind on 06/09/17.
//  Copyright © 2017 HCL. All rights reserved.
//

import UIKit
// Protocol for the book status change
protocol BookTableViewCellDelegate {
    func bookReadingStatusChanged(sender:BookStatusButton)
}

class BookTableViewCell: UITableViewCell {
    var delegate: BookTableViewCellDelegate?
    @IBOutlet weak var bookStatus: BookStatusButton!
    @IBOutlet weak var bookThumbnail: UIImageView!
    @IBOutlet weak var authorName: UILabel!
    @IBOutlet weak var bookTitle: UILabel!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    @IBAction func bookStatusButtopTapped(_ sender: BookStatusButton) {
        delegate?.bookReadingStatusChanged(sender: sender)
    }
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
