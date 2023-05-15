//
//  CategoryNameViewController.swift
//  Music-App
//
//  Created by Ayca Akman on 8.05.2023.
//

import UIKit

class CategoryNamesViewController: UIViewController {

    @IBOutlet weak var categoryNamesCollectionView: UICollectionView!
    
    var artistNames : [ArtistData]!
    var selectedRowIndex : Int?
    var genreID : Int?
    var artistID : Int?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        categoryNamesCollectionView.dataSource = self
        categoryNamesCollectionView.delegate = self
     
        setLayout()
        fetchData()
    }
    
    func setLayout() {
        let layout = UICollectionViewFlowLayout()
        layout.minimumInteritemSpacing = 5
        categoryNamesCollectionView.collectionViewLayout = layout
    }
  
    func fetchData() {
        guard let genreID = genreID else {
            print("invalid URL address")
            return
        }
        let url = URL(string: "https://api.deezer.com/genre/\(genreID)/artists")!
        NetworkService().downloadData(url: url) { (categoryNames: CategoryNames?) in
            if let categoryNames = categoryNames {
                self.artistNames = categoryNames.data
                DispatchQueue.main.async {
                    self.categoryNamesCollectionView.reloadData()
                }
            }
        }
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "toGoDetailsOfArtist" {
            if let destinationVC = segue.destination as? ArtistAlbumsViewController,
               let index = selectedRowIndex {
                destinationVC.navigationItem.title = artistNames[index].name
                destinationVC.artistID = artistNames[index].id
                destinationVC.artistImageUrl = artistNames[index].pictureXl
                destinationVC.tracklist = artistNames[index].tracklist
            }
        }
    }

}


extension CategoryNamesViewController : UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return artistNames?.count ?? 0
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = categoryNamesCollectionView.dequeueReusableCell(withReuseIdentifier: "CategoryNamesCollectionViewCell", for: indexPath) as! CategoryNameCollectionViewCell
        cell.setup(with: artistNames[indexPath.row])
        return cell
    }
}

extension CategoryNamesViewController: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let padding : CGFloat = 5
        let collectionViewSize = collectionView.frame.size.width - padding
        return CGSize(width: collectionViewSize / 2, height: collectionViewSize / 2)

    }
}

extension CategoryNamesViewController: UICollectionViewDelegate{
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        selectedRowIndex = indexPath.row
        performSegue(withIdentifier: "toGoDetailsOfArtist", sender: nil)
    }
}

