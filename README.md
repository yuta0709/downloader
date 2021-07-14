# downloader
A simple file downloader

## Usage

```dart
void progressCallback(double progress) {
  print(progress * 100);
}

void doneCallback() {
  print('Done');
}

void main(List<String> arguments) {
  final url = 'url_to_file';
  final fileName = 'path_to_file';
  final downloader = Downloder(
      url, fileName, progressCallback, doneCallback, Duration(seconds: 1));
  downloader.download();
```