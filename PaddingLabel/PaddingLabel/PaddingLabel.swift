//
//  PaddingLabel.swift
//  PaddingLabel
//
//  Created by LAP12230 on 3/23/20.
//  Copyright © 2020 LAP12230. All rights reserved.
//

import UIKit

//@propertyWrapper
//@objc_Association
//Generic class:
// protocol EntityProtocol
// protocol DBService<EntityProtocol> { write() -> ? , read() -> ? }
// CoreDataService: DBService -> ....... <=> CoreDataEntity
// CustomDBService:

//2 entity: UserEntity, GroupEntity
//2 service: UserService, GroupService

class PaddingLabel: UILabel {
    
    public var textInsets: UIEdgeInsets = UIEdgeInsets.zero {
        didSet {
            self.setNeedsDisplay()
        }
    }
    
    // MARK: - Overrided Methods
    
    override var intrinsicContentSize: CGSize {
        let size = super.intrinsicContentSize
        return CGSize(width: size.width + self.textInsets.left + self.textInsets.right,
                      height: size.height + self.textInsets.top + self.textInsets.bottom)
    }
    
    
    override func sizeThatFits(_ size: CGSize) -> CGSize {
        let contentSize = super.sizeThatFits(CGSize(width: size.width - self.textInsets.left - self.textInsets.right,
                                                    height: size.height - self.textInsets.top - self.textInsets.bottom))
        
        return CGSize(width: contentSize.width + self.textInsets.left + self.textInsets.right,
                      height: contentSize.height + self.textInsets.top + self.textInsets.bottom)
    }
    
    
    override func drawText(in rect: CGRect) {
        let rectWithInsets = rect.inset(by: self.textInsets)
        super.drawText(in: rectWithInsets)
    }
    
}
