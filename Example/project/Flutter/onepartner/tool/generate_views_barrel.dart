import 'dart:io';

/// Generates a barrel file for all Dart files under lib/views/**.
/// Output: lib/views/views.dart
/// This helps import all pages/widgets from the views directory via a single import.
void main() async {
  final viewsDir = Directory('lib/views');
  final outputFile = File('lib/views/views.dart');

  if (!viewsDir.existsSync()) {
    stderr.writeln('Directory not found: lib/views');
    exit(1);
  }

  final exports = <String>{};

  await for (final entity in viewsDir.list(recursive: true, followLinks: false)) {
    if (entity is File && entity.path.endsWith('.dart')) {
      final path = entity.path.replaceAll('\\', '/');

      // Skip generated files, the barrel itself, and internal widget directories if needed.
      if (path.endsWith('.g.dart') || path.endsWith('.gr.dart') ||
          path.endsWith('lib/views/views.dart')) {
        continue;
      }

      // Optionally skip files under widgets/ if you only want pages.
      // Comment the next line out if you want to include widgets too.
      // if (path.contains('/widgets/')) continue;

      final relativeLibPath = path.startsWith('lib/') ? path.substring(4) : path;
      exports.add("export 'package:onepartner/$relativeLibPath';");
    }
  }

  final sortedExports = exports.toList()..sort();

  final header = '// GENERATED: Do not edit manually.\n'
      '// Run: dart run tool/generate_views_barrel.dart\n';
  final contents = StringBuffer()
    ..writeln(header)
    ..writeln()
    ..writeln(sortedExports.join('\n'))
    ..writeln();

  outputFile.createSync(recursive: true);
  await outputFile.writeAsString(contents.toString());
  stdout.writeln('Wrote ${sortedExports.length} exports to ${outputFile.path}');
}