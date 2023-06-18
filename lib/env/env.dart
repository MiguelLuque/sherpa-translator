import 'package:envied/envied.dart';

part 'env.g.dart';

@Envied(path: '.env')
abstract class Env {
  @EnviedField(varName: 'OPENAI_KEY', obfuscate: true)
  static String openaiKey = _Env.openaiKey;
  @EnviedField(varName: 'APP_NAME')
  static const String appName = _Env.appName;
}
