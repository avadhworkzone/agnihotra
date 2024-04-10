class ValidationMsg{
  static String latitudeIsRequired = "Latitude is required";
  static String validLatitude = "Enter Valid Latitude";
  static String  longitudeIsRequired = "Longitude is required";
  static String validLongitude = "Enter Valid Latitude";

}

class ValidationMethod{

  static String? latitudeValidation(String? value) {
    if (value == null || value.isEmpty) {
      return ValidationMsg.latitudeIsRequired;
    }else {
      return null;
    }
  }

  static String? longitudeValidation(String? value) {
    if (value == null || value.isEmpty) {
      return ValidationMsg.longitudeIsRequired;
    } else {
      return null;
    }
  }

}