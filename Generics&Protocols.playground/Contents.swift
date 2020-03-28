import UIKit

enum Color {
    case black
    case white
}

enum Size {
    case small
    case big
}

protocol Colored {
    var color: Color { get set }
}

protocol Sized {
    var size: Size { get set }
}

protocol Specification {
    associatedtype ItemType
    func isValid(item: ItemType) -> Bool
}

protocol Filter {
    associatedtype ItemType
    func filter<Spec: Specification>(items: [ItemType], specs: Spec) -> [ItemType]
        where Spec.ItemType == ItemType
}

struct GenericFilter<ItemType>: Filter {
    func filter<Spec: Specification>(items: [ItemType], specs: Spec) -> [ItemType]
        where ItemType == Spec.ItemType {
            
            var output = [ItemType]()
            for item in items {
                if (specs.isValid(item: item)) {
                    output.append(item)
                }
            }
            return output
    }
}

struct ColorSpec<T: Colored>: Specification {
    var color: Color
    
    func isValid(item: T) -> Bool {
        return item.color == self.color
    }
}

struct SizeSpec<T: Sized>: Specification {
    var size: Size
    
    func isValid(item: T) -> Bool {
        return item.size == self.size
    }
}

class Product {
    var color: Color = .black
    var size: Size = .big
}
