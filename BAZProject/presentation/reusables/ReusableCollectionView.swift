//
//  ReusableCollectionView.swift
//  BAZProject
//
//  Created by Ivan Tecpanecatl Martinez on 29/03/23.
//

import Foundation
import UIKit

class ReusableCollectionView<T: ReusableCollectionViewCell<U>,U>:ReusableViewController,
    UICollectionViewDataSource,UICollectionViewDelegate,
    UICollectionViewDelegateFlowLayout{

    var items = [U](){
        didSet{
            DispatchQueue.main.async {
                self.collectionView.reloadData()
            }
        }
    }

    var message = ""

    var section = 1

    let collectionView = UICollectionView(frame: CGRect(x: 0, y: 0, width: 0, height: 0), collectionViewLayout: UICollectionViewFlowLayout())

    override func setupView() {
        super.setupView()
        view.addSubview(collectionView)
        collectionView.dataSource = self
        collectionView.delegate = self

        let reuseIdentifier = NSStringFromClass(T.self)
        collectionView.register(T.self, forCellWithReuseIdentifier: reuseIdentifier)

        collectionView.translatesAutoresizingMaskIntoConstraints = false
        collectionView.topAnchor.constraint(equalTo:view.safeAreaLayoutGuide.topAnchor).isActive = true
        collectionView.leftAnchor.constraint(equalTo:view.safeAreaLayoutGuide.leftAnchor).isActive = true
        collectionView.rightAnchor.constraint(equalTo:view.safeAreaLayoutGuide.rightAnchor).isActive = true
        collectionView.bottomAnchor.constraint(equalTo:view.safeAreaLayoutGuide.bottomAnchor).isActive = true

        collectionView.backgroundColor = .white

        configCollectionView()
    }

    func configCollectionView(){}

    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return items.count
    }

    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return self.section
    }

    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let identifier = NSStringFromClass(T.self)
        let item = collectionView.dequeueReusableCell(withReuseIdentifier: identifier, for: indexPath) as! T
        item.item = items[indexPath.row]
        //item.item = items[indexPath.section][indexPath.row]
        return item
    }

    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        print("didSelectItemAt \(indexPath.row)")
    }

    //MARK: - UICollectionViewDelegateFlowLayout

    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let padding: CGFloat =  50
        let collectionViewSize = collectionView.frame.size.width - padding
        return CGSize(width: collectionViewSize, height: collectionViewSize)
    }
}
