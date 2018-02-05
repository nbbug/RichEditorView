//
//  ViewController.swift
//  RichEditorView
//
//  Created by chang on 2017/5/10.
//  Copyright © 2017年 cgc. All rights reserved.
//

import UIKit
import ZLPhotoBrowser


class ViewController: UIViewController {
    private var editorView: RichEditorView!
    
    lazy var toolbar: RichEditorToolbar = {
        let toolbar = RichEditorToolbar(frame: CGRect(x: 0, y: 0, width: self.view.bounds.width, height: 44))
        toolbar.options = RichEditorOptions.all()
        return toolbar
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        
        //editorView
        editorView = RichEditorView()
        editorView.placeholder = "正文"
        editorView.delegate = self
        editorView.isScrollEnabled = true
        editorView.webView.scrollView.keyboardDismissMode = .onDrag
        editorView.webView.scrollView.showsVerticalScrollIndicator = false
        editorView.frame = self.view.bounds
        self.view.addSubview(editorView)
        
        editorView.setHtml("<h1>My Awesome Editor</h1>Now I am editing in <em>style.</em>")
        
        //toolbar
        editorView.inputAccessoryView = toolbar
        toolbar.delegate = self
        toolbar.editor = editorView
        
        // We will create a custom action that clears all the input text when it is pressed
        let item = RichEditorOptionItem(image: nil, title: "Clear") { toolbar in
            toolbar?.editor?.setHtml("")
        }

        var options = toolbar.options
        options.append(item)
        toolbar.options = options
    }
    
}

extension ViewController: RichEditorDelegate {
    
    func richEditor(_ editor: RichEditorView, contentDidChange content: String) {
//        if content.isEmpty {
//            htmlTextView.text = "HTML Preview"
//        } else {
//            htmlTextView.text = content
//        }
    }
    
}

extension ViewController: RichEditorToolbarDelegate {
    
    fileprivate func randomColor() -> UIColor {
        let colors: [UIColor] = [
            .red,
            .orange,
            .yellow,
            .green,
            .blue,
            .purple
        ]
        
        let color = colors[Int(arc4random_uniform(UInt32(colors.count)))]
        return color
    }
    
    func richEditorToolbarChangeTextColor(_ toolbar: RichEditorToolbar) {
        let color = randomColor()
        toolbar.editor?.setTextColor(color)
    }
    
    func richEditorToolbarChangeBackgroundColor(_ toolbar: RichEditorToolbar) {
        let color = randomColor()
        toolbar.editor?.setTextBackgroundColor(color)
    }
    
    func richEditorToolbarInsertImage(_ toolbar: RichEditorToolbar) {
//        toolbar.editor?.insertImage(url: "https://gravatar.com/avatar/696cf5da599733261059de06c4d1fe22", alt: "Gravatar")
//        let picker = UIImagePickerController()
//        picker.sourceType = .photoLibrary
//        picker.delegate = self
//        self.present(picker, animated: true, completion: nil)
        
        self.toolbar.editor?.blur()
        
        let p = ZLPhotoActionSheet()
        p.maxSelectCount = 9
        p.selectImageBlock = {(imgs, models, origin) in
//            if imgs.count > 0{
//                for img in imgs{
//                    self.toolbar.editor?.insertImage(img: img, alt: "")
//                }
//            }
            
//            let options: PHContentEditingInputRequestOptions = PHContentEditingInputRequestOptions()
//            options.canHandleAdjustmentData = {(adjustmeta: PHAdjustmentData) -> Bool in
//                return true
//            }
//
//            models[0].requestContentEditingInput(with: options, completionHandler: {[unowned self] (contentEditingInput, info) in
//                let src = contentEditingInput?.fullSizeImageURL?.absoluteString ?? ""
//                if let a = Util.pathForWKWebViewSandboxBugWithOriginalPath(src){
//                    self.toolbar.editor?.insertImage(url: a, alt: "img")
//                }
//            })
            
            
            for img in imgs{
                if let path = Util.pathForImage(image: img){
                    self.toolbar.editor?.insertImage(url: path, alt: "img")
                }
            }
        }
        p.showPreview(animated: true, sender: self)
    }
    
    func richEditorToolbarInsertLink(_ toolbar: RichEditorToolbar) {
        // Can only add links to selected text, so make sure there is a range selection first
        toolbar.editor?.hasRangeSelection({ (hasRangeSelection) in
            if hasRangeSelection == true {
                self.toolbar.editor?.insertLink("http://github.com/cjwirth/RichEditorView", title: "Github Link")
            }
        })
    }
}

extension ViewController: UIImagePickerControllerDelegate, UINavigationControllerDelegate{
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [String : Any]) {
        self.dismiss(animated: true, completion: nil)
        
//        if let img = info[UIImagePickerControllerOriginalImage] as? UIImage{
//            DispatchQueue.main.async(execute: {
//                self.toolbar.editor?.insertImage(img: img, alt: "")
//            })
//        }
        
//        if let url = info[UIImagePickerControllerReferenceURL] as? URL{
//            DispatchQueue.main.async(execute: {
//                if let a = Util.pathForWKWebViewSandboxBugWithOriginalPath(url.absoluteString){
//                    self.toolbar.editor?.insertImage(url: a, alt: "")
//                }
//            })
//        }
    }
}
