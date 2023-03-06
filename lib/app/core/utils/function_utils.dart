class FunctionUtils {
  static String? validatorNotNull(String? value) {
    if (value == null || value.isEmpty) {
      return 'Không được để trống';
    }
    return null;
  }

  static String? validatorPhone(String? value) {
    if (value == null || value.isEmpty) {
      return 'Không được để trống';
    } else if (value.length < 10) {
      return 'Số điện thoại không hợp lệ';
    }
    return null;
  }
}
