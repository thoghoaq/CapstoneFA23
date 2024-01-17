enum ErrorCode {
  passwordNotCorrect("PASSWORD_NOT_CORRECT", "Mật khẩu không chính xác"),
  usernameNotExist("USERNAME_NOT_EXIST", "Tên đăng nhập không tồn tại"),
  accountAlreadyExist("ACCOUNT_ALREADY_EXIST", "Tài khoản đã tồn tại");

  final String code;
  final String message;

  const ErrorCode(this.code, this.message);
}
