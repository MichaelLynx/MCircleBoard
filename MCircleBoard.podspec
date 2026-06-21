@version = "2.0.1"
Pod::Spec.new do |s|
s.name = "MCircleBoard"
s.version = @version
s.summary = "MCircleBoard"
s.description = "A circular scale chart that allows users to set the number, color, and direction of the scales."
s.homepage = "https://github.com/MichaelLynx/MCircleBoard"
s.license = { :type => "MIT", :file => "LICENSE" }
s.author = { "Lynx" => "blacksage@icloud.com" }
s.platform = :ios
s.ios.deployment_target = "15.0"
s.source = { :git => "https://github.com/MichaelLynx/MCircleBoard.git", :tag => "v#{s.version}" }
s.source_files = "Code/*.swift"
s.resources = ["Code/MCircleBoard.bundle"]
s.swift_version = "5.0"
s.requires_arc = true
s.framework = "UIKit"

end
