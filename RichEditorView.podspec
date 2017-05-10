#
#  Be sure to run `pod spec lint RichEditorView.podspec' to ensure this is a
#  valid spec and to remove all comments including this before submitting the spec.
#
#  To learn more about Podspec attributes see http://docs.cocoapods.org/specification.html
#  To see working Podspecs in the CocoaPods repo see https://github.com/CocoaPods/Specs/
#

Pod::Spec.new do |s|

  s.name         = "RichEditorView"
  s.version      = "0.0.1"
  s.summary      = "RichEditorView"
  s.description  = <<-DESC
                    RichEditorView use WKWebView
                   DESC

  s.homepage     = "https://github.com/ChengGC/RichEditorView"
  # s.screenshots  = "www.example.com/screenshots_1.gif", "www.example.com/screenshots_2.gif"
  s.license      = { :type => "MIT", :file => "FILE_LICENSE" }
  s.author             = { "Chang" => "79795877@qq.com" }
  s.platform     = :ios, "8.0"


  s.source       = { :git => "https://github.com/ChengGC/RichEditorView.git", :tag => "#{s.version}" }
  s.source_files  = "Classes", "Sources/*"
  s.resources = [
      'Resources/icons/*',
      'Resources/editor/*'
    ]


  s.requires_arc = true

end
