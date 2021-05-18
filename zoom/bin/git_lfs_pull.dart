import 'package:process_run/shell.dart';

void main(List<String> args) async {
  var shell = Shell();

  await shell.run('''
    git lfs pull
  ''');
}
