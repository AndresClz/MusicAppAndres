//
//  AudioPlayerViewModel.swift
//  AndresAppNoStoryBoard
//
//  Created by Andres Calizaya on 12/12/2021.
//

import UIKit

class AudioPlayerViewModel: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    func deleteSong(_ song: Track) {
        let index: Int = misTracks.firstIndex(of: song)!
        print("Deleted \(misTracks[index])")
        print(index)
        misTracks.remove(at: index)
        
        //print("mis track”", misTracks)
        
      }
}
