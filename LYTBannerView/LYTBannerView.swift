//
//  LYTBannerView.swift
//  Sswift
//
//  Created by 刘云天 on 2021/4/15.
//  Copyright © 2021 刘云天. All rights reserved.
//

import UIKit

@objc protocol LYTBannerViewDelegate {
    
    @objc optional func bannerViewScroll(bannerView:LYTBannerView,index:Int)
}

class LYTBannerView: UIView,
                     UICollectionViewDelegate,
                     UICollectionViewDataSource,
                     UICollectionViewDelegateFlowLayout,
                     LYTBannerViewDelegate{
    
    var dataArray = Array<String>()
    var currectIndex : Int{
        get{
            self.pageControll.currentPage
        }
    }
    var tapBlock : ((Int) -> ())?
    var timeInterval = 3.0
    var delegate:LYTBannerViewDelegate!
    
    private var collectionView : UICollectionView!
    private var pageControll : UIPageControl!
    private var currentPage : Int = 0
    private var timer : Timer!
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        let layout = UICollectionViewFlowLayout()
        layout.itemSize = self.frame.size
        layout.minimumLineSpacing = 0
        layout.minimumInteritemSpacing = 0
        layout.scrollDirection = .horizontal
        
        collectionView = UICollectionView.init(frame: self.frame, collectionViewLayout: layout)
        collectionView.dataSource = self
        collectionView.delegate = self
        collectionView.isPagingEnabled = true
        collectionView.bounces = false
        collectionView.showsHorizontalScrollIndicator = false
        collectionView.register(LYTBannerCollectionCell.self, forCellWithReuseIdentifier: "LYTBannerViewCell")
        self.addSubview(collectionView)
        
        pageControll = UIPageControl.init(frame:CGRect(x: 0, y: frame.size.height - 40, width: frame.size.width, height: 40))
        pageControll.pageIndicatorTintColor = UIColor.white
        pageControll.currentPageIndicatorTintColor = UIColor.red
        pageControll.isEnabled = false
        pageControll.hidesForSinglePage = true
        self.addSubview(pageControll)
    }
    
    func reloadBannerView(dataArray:Array<String>) {
        self.dataArray = dataArray
        pageControll.numberOfPages = dataArray.count > 1 ? dataArray.count:0
        pageControll.currentPage = 0
        currentPage = 0
        collectionView.reloadData()
        
        if (dataArray.count < 2) { return }
        
        collectionView.scrollsToTop = true
        currentPage = 0
        initialTimer()
    }
    
    func initialTimer() {
        if timer != nil { timer.invalidate() }
        timer = Timer.scheduledTimer(timeInterval: timeInterval, target: self, selector: #selector(nextPage(timer:)), userInfo: nil, repeats: true)
        RunLoop.current.add(timer, forMode: .common)
        
        timer.tolerance = 0.2
        timer.fire()
    }
    
    @objc func nextPage(timer:Timer) {
        if (dataArray.count < 2) { return }
        currentPage += 1
        collectionView.scrollToItem(at: IndexPath.init(item: currentPage, section: 0), at: .left, animated: true)
        pageControll.currentPage = currentPage % dataArray.count
        
        if (delegate != nil)
        {
            delegate.bannerViewScroll?(bannerView: self, index: currectIndex)
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return dataArray.count > 1 ? 99999 : dataArray.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "LYTBannerViewCell", for: indexPath) as! LYTBannerCollectionCell
        cell.configuarWithImg(urlStr: dataArray[indexPath.item % dataArray.count])
        return cell
    }
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        if tapBlock != nil{
            tapBlock!(indexPath.item % dataArray.count)
        }
    }
    
    func scrollViewDidEndDecelerating(_ scrollView: UIScrollView) {
        currentPage = Int(scrollView.contentOffset.x / self.frame.size.width)
        pageControll.currentPage = currentPage % dataArray.count
        
        if (delegate != nil)
        {
            delegate.bannerViewScroll?(bannerView: self, index: currectIndex)
        }
    }
    
    func scrollViewWillBeginDragging(_ scrollView: UIScrollView) {
        // 暂停定时器
        timer.fireDate = Date.distantFuture
    }
    
    func scrollViewDidEndDragging(_ scrollView: UIScrollView, willDecelerate decelerate: Bool) {
        // 3秒后回复
        timer.fireDate = Date(timeIntervalSinceNow: 3.0)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
