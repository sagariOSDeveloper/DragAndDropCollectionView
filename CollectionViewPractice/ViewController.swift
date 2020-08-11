//
//  ViewController.swift
//  CollectionViewPractice
//
//  Created by Sagar Baloch on 08/08/2020.
//  Copyright © 2020 Sagar Baloch. All rights reserved.
//

import UIKit

class ViewController: UIViewController,UICollectionViewDelegateFlowLayout {
    
    private var myCollectionView:UICollectionView?
    var colors:[UIColor] = [
        .black,
        .blue,
        .brown,
        .darkGray,
        .green,
        .link,
        .systemRed,
        .systemPink,
        .yellow,
        .magenta,
        .black,
        .blue,
        .brown,
        .darkGray,
        .green,
        .link,
        .systemRed,
        .systemPink,
        .yellow,
        .magenta
    ]
    override func viewDidLoad() {
        super.viewDidLoad()
        setupCollectionView()
        myCollectionView?.delegate = self
        myCollectionView?.dataSource = self
        myCollectionView?.backgroundColor = .white
    }
    
    func setupCollectionView(){
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .vertical
        layout.itemSize = CGSize(width: view.frame.size.width/3.2, height: view.frame.size.width/3.2)
        layout.sectionInset = UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 0)
        myCollectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
        myCollectionView?.register(UICollectionViewCell.self, forCellWithReuseIdentifier: "cell")
        view.addSubview(myCollectionView!)
        let gesture = UIPanGestureRecognizer(target: self, action: #selector(handleGesture(_:)))
        myCollectionView?.addGestureRecognizer(gesture)
    }
    
    @objc func handleGesture(_ gesture:UIPanGestureRecognizer ){
        guard let myCollectionView = myCollectionView else{
            return
        }
        switch gesture.state {
        case .began:
            guard let targetIndexPath = myCollectionView.indexPathForItem(at: gesture.location(in: myCollectionView)) else {
                return
            }
            myCollectionView.beginInteractiveMovementForItem(at: targetIndexPath)
            break
        case .changed:
            myCollectionView.updateInteractiveMovementTargetPosition(gesture.location(in: myCollectionView))
            break
        case .ended:
            myCollectionView.endInteractiveMovement()
            break
        default:
            myCollectionView.cancelInteractiveMovement()
            
        }
    }
    
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        myCollectionView?.frame = view.bounds
    }
    
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: view.frame.size.width/3.2, height: view.frame.size.width/3.2)
    }
    func collectionView(_ collectionView: UICollectionView, canMoveItemAt indexPath: IndexPath) -> Bool {
        return true
    }
    func collectionView(_ collectionView: UICollectionView, moveItemAt sourceIndexPath: IndexPath, to destinationIndexPath: IndexPath) {
        let item = colors.remove(at: sourceIndexPath.row)
        colors.insert(item, at: destinationIndexPath.row)
    }
}


extension ViewController:UICollectionViewDataSource {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return colors.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "cell", for: indexPath)
        cell.backgroundColor = colors[indexPath.row]
        return cell
    }
    
}
