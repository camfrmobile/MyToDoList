//
//  NoteViewController.swift
//  MyToDoList
//
//  Created by Trần Văn Cam on 17/11/2022.
//

import UIKit
import AVKit
import AVFoundation

class NoteViewController: UIViewController {
    @IBOutlet weak var containerView: UIView!
    @IBOutlet weak var todoLabel: UILabel!
    @IBOutlet weak var photoImageView: UIImageView!
    @IBOutlet weak var videoImageView: UIImageView!
    
    var toDoList: ToDoList = ToDoList(todo: "", isDone: false, expired: "")
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupUI()
        
        
    }

    func setupUI() {
        
        todoLabel.text = toDoList.todo
        
        if toDoList.imagePath.count > 0 {
            photoImageView.image = UIImage(contentsOfFile: toDoList.imagePath)
            
            photoImageView.isUserInteractionEnabled = true
            let pinchGesture = UIPinchGestureRecognizer(target: self, action: #selector(photoPlay))
            photoImageView.addGestureRecognizer(pinchGesture)
        }
        if toDoList.videoPath.count > 0 {
            videoImageView.image = UIImage(named: "video-player")
            
            videoImageView.isUserInteractionEnabled = true
            let tapGesture = UITapGestureRecognizer(target: self, action: #selector(videoPlay))
            videoImageView.addGestureRecognizer(tapGesture)
        }
        
    }
    
    @objc func videoPlay() {
        let videoURL = URL(fileURLWithPath: toDoList.videoPath)
        let player = AVPlayer(url: videoURL)
        player.play()
        let vcPlayer = AVPlayerViewController()
        vcPlayer.player = player
        self.present(vcPlayer, animated: true, completion: nil)
    }
    
    @objc func photoPlay(sender: UIPinchGestureRecognizer) {
        photoImageView.transform = CGAffineTransform(scaleX: sender.scale, y: sender.scale)
    }
}
