//
//  EditToDoListViewController.swift
//  MyToDoList
//
//  Created by Trần Văn Cam on 17/11/2022.
//

import UIKit
import Photos

class EditToDoListViewController: UIViewController {
    
    @IBOutlet weak var toDoTextView: UITextView!
    @IBOutlet weak var expiredTextField: UITextField!
    @IBOutlet weak var isDoneSwitch: UISwitch!
    @IBOutlet weak var buttonSave: UIButton!
    
    @IBOutlet weak var chooseImageView: UIImageView!
    @IBOutlet weak var chooseVideoView: UIImageView!
    
    let libraryPicker: UIImagePickerController = {
        let picker = UIImagePickerController()
        picker.allowsEditing = false
        picker.sourceType = .photoLibrary
        picker.mediaTypes = UIImagePickerController.availableMediaTypes(for: .photoLibrary)!
        picker.modalPresentationStyle = .popover
        return picker
    } ()
    
    let cameraPicker: UIImagePickerController = {
        let picker = UIImagePickerController()
        picker.allowsEditing = false
        picker.sourceType = UIImagePickerController.SourceType.camera
        picker.cameraCaptureMode = .photo //photo or video
        picker.cameraDevice = .front // cam truoc
        picker.modalPresentationStyle = .fullScreen
        return picker
    } ()
    
    let videoPicker: UIImagePickerController = {
        let picker = UIImagePickerController()
        picker.allowsEditing = false
        picker.sourceType = .camera
        picker.cameraDevice = .rear
        picker.modalPresentationStyle = .fullScreen
        picker.mediaTypes = ["public.movie"]
        picker.videoQuality = .typeMedium
        picker.cameraCaptureMode = .video
        picker.videoMaximumDuration = 15;
        return picker
    } ()
    
    let datePicker: UIDatePicker = {
        let picker = UIDatePicker()
        picker.preferredDatePickerStyle = .inline
        picker.datePickerMode = .date
        picker.locale = Locale(identifier: "vi")
        picker.backgroundColor = .white
        return picker
    } ()
    
    let formatter: DateFormatter = {
        let formatter = DateFormatter()
        formatter.dateFormat = "dd/MM/yyyy"
        formatter.locale = Locale(identifier: "vi")
        return formatter
    } ()
    
    var toDoList: ToDoList = ToDoList(todo: "", isDone: false, expired: "")
    var index: Int?
    
    var handleSave: ((ToDoList) -> Void)?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupUI()
    }
    
    func setupUI() {
        if index == nil {
            buttonSave.backgroundColor = .green
            buttonSave.titleLabel?.text = "Thêm mới"
        } else {
            buttonSave.backgroundColor = .cyan
            buttonSave.titleLabel?.text = "Cập nhật"
            
            toDoTextView.text = toDoList.todo
            expiredTextField.text = toDoList.expired
            isDoneSwitch.isOn = toDoList.isDone
            
            datePicker.date = formatter.date(from: toDoList.expired) ?? Date()
            
            if toDoList.imagePath.count > 0 {
                chooseImageView.image = UIImage(contentsOfFile: toDoList.imagePath)
            }
            if toDoList.videoPath.count > 0 {
                chooseVideoView.image = UIImage(named: "video-player")
            }
            
        }
        //toDoTextView.becomeFirstResponder()
        
        datePicker.addTarget(self, action: #selector(handleDateChange), for: .valueChanged)
        
        expiredTextField.inputView = datePicker
        
        libraryPicker.delegate = self
        cameraPicker.delegate = self
        videoPicker.delegate = self
        
        chooseImageView.isUserInteractionEnabled = true
        let imageTapGesture = UITapGestureRecognizer(target: self, action: #selector(actionChooseImage))
        chooseImageView.addGestureRecognizer(imageTapGesture)
        
        chooseVideoView.isUserInteractionEnabled = true
        let videoTapGesture = UITapGestureRecognizer(target: self, action: #selector(actionChooseVideo))
        chooseVideoView.addGestureRecognizer(videoTapGesture)
    }

    @IBAction func actionSaveButton(_ sender: UIButton) {
        toDoList.todo = toDoTextView.text ?? ""
        toDoList.expired = expiredTextField.text ?? ""
        toDoList.isDone = isDoneSwitch.isOn
        
        handleSave?(toDoList)
        
        navigationController?.popToRootViewController(animated: true)
    }
    
    @objc func handleDateChange() {
        expiredTextField.text = formatter.string(from: datePicker.date)
        view.endEditing(true)
    }
    
    @objc func actionChooseImage() {
        let alert = UIAlertController(title: "Chọn ảnh từ", message: "", preferredStyle: .alert)
        
        let actionCamera = UIAlertAction(title: "Máy ảnh", style: .default) { [weak self] _ in
            guard let `self` = self else {
                return
            }
            self.imageFromCamera()
        }
        
        let actionLibrary = UIAlertAction(title: "Thư viện", style: .default) { [weak self] _ in
            guard let `self` = self else {
                return
            }
            self.imageFromLibrary()
        }
        
        let actionCancel = UIAlertAction(title: "Cancel", style: .cancel)
        
        alert.addAction(actionCamera)
        alert.addAction(actionLibrary)
        alert.addAction(actionCancel)
        
        present(alert, animated: true, completion: nil)
    }
    
    @objc func actionChooseVideo() {
        print("OK")
        let alert = UIAlertController(title: "Chọn video từ", message: "", preferredStyle: .alert)
        
        let actionCamera = UIAlertAction(title: "Máy quay", style: .default) { [weak self] _ in
            guard let `self` = self else {
                return
            }
            self.videoFromCamera()
        }
        
        let actionLibrary = UIAlertAction(title: "Thư viện", style: .default) { [weak self] _ in
            guard let `self` = self else {
                return
            }
            self.videoFromLibrary()
        }
        
        let actionCancel = UIAlertAction(title: "Cancel", style: .cancel)
        
        alert.addAction(actionCamera)
        alert.addAction(actionLibrary)
        alert.addAction(actionCancel)
        
        present(alert, animated: true, completion: nil)
    }
    
    func imageFromLibrary() {
        func choosePhoto() {
            DispatchQueue.main.async {[weak self] in
                guard let `self` = self else {
                    return
                }
                self.present(self.libraryPicker, animated: true)
            }
        }
        PHPhotoLibrary.requestAuthorization(for: .readWrite) {[weak self] status in
            guard let `self` = self else {
                return
            }
             
            print(status.rawValue)
            if status == PHAuthorizationStatus.authorized {
                choosePhoto()
            } else if status == PHAuthorizationStatus.limited {
                choosePhoto()
            } else {
                print("App không có quyền truy cập thư viện ảnh.")
                
                DispatchQueue.main.async {
                    self.setting()
                }
            }
        }
    }
    
    func imageFromCamera() {
        func takePhoto() {
            if UIImagePickerController.isSourceTypeAvailable(.camera) {
                // co camera
                DispatchQueue.main.async {
                    self.present(self.cameraPicker, animated: true)
                }
            } else {
                let alert = UIAlertController(title: "Thông báo", message: "Không tìm thấy máy ảnh", preferredStyle: .alert)
                let actionOk = UIAlertAction(title: "Ok", style: .default)
                alert.addAction(actionOk)
                present(alert, animated: true)
            }
        }
        AVCaptureDevice.requestAccess(for: .video) {[weak self] isHasPermission in
            guard let `self` = self else {
                return
            }
            if isHasPermission {
                takePhoto()
            } else {
                DispatchQueue.main.async {
                    self.setting()
                }
            }
        }
    }
    
    func videoFromLibrary() {
        imageFromLibrary()
    }
    
    func videoFromCamera() {
        func takePhoto() {
            if UIImagePickerController.isSourceTypeAvailable(.camera) {
                // co camera
                DispatchQueue.main.async { [weak self] in
                    guard let `self` = self else {
                        return
                    }
                    self.present(self.videoPicker, animated: true)
                }
            } else {
                let alert = UIAlertController(title: "Thông báo", message: "Không tìm thấy máy ảnh", preferredStyle: .alert)
                let actionOk = UIAlertAction(title: "Ok", style: .default)
                alert.addAction(actionOk)
                present(alert, animated: true)
            }
        }
        AVCaptureDevice.requestAccess(for: .video) {[weak self] isHasPermission in
            guard let `self` = self else {
                return
            }
            if isHasPermission {
                takePhoto()
            } else {
                DispatchQueue.main.async {
                    self.setting()
                }
            }
        }
    }
    
    
    // tạo một cái alert dùng chung, chức năng confirm, chỉ có một nút ok
    func confirm(message: String, viewController: UIViewController, onSuccess: @escaping () -> Void) {
        let alertAction = UIAlertController(title: "App", message: message, preferredStyle: .alert)
        let action = UIAlertAction(title: "OK", style: .default) { _ in
            onSuccess()
        }
        alertAction.addAction(action)
        present(alertAction, animated: true, completion: nil)
    }
    
    // mở setting của điện thoại
    func setting() {
        let message = "App cần quyền truy cập camera và thư viện ảnh"
        confirm(message: message, viewController: self) {
            guard let settingUrl = URL(string: UIApplication.openSettingsURLString) else {
                return
            }
            
            if UIApplication.shared.canOpenURL(settingUrl) {
                UIApplication.shared.open(settingUrl)
            }
        }
        
    }
}

extension EditToDoListViewController: UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        
        // xu ly sau khi quay video
        if let mediaURL = info[UIImagePickerController.InfoKey.mediaURL] as? URL {
            //UISaveVideoAtPathToSavedPhotosAlbum(mediaURL.path, self, nil, nil)
            
            let videoPath = saveVideoToDocument(mediaURL)
            
            toDoList.videoPath = videoPath
            
            self.chooseVideoView.image = UIImage(named: "video-player")
            dismiss(animated: true)
        }

        // xu ly sau khi chup anh
        if let selectedImage = info[.originalImage] as? UIImage {
            
            let imagePath = saveImageToDocument(selectedImage)
            
            toDoList.imagePath = imagePath
            
            self.chooseImageView.image = UIImage(contentsOfFile: imagePath)
            
            //UIImageWriteToSavedPhotosAlbum(selectedImage, self, nil, nil)
        }
        
        dismiss(animated: true)
    }
    
    func saveImageToDocument(_ image: UIImage) -> String {
        
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy_MM_dd_HH_mm_ss"
        let fileName = dateFormatter.string(from: Date())
        
        let imageData = image.pngData()
        
        let docDir = try! FileManager.default.url(for: .documentDirectory, in: .userDomainMask, appropriateFor: nil, create: true)
        
        let saveURL = docDir.appendingPathComponent("image\(fileName).png")
        
        try! imageData?.write(to: saveURL)

        return saveURL.path
    }
    func saveVideoToDocument(_ videoUrl: URL) -> String {
        
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy_MM_dd_HH_mm_ss"
        let fileName = dateFormatter.string(from: Date())
        
        let videoData = try! Data(contentsOf: videoUrl)
        
        let docDir = try! FileManager.default.url(for: .documentDirectory, in: .userDomainMask, appropriateFor: nil, create: true)
        
        let saveURL = docDir.appendingPathComponent("video\(fileName).mov")
        
        try! videoData.write(to: saveURL)

        return saveURL.path
    }
}
