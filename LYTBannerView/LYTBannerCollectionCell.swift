//
//  LYTBannerCollectionCell.swift
//  Sswift
//
//  Created by 刘云天 on 2021/4/15.
//  Copyright © 2021 刘云天. All rights reserved.
//

import UIKit

class LYTBannerCollectionCell: UICollectionViewCell {
    
    var bannerImage = UIImageView()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        let image = UIImageView()
        image.contentMode = .scaleAspectFill
        image.clipsToBounds = true
        self.bannerImage = image
        self.contentView.addSubview(image)
    }
    
    func configuarWithImg(urlStr:String){
        self.bannerImage.image = UIImage(named: urlStr)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        
        self.bannerImage.frame = self.bounds
    }
}
