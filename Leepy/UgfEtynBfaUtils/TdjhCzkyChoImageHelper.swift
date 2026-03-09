import PhotosUI
import SwiftUI
import UIKit

struct MediaPicker: UIViewControllerRepresentable {

  var selectionLimit: Int = 1
  var onPicked: (UIImage) -> Void

  func makeUIViewController(context: Context) -> PHPickerViewController {
    var config = PHPickerConfiguration(photoLibrary: .shared())
    config.filter = .images
    config.selectionLimit = selectionLimit

    let picker = PHPickerViewController(configuration: config)
    picker.delegate = context.coordinator
    return picker
  }

  func updateUIViewController(
    _ uiViewController: PHPickerViewController,
    context: Context
  ) {}

  func makeCoordinator() -> Coordinator {
    Coordinator(self)
  }

  final class Coordinator: NSObject, PHPickerViewControllerDelegate {

    let parent: MediaPicker

    init(_ parent: MediaPicker) {
      self.parent = parent
    }

    func picker(
      _ picker: PHPickerViewController,
      didFinishPicking results: [PHPickerResult]
    ) {
      picker.dismiss(animated: true)

      guard let result = results.first else { return }

      result.itemProvider.loadObject(ofClass: UIImage.self) { object, _ in
        guard let image = object as? UIImage else { return }
        DispatchQueue.main.async {
          self.parent.onPicked(image)
        }
      }
    }
  }
}

func saveImageToDocuments(image: UIImage, prefix: String) -> URL? {
  let timestamp = Int(Date().timeIntervalSince1970)
  let fileName = "\(prefix)_\(timestamp).jpg"

  guard let data = image.jpegData(compressionQuality: 0.8) else { return nil }

  do {
    let documents = try FileManager.default.url(
      for: .documentDirectory,
      in: .userDomainMask,
      appropriateFor: nil,
      create: true
    )
    let fileURL = documents.appendingPathComponent(fileName)
    try data.write(to: fileURL)
    return fileURL
  } catch {
    print("保存图片失败:", error)
    return nil
  }
}
