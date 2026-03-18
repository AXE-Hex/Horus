import 'package:hue/core/config/build_config.dart';

void main() {
    print('Testing traceabilityKey...');
    try {
        final key = BuildConfig.traceabilityKey;
        print('Key: $key');
    } catch(e, st) {
        print('Error: $e');
        print(st);
    }
}
