import SwiftUI
import AVFoundation

@Observable
class ScannerViewModel {
    var scannedBarcode: String?
    var foundProduct: Product?
    var isSearching = false
    var showNotFound = false

    func lookupBarcode(_ barcode: String) {
        scannedBarcode = barcode
        isSearching = true
        showNotFound = false

        foundProduct = LocalStorageService.shared.getProductByBarcode(barcode)
        if foundProduct == nil {
            showNotFound = true
        }

        isSearching = false
    }

    func reset() {
        scannedBarcode = nil
        foundProduct = nil
        isSearching = false
        showNotFound = false
    }
}
