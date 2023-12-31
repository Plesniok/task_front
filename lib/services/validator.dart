class Validator {
  static validate({String? value, List<String? Function(dynamic)> validators = const []}) {
    for (var validator in validators) {
      var error = validator(value);
      if (error != null) {
        return error;
      }
    }
    return null;
  }

  static String? required(value) {
    if (value == null || value == "null" || value.toString().isEmpty) {
      return 'Pole nie może być puste';
    }
    return null;
  }

  static String? isEmail(value) {
    if (value == null || value.toString().isEmpty) {
      return null;
    } else {
      if (!RegExp(r"^[\w.-]+@[a-zA-Z0-9-]+(\.[a-zA-Z]{2,})+$").hasMatch(value)) {
        return 'Niepoprawny adres email';
      }
    }
    return null;
  }

  static String? isCorrectNewPassword(value) {
    if (value == null || value.toString().isEmpty) {
      return null;
    } else {
      if (!RegExp(r'^(?=.*?[A-Z])(?=.*?[a-z])(?=.*?[0-9])(?=.*?[\W_]).{8,}$').hasMatch(value)) {
        return 'Zły format hasła (min. 8 znaków przynajmniej jedna duza litera i znak specjalny)';
      }
    }
    return null;
  }
}
