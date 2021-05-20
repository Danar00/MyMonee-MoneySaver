//
//  EmptyDataImpian.swift
//  MyMonee-MoneySaver
//
//  Created by MacBook on 19/05/21.
//

import UIKit

class EmptyDataImpian: UIView {
    
    @IBOutlet var contentView: UIView!
    
    var delegate: EmptyDataDelegate?
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.commonInit()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        self.commonInit()
    }
    
    private func commonInit(){
        Bundle.main.loadNibNamed("EmptyDataImpian", owner: self, options: nil)
        addSubview(contentView)
        contentView.frame = self.bounds
        contentView.autoresizingMask = [.flexibleWidth, .flexibleHeight]
    }
    
    @IBAction func addDataImpian(_ sender: Any) {
        self.delegate?.add()
    }
    
}
