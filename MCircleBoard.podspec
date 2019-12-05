@version = "0.0.1"
Pod::Spec.new do |s|
s.name = "MCircleBoard"
s.version = @version
s.summary = "MCircleBoard"
s.description = "MCircleBoard is a dash board."
s.homepage = "https://github.com/whitesage/MCircleBoard"
s.license = { :type => 'MIT', :file => 'LICENSE' }
s.author = { "whitesage" => "1216831710@qq.com" }
s.ios.deployment_target = '8.0'
s.source = { :git => "https://github.com/whitesage/MCircleBoard.git", :tag => "v#{s.version}" }
s.source_files = 'MCircleBoard/Code/*/.{h,m,swift}'
s.requires_arc = true
s.framework = "UIKit"
end