//
//  ViewController.swift
//  RichEditorView
//
//  Created by chang on 2017/5/10.
//  Copyright © 2017年 cgc. All rights reserved.
//

import UIKit

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
        toolbar.editor?.insertImage("https://gravatar.com/avatar/696cf5da599733261059de06c4d1fe22", alt: "Gravatar")
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
