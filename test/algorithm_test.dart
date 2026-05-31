import 'package:flutter_test/flutter_test.dart';
import 'package:fsdui/src/algorithm/claude-generated/algorithm_to_svg.dart';

void main() {
  group('Algorithm Validation Tests', () {
    test('Valid algorithm parses successfully', () async {
      final valid = {
        'name': 'Test Algorithm',
        'description': 'A simple test description',
        'steps': [
          {
            'type': 'Action',
            'txt': 'Execute step one',
          }
        ]
      };
      
      final result = await validateAlgorithm(valid);
      expect(result.isValid, isTrue);
      expect(result.errors, isEmpty);
    });

    test('Invalid algorithm fails validation with errors', () async {
      final invalid = {
        'name': 'Missing description and steps',
      };
      
      final result = await validateAlgorithm(invalid);
      expect(result.isValid, isFalse);
      expect(result.errors, isNotEmpty);
      print('Captured Errors: ${result.errors}');
    });
  });
}
