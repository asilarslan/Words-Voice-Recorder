//
//  ViewController.swift
//  Words Voice Recorder
//
//  Created by Asil Arslan on 2.08.2020.
//  Copyright © 2020 Asil Arslan. All rights reserved.
//

import UIKit
import Zip

class ViewController: UIViewController,AudioRecorderViewControllerDelegate,UITableViewDataSource,UITableViewDelegate {
   
    @IBOutlet var save: UIBarButtonItem!
    @IBOutlet var tableView: UITableView!
    
    var words:[Word] = [Word(word:"Kedi"), Word(word:"Köpek"), Word(word:"Kuş"), Word(word:"At"), Word(word:"İnek"), Word(word:"Yılan"), Word(word:"Aslan"), Word(word:"Kaplan"), Word(word:"Fil"), Word(word: "Balık")]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        save.isEnabled = false
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return words.count
       }
       
       func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
           let cell = tableView.dequeueReusableCell(withIdentifier: WordTableViewCell.reuseIdentifier, for: indexPath)as! WordTableViewCell
        cell.textLabel?.text = words[indexPath.row].word
        if words[indexPath.row].path != nil {
            cell.accessoryType = .checkmark
        }
           return cell
       }
       
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let controller = AudioRecorderViewController()
        controller.audioRecorderDelegate = self
        controller.word = words[indexPath.row]
        present(controller, animated: true, completion: nil)
    }

 
    
    func audioRecorderViewControllerDismissed(withFileURL fileURL: URL?) {
        dismiss(animated: true, completion: nil)
        tableView.reloadData()
        if checkComplete() {
            save.isEnabled = true
        }
    }
    
    
    @IBAction func saveAction(_ sender: Any) {
        zipFile()
    }
    
    func checkComplete() -> Bool{
        for word in words {
            if word.path == nil {
                return false
            }
        }
        return true
    }
    
    func zipFile() {

        do {
            var paths:[URL] = []
            for word in words {
                paths.append(word.path!)
            }
            let zipFilePath = try Zip.quickZipFiles(paths, fileName: "archive") // Zip
        
            print(zipFilePath.absoluteString)

        
        var filesToShare = [Any]()

        // Add the path of the file to the Array
        filesToShare.append(zipFilePath)

        // Make the activityViewContoller which shows the share-view
        let activityViewController = UIActivityViewController(activityItems: filesToShare, applicationActivities: nil)

        // Show the share-view
        self.present(activityViewController, animated: true, completion: nil)
            }
            catch {
              print("Something went wrong")
            }
    }
}

