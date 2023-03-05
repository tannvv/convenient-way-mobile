class FunctionUtils {
  static String? validatorNotNull(String? value) {
    if (value == null || value.isEmpty) {
      return 'Không được để trống';
    }
    return null;
  }
}
