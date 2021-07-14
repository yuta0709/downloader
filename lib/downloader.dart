import 'dart:io';

typedef DownloaderCallback = void Function(double);
typedef DoneCallback = void Function();

class Downloder {
  int fileSize = 0;
  int downloadedSize = 0;
  double progress = 0;
  String url;
  String fileName;
  DownloaderCallback callback;
  DoneCallback doneCallback;
  DateTime? last;
  bool started = false;
  Duration interval;

  Downloder(
      this.url, this.fileName, this.callback, this.doneCallback, this.interval);

  void download() async {
    final request = await HttpClient().getUrl(Uri.parse(url));
    final response = await request.close();
    fileSize = response.contentLength;
    final file = File(fileName).openWrite();
    response.listen((data) {
      if (!started) {
        last = DateTime.now();
        started = true;
      }
      file.add(data);
      downloadedSize += data.length;
      progress = downloadedSize / fileSize;
      if (DateTime.now().difference(last!).inSeconds >= interval.inSeconds) {
        last = DateTime.now();
        callback(progress);
      }
    }).onDone(() {
      file.close();
      callback(progress);
      doneCallback();
    });
  }
}
