import 'package:process_run/shell.dart';
import "package:path/path.dart" as p;
import 'dart:io';

void main(List<String> args) async {
  var shell = Shell();
  var location = Platform.script.toFilePath(windows: Platform.isWindows);
  var rootDirPath =
      p.join(p.dirname(location), ".." + p.separator + ".." + p.separator);
  var cacheDirPath =
      p.join(rootDirPath, ".." + p.separator + "cache" + p.separator);
  var cacheDir = Directory(cacheDirPath);
  var cacheZoomDirPath = "";
  await cacheDir.list(recursive: false).forEach((f) {
    var name = p.basename(f.path);
    if (name.startsWith("flutter_zoom")) {
      cacheZoomDirPath = f.path;
    }
  });
  Directory.current = cacheZoomDirPath;
  await shell.run("git lfs install --local --skip-smudge && git lfs pull");
  Directory.current = rootDirPath;
  await shell.run("git lfs pull");
  // await shell.run('''
  // cd  $cacheZoomDirPath  &&  git lfs pull
  // cd  $rootDirPath  &&  git lfs pull
  // ''');
}
