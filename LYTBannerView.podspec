
Pod::Spec.new do |spec|

  spec.name         = "LYTBannerView"
  spec.version      = "1.0.2"
  spec.summary      = "LYTBannerView-for-swift"
  spec.description  = <<-DESC
            UICollectionView实现无限滚动，取余方式对应数据源，block和delegate两种回调方式
                   DESC

  spec.homepage     = "https://github.com/lyt1123/LYTBannerView"
  spec.license      = "MIT"
  spec.author             = { "刘云天" => "lyt112356@163.com" }
  spec.source       = { :git => "https://github.com/lyt1123/LYTBannerView.git", :tag => "#{spec.version}" }

  spec.source_files  = "LYTBannerView","LYTBannerView/*.{swift}"
  spec.exclude_files = "Classes/Exclude"

  spec.platform = :ios,'9.0'
  spec.swift_versions = '4.2'
  
end
