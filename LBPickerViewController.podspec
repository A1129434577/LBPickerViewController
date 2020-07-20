Pod::Spec.new do |spec|
  spec.name         = "LBPickerViewController"
  spec.version      = "1.0.0"
  spec.summary      = "单项选择器"
  spec.description  = "一个简单的快速可集成单项选择器。"
  spec.homepage     = "https://github.com/A1129434577/LBPickerViewController"
  spec.license      = { :type => "MIT", :file => "LICENSE" }
  spec.author       = { "刘彬" => "1129434577@qq.com" }
  spec.platform     = :ios
  spec.ios.deployment_target = '8.0'
  spec.source       = { :git => 'https://github.com/A1129434577/LBPickerViewController.git', :tag => spec.version.to_s }
  spec.dependency     "LBPresentTransitions"
  spec.source_files = "LBPickerViewController/**/*.{h,m}"
  spec.requires_arc = true
end
#--use-libraries
