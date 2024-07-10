class AppStrings {
  static const String appName = 'BAREEQ 1.0';
  static const String internetErrorText =
      'Error occured, please check internet connection and try again';
  static const String errorWidgetText = 'Error occured, please try again';

  /*----------------------------------------------------------------------------
   *                                 Start                                     -
   *----------------------------------------------------------------------------*/

  /*----------------------------------------------------------------------------
   *                                 Authentication                            -
   *----------------------------------------------------------------------------*/

  /*---------------------- signin -----------------------*/

  static const String signinScreenTitleText = 'Sign in';
  static const String registerIfDontHaveAccount =
      'If you don\'t have account just';
  static const String successfullySigninPrompt =
      'You have signed in successfully !!';

  /*---------------------- signup -----------------------*/

  static const String signupScreenTitleText = 'Sign up';
  static const String userDataInfoDialogTitle = 'User data rules';
  static const String userDataInfoDialogContent =
      'user name should be formal and real.\npassword should contain 8 charachters at least.\n';
  static const String wrongDataPrompt = 'Please Enter a Valid Data';
  static const String successfullySignupPrompt =
      'You have signed up successfully !!';
  static const String emailValidationRegExp =
      r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+";
  static const String numberValidationRegExp = r"^[0-9]*$";

  /*----------------------------------------------------------------------------
   *                                   Main                                    -
   *----------------------------------------------------------------------------*/

  static const String noNewProductsText =
      "There are no new products now, please try again later";

  /*----------------------------------------------------------------------------
   *                                   Cart                                    -
   *----------------------------------------------------------------------------*/

  static const String cartIsEmptyText = "Your cart is empty";
  static const String updateCartProductAlertDialogTitle = 'Update product';
  static const String deleteCartProductAlertDialogContent =
      'Are you sure you want to remove this product from your cart?';
  static const String deleteCartProductAlertDialogTitle = 'Remove product';

  /*----------------------------------------------------------------------------
   *                                   Favourits                               -
   *----------------------------------------------------------------------------*/

  static const String noFavouritesText = "There are no favourites";

  /*----------------------------------------------------------------------------
   *                                   Profile                                 -
   *----------------------------------------------------------------------------*/

  static const String updateUserNameAlertDialogTitle = "Update name";
  static const String updateUserPhoneAlertDialogTitle = "Update phone";
  static const String updateUserEmailAlertDialogTitle = "Update email";
}
