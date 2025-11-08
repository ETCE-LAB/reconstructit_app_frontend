import 'package:analyzer/dart/element/element.dart';
import 'package:build/build.dart';
import 'package:source_gen/source_gen.dart';

import 'annotations.dart';

class MeasureCpuActiveTimeGenerator
    extends GeneratorForAnnotation<MeasureCpuActiveTime> {
  @override
  generateForAnnotatedElement(
    Element element,
    ConstantReader annotation,
    BuildStep buildStep,
  ) {

    print("start generating");
    if (element is! ClassElement) {
      print("FEHLER");
      throw InvalidGenerationSourceError(
        '@MeasureCpuActiveTime kann nur auf Klassen angewendet werden.',
        element: element,
      );
    }
    final generatedClassName = "MeasureCpuActiveTime${element.name}";
    // generate the code inside the buffer
    final buffer = StringBuffer();
    buffer.writeln("class $generatedClassName extends ${element.name} {");
    buffer.writeln("  final CPUActiveTImePlatformChannel channel;");
    buffer.writeln("  final ${element.name} _inner;");
    buffer.writeln("  $generatedClassName(this.channel, this._inner);");

    // generate the code for all non static public methods
    for (final method in element.methods.where(
      (m) => m.isPublic && !m.isStatic,
    )) {
      final name = method.name;
      final returnType = method.returnType.getDisplayString();

      final nameAndTypeParams = method.formalParameters
          .map((p) {
            final type = p.type.getDisplayString();
            final name = p.name;
            return '$type $name';
          })
          .join(', ');

      final nameParams = method.formalParameters.map((p) => p.name).join(', ');

      buffer.writeln('  @override');
      buffer.writeln('  $returnType $name($nameAndTypeParams) async {');
      buffer.writeln('    final start = await channel.getCPUTime();');
      if (returnType != 'void' && !returnType.endsWith('>')) {
        buffer.writeln('    final result = _inner.$name($nameParams);');
        buffer.writeln('    final end = await _getCpuTime();');
        buffer.writeln('    print("CPU time for $name: \${end - start}");');
        buffer.writeln('    return result;');
      } else {
        buffer.writeln('    await _inner.$name($nameParams);');
        buffer.writeln('    final end = await channel.getCpuTime();');
        buffer.writeln('    print("CPU time for $name: \${end - start}");');
      }
      buffer.writeln('  }');
    }

    buffer.writeln('}');
    print("retunr now");
    return buffer.toString();
  }
}

Builder measureCpuActiveTimeBuilder(BuilderOptions options) =>
    LibraryBuilder(
      MeasureCpuActiveTimeGenerator(),
    generatedExtension: ".measures.dart");
