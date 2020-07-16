//
//  TopicSection.swift
//  GreenGear
//
//  Created by Anika Morris on 7/16/20.
//  Copyright © 2020 Anika Morris. All rights reserved.
//

import Foundation
import UIKit

protocol Section {
    var numberOfItems: Int { get }
    func configureCell(collectionView: UICollectionView, indexPath: IndexPath) -> UICollectionViewCell
}

struct TopicSection: Section {
    var numberOfItems: Int = 7
    var topics: [String] = ["deployment", "civilians", "health", "VA", "coming home", "relationships", "substances"]
    
    func configureCell(collectionView: UICollectionView, indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: TopicCell.identifier, for: indexPath) as! TopicCell
        cell.set(topic: topics[indexPath.row])
        return cell
    }

}
