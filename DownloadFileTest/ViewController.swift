//
//  ViewController.swift
//  DownloadFileTest
//
//  Created by Fabio De Lorenzo on 1/5/16.
//  Copyright © 2016 Crokky Software Inc. All rights reserved.
// see:
// http://zappdesigntemplates.com/how-to-download-file-with-a-custom-progress-indicator-in-ios/

import UIKit

class ViewController: UIViewController, NSURLSessionDownloadDelegate {

    @IBOutlet var PercText: UITextField!
    
    //private let MY_URL = "https://www.dropbox.com/s/r6lr4zlw12ipafm/SpeedTracker_movie.mov?dl=1"
    private let MY_URL = "http://ipv4.download.thinkbroadband.com/200MB.zip"
    private var downloadTask: NSURLSessionDownloadTask?

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    @IBAction func DownloadAction(sender: AnyObject) {
        print ("DownloadAction")
        createDownloadTask()
    }
    
    func createDownloadTask() {
        let downloadRequest = NSMutableURLRequest(URL: NSURL(string: MY_URL)!)
        let session = NSURLSession(configuration: NSURLSessionConfiguration.defaultSessionConfiguration(), delegate: self, delegateQueue: NSOperationQueue.mainQueue())
        
        downloadTask = session.downloadTaskWithRequest(downloadRequest)
        downloadTask!.resume()
    }

    
    // ______ delegates ____++++++++++
    func URLSession(session: NSURLSession, downloadTask: NSURLSessionDownloadTask, didWriteData bytesWritten: Int64, totalBytesWritten: Int64, totalBytesExpectedToWrite: Int64) {
        //print ("URLSession 1")
        let progress = Float(totalBytesWritten) / Float(totalBytesExpectedToWrite)
        PercText.text = String(progress) + " [Total=" + String(totalBytesWritten) + "|" +
            String(totalBytesExpectedToWrite) + "]"
    }
    
    func URLSession(session: NSURLSession, downloadTask: NSURLSessionDownloadTask, didFinishDownloadingToURL location: NSURL) {
        //print ("URLSession 2")
        PercText.text = "Download finished"
    }
    
    func URLSession(session: NSURLSession, task: NSURLSessionTask, didCompleteWithError error: NSError?) {
        //print ("URLSession 3")
        if let _ = error {
            PercText.text = "Download failed"
        } else {
            PercText.text = "Download finished"
        }
    }
    // ______ delegates ____++++++++++
    
    
    
}

