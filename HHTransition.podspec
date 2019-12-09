Pod::Spec.new do |s|
  s.name         = 'HHTransition' 
  s.version      = '2.0.1'
  s.summary      = 'Transition'
  s.description  = 'Mainstream transition animation'
  s.homepage     = 'https://github.com/yuwind/HHTransition/wiki'
  s.license      = 'MIT'
  s.author       = { '豫风' => '991810133@qq.com' }
  s.platform     = :ios, '8.0'
  s.source       = { :git => "https://github.com/yuwind/HHTransition.git", :tag => s.version}
  s.source_files = 'HHTransition/*.{h,m}'
  s.requires_arc = true

end
