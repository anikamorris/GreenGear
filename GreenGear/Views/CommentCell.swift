//
//  CommentCell.swift
//  GreenGear
//
//  Created by Anika Morris on 6/26/20.
//  Copyright © 2020 Anika Morris. All rights reserved.
//

import UIKit

class CommentCell: UITableViewCell {
    
    static let identifier = "commentCell"

    var commentLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    var avatarImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.image = UIImage(systemName: "person")
        imageView.layer.cornerRadius = 20
        return imageView
    }()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setupCommentLabel()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
    }
    
    private func setupImageView() {
        self.contentView.addSubview(avatarImageView)
        NSLayoutConstraint.activate([
            avatarImageView.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 5.0),
            avatarImageView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 5.0),
            avatarImageView.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 5.0),
            avatarImageView.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 5.0),
        ])
    }
    
    private func setupCommentLabel() {
        self.contentView.addSubview(commentLabel)
        NSLayoutConstraint.activate([
            commentLabel.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 0.0),
            commentLabel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 10.0),
            commentLabel.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -10.0),
            commentLabel.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: 5.0)
        ])
    }
}
