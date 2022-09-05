
String validateEmail(String? value) {
  late String _msg;
  RegExp regex = new RegExp(
      r'^(([^<>()[\]\\.,;:\s@\"]+(\.[^<>()[\]\\.,;:\s@\"]+)*)|(\".+\"))@((\[[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\])|(([a-zA-Z\-0-9]+\.)+[a-zA-Z]{2,}))$');
  if (value!.isEmpty) {
    _msg = "Email Tidak Boleh Kosong";
  } else if (!regex.hasMatch(value)) {
    _msg = "Tolong Isi Email Yang Benar";
  }else{
    _msg = "Benar";
  }
  return _msg;
}
String validateNama(String? value) {
  late String _msg;
  if (value!.isEmpty) {
    _msg = "Nama Tidak Boleh Kosong";
  }else{
    _msg = "Benar";
  }
  return _msg;
}
String validatePassword(String? value) {
  late String _msg;
  if (value!.isEmpty) {
    _msg = "Password Tidak Boleh Kosong";
  }else if (value.length < 6) {
    _msg = "Password Tidak Boleh Kurang Dari 6";
  }else{
    _msg = "Benar";
  }
  return _msg;
}
