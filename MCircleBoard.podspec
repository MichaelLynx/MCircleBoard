@version = "0.0.6"
Pod::Spec.new do |s|
s.name = "MCircleBoard"
s.version = @version
s.summary = "MCircleBoard"
s.description = "MCircleBoard is a dash board."
s.homepage = "https://github.com/whitesage/MCircleBoard"
s.license = { :type => "MIT", :file => "LICENSE" }
s.author = { "WhiteSage" => "1216831710@qq.com" }
s.platform = :ios
s.ios.deployment_target = "8.0"
s.source = { :git => "https://github.com/whitesage/MCircleBoard.git", :tag => "v#{s.version}" }
s.source_files = "Code/*.swift"
s.resources = ["MCircleBoard.bundle"]
s.swift_version = "4.0"
s.requires_arc = true
s.framework = "UIKit"

end