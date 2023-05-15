//
//  ViewController.swift
//  Music-App
//
//  Created by Ayca Akman on 8.05.2023.
//

import UIKit

class MusicCategoriesViewController: UIViewController {
    
    @IBOutlet weak var musicCategoriesCollectionView: UICollectionView!
    
    var musicCategory : [Data]!    
    var selectedRowIndex : Int?
   
    override func viewDidLoad() {
        super.viewDidLoad()

        musicCategoriesCollectionView.dataSource = self
        musicCategoriesCollectionView.delegate = self
        self.tabBarController?.delegate = self

        setLayout()
        fetchData()
    }

    func setLayout() {
        navigationItem.title = "Music Categories"
        let layout = UICollectionViewFlowLayout()
        layout.minimumInteritemSpacing = 5
        musicCategoriesCollectionView.collectionViewLayout = layout
    }
   
    
    func fetchData() {
        guard let url = URL(string: "https://api.deezer.com/genre") else {
            print("invalid URL address")
            return
        }
        NetworkService().downloadData(url: url) { (category: MusicCategory?) in
            if let category = category {
                self.musicCategory = category.data
                //to prevent delay in the screen
                  DispatchQueue.main.async {
                      self.musicCategoriesCollectionView.reloadData()
                  }
              }
        }
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "toGoCategory" {
            if let destinationViewController = segue.destination as? CategoryNamesViewController,
               let index = selectedRowIndex {
                destinationViewController.genreID = musicCategory[index].id
                destinationViewController.navigationItem.title = musicCategory[index].name
            }
        }
    }
}


extension MusicCategoriesViewController : UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return musicCategory?.count ?? 0
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = musicCategoriesCollectionView.dequeueReusableCell(withReuseIdentifier: "MusicCategoriesCollectionViewCell", for: indexPath) as! MusicCategoriesCollectionViewCell
        cell.setup(with: musicCategory[indexPath.row])
        return cell
    }
}

extension MusicCategoriesViewController: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let padding : CGFloat = 5
        let collectionViewSize = collectionView.frame.size.width - padding
        return CGSize(width: collectionViewSize / 2, height: collectionViewSize / 2)
    }
}

extension MusicCategoriesViewController: UICollectionViewDelegate {
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        print(musicCategory[indexPath.row])
        selectedRowIndex = indexPath.row
        performSegue(withIdentifier: "toGoCategory", sender: nil)
    }
   
    
}


extension MusicCategoriesViewController: UITabBarControllerDelegate {
    func tabBarController(_ tabBarController: UITabBarController, didSelect viewController: UIViewController) {
        let tabBar = tabBarController.tabBar
        if tabBarController.selectedIndex == 1 {
            tabBar.items?[1].image = UIImage(systemName: "suit.heart.fill")
        }else {
            tabBar.items?[1].image = UIImage(systemName: "suit.heart")
        }
    }
}

