String? emptyFieldValidator(String? value) {
  if (value == null || value.trim().isEmpty) {
    return "هذا الحقل مطلوب";
  }
  return null;
}