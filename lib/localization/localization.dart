import 'package:flutter/material.dart';

class Translations {
  Locale locale;
  static Translations globalTranslations;

  Translations(Locale local) {
    this.locale = local;
    Translations.globalTranslations = this;
  }

  // Helper method to keep the code in the widgets concise Localizations are accessed using an InheritedWidget "of" syntax
  static Translations of(BuildContext context) {
    return Localizations.of<Translations>(context, Translations);
  }

  // Static member to have a simple access to the delegate from the MaterialApp
  static const LocalizationsDelegate<Translations> delegate = _TranslationsDelegate();

  String get appName => 'Wall Hunt';

  /* SerVice Message */
  String get msgSomethingWrong => 'Something went Wrong';
  String get msgInternetMessage => 'Please check your network connection.';
  String get msgSessionExpired => 'Session expired! Please login again.';

  /* Permission Ask Message */
  String get msgProfilePhotoSelection => 'App needs to access your camera or gallery to set your profile picture.';
  String get msgCameraPermissionProfile => 'App wants camera permission for upload your profile picture, please go to settings and allow access';
  String get msgPhotoPermissionProfile => 'App wants photo permission for upload your profile picture, please go to settings and allow access';
  String get msgCameraPermission => 'App needs camera permission to capture photo, go to settings and allow access';
  String get msgPhotoPermission => 'App needs photo permission to take photo from your library, go to settings and allow access';
  String get msgLocationPermission => 'Grant location permission for better experience, go to settings and allow access';

  /* Media Selection */
  String get strAlert => "Alert";
  String get strTakePhoto => "Take Photo";
  String get strChooseFromExisting => "Choose Photo";

  /* Common Button List */
  String get btnCancel => 'Cancel';
  String get btnOk => 'OK';
  String get btnDelete => 'Delete';
  String get btnYes => 'Yes';
  String get btnNo => 'No';
  String get btnDone => 'Done';
  String get btnEdit => 'Edit';
  String get btnAdd => 'Add';
  String get btnSave => 'Save';
  String get btnNext => 'Next';
  String get searchDot => 'Search...';
  String get selectPhoneCode => 'Select your phone code';

  /* Place Holder */
  String get emailPlaceholder => 'Email address';
  String get passwordPlaceholder => 'Password';
  String get fullNamePlaceholder => 'Full Name';
  String get email => 'Email';
  String get phoneNumberPlaceholder => 'Phone Number';
  String get reEnterPasswordPlaceholder => 'Re-enter Password';
  String get addressPlaceholder => 'Address';
  String get countryPlaceholder => 'Country';
  String get statePlaceholder => 'State';
  String get cityPlaceholder => 'City';
  String get zipCodePlaceholder => 'Zip Code';
  String get welcome => 'Welcome';
  String get specifyYourNewPassword => 'Specify your new password';
  String get oldPassword => 'Old Password';
  String get enterNewPassword => 'New Password';
  String get confirmNewPassword => 'Confirm New Password';

  /* Login Page */
  String get singUp => 'Sign up';
  String get singIn => 'Sign in';
  String get singInMessage => 'First login your account.';
  String get forgotPassword => 'Forgot Password?';
  String get btnSignIn => 'Sign In';
  String get or => 'OR';
  String get emailOrMobile => 'Email/Mobile Number';
  String get btnLogin => 'Login';
  String get strLoginWithFacebook => 'Log In With Facebook';
  String get strLoginWithGoogle => 'Log In With Google';
  String get strDontHaveAccount => 'Don’t have an account? ';
  String get strAlreadyHaveAccount => 'Already have an account? ';
  String get strTermsAndConditions => 'Terms & Condition';
  String get strPrivacyPolicy => 'Privacy Policy';
  String get strAndSymbol => ' & ';
  String get strResetPassword => 'Reset Password';
  String get strChangePassword => 'Change Password';

  String get strSignUpWithFacebook => 'Sign Up With Facebook';
  String get strSignUpWithGoogle => 'Sign Up With Google';

  /* validation message */
  String get msgEmptyEmail => "Please enter Email";
  String get msgEmptyEmailOrMobile => "Please enter Email or Mobile Number.";
  String get msgEmptyPassword => "Please enter Password.";
  String get msgValidPassword => "Password must be 6 characters long.";
  String get msgUserDoesNotExist => "User does not exist.";
  String get msgNoRecordFound => "No record found.";
  String get msgIncorrectPassword => "The Password you entered is incorrect.";
  String get msgEmptyForgotPasswordEmail => "Please enter your registered email address.";
  String get msgValidEmail => "Please enter valid email address.";
  String get msgValidOldPassword => "Old password entered is incorrect.";
  String get msgEmptyNewPassword => "Please enter new password.";
  String get msgValidNewPassword => "Password must be 6 characters long.";
  String get msgEmptyVerifyNewPassword => "Please enter Confirm New Password.";
  String get msgValidVerifyNewPassword => "Password must be 6 characters long.";
  String get msgVerifyNewPasswordSame => "New Password and Confirm New Password does not match.";
  String get msgEmptyPhotoNumber => "Please enter phone number.";
  String get msgValidPhotoNumber => "Please enter valid phone number.";
  String get msgEmptyFirstName => "Please enter first name.";
  String get msgEmptyLastName => "Please enter last name.";
  String get msgEmptyFullName => "Please enter full name.";
  String get msgEmptyOtp => "Please enter OTP.";
  String get msgEmptySSN => "Please enter SSN number";
  String get msgValidOtp => "The OTP you entered is incorrect. Please enter the correct OTP.";
  String get msgEmptyCardNumber => "Please enter card number.";
  String get msgEmptyCardHolderName => "Please enter card owner name.";
  String get msgEmptyExpirationDate => "Please enter expiry date.";
  String get msgEmptyCVV => "Please enter CVV.";
  String get msgEmptyBankName => "Please enter bank name.";
  String get msgEmptyDOB => "Please enter date of birth.";
  String get msgEmptyAddress => "Please enter address";
  String get msgEmptyCity => "Please enter city";
  String get msgEmptyCountry => "Please enter country";
  String get msgEmptyState => "Please enter state";
  String get msgEmptyZipCode => "Please enter zip code";
  String get msgEmptyAccountNumber => "Please enter account number";
  String get msgEmptyRoutingNumber => "Please enter routing number";
  String get msgEmptyEmailAddress => "Please enter email";
  String get msgEmptyAmount => "Please enter amount";
  String get msgInvalidSMSCode => "Invalid SMS Verification code";
  String get msgSelectServices => "Please select services from list.";
  String get msgDeleteQuote => "Are you sure you want to delete?";

  String get msgLogOut => "Are you sure you want to logout?";

  String get btnSendOtp => 'Send OTP';
  String get btnSubmit => 'Submit';
  String get btnResendOtp => 'Resend OTP';
  String get btnAccept => 'Accept';
  String get btnChat => 'Chat';
  String get btnSendQuotation => 'send quote';

  String get strIConfirmThatIAm18Year => 'I  confirm that i am 18 years old or above and  agree to the ';
  String get strForgotYourPassword => 'Forgot Your Password? ';
  String get strSpecifyYourPhoneNumber => 'Specify your phone number to set your  password again';
  String get strEnterYourRegisteredMobileNumber => 'Enter Your Registered Mobile Number';
  String get strEnterMobileNumber => 'Mobile Number';
  String get strForgotPasswordWithoutQuestionMark => 'Forgot Password';
  String get strVerificationCode => 'Verification Code';
  String get strPleaseTypeVerificationCode => 'Please type the verification code sent to';
  String get strEnterOTPHere => 'Enter OTP Here';
  String get strHome => 'Home';
  String get strOrder => 'Order';
  String get strChat => 'Chat';
  String get strSettings => 'Settings';
  String get strQuotationRequest => 'Quote Request';
  String get strOrderManagement => 'Order Management';
  String get strClosedQuote => 'Closed Quote';
  String get strAccountAndSettings => 'Account & Settings';
  String get strCustomer => 'Customer';
  String get strType => 'Type';
  String get strCreatedAt => 'Created At';
  String get strScheduledAt => 'Schedule At';
  String get strQuotationDetails => 'Quote Details';
  String get strRequestId => 'Request ID ';
  String get strPending => '•Pending';
  String get strDateAndTimeOfRequest => 'Date and Time Of Request';
  String get strCustomerName => 'Customer Name';
  String get strServiceType => 'Service Type';
  String get strServiceSelected => 'Service Selected';
  String get privacy => 'Privacy Policy';
  String get logout => 'Logout';
  String get strMyCards => 'My Cards';
  String get strAddCard => 'Add Card';
  String get strAddBank => 'Add Bank';
  String get strEnterCardOwnerName => 'Enter Card Owner Name';
  String get strEnterCardNumber => 'Enter Card Number';
  String get strExpiryDate => 'Expiry Date';
  String get strCVV => 'CVV';
  String get strFirstName => 'First Name';
  String get strLastName => 'Last Name';
  String get strBankName => 'Bank Name';
  String get strDateOfBirth => 'Date of Birth';
  String get strAddressLine => 'Address Line';
  String get strCity => 'City';
  String get strState => 'State';
  String get strLastDigitofSSNNumber => 'Last 4 Digit of SSN Number';
  String get strAccountNumber => 'Account Number';
  String get strRoutingNumber => 'Routing Number';
  String get strMaintenanceService => 'Maintenance Service';
  String get strRepair => 'Repair';
  String get strInstallation => 'Installation';
  String get strManageServices => 'Manage Services';
  String get strResidentialPoolService => 'Residential Pool Service';
  String get strCommercialPoolService => 'Commercial Pool Service';
  String get strWeeklyService => 'Weekly Service';
  String get strSeasonalService => 'Seasonal Service';
  String get strPoolTileCleaning => 'Pool Tile Cleaning';
  String get strStoneTitleDeckSealing => 'Stone / Title / Deck Sealing';
  String get strOther => 'Other';
  String get strAcidWash => 'Acid Wash';
  String get strChangeSand => 'Change Sand';
  String get strCleanFilter => 'Clean Filter';
  String get strCleanSaltCell => 'Clean Salt Cell';
  String get strCleanPlumbingLines => 'Clean Plumbing Lines';
  String get strDrainPool => 'Drain Pool';
  String get strHeaterTuneUp => 'Heater Tune - Up';
  String get strOpenPool => 'Open Pool';
  String get strWinterizePool => 'Winterize Pool';
  String get strAutomaticPoolCleaner => 'Automatic Pool Cleaner';
  String get strChlorinator => 'Chlorinator';
  String get strFilter => 'Filter';
  String get strGasHeater => 'Gas Heater';
  String get strHandrails => 'Handrails';
  String get strHeatPumpMotors => 'Heat Pump Motors';
  String get strPoolPumps => 'Pool Pumps';
  String get strSpaBlowers => 'Spa Blowers';
  String get strPoolAutomation => 'Pool Automation';
  String get strOngoing => 'Ongoing';
  String get strCompleted => 'Completed';
  String get strUpcoming => 'Upcoming';
  String get strPast => 'Past';
  String get strCancel => 'Cancel';
  String get strMaintenance => 'Maintenance';
  String get strWaterType => 'Water Type';
  String get strChlorinatedWater => 'Chlorinated Water';
  String get strPoolDimension => 'Pool Dimension';
  String get poolDepth => 'Pool Depth';
  String get strVolume => 'Volume';
  String get strLandscapingDetails => 'Landscaping Details';
  String get strNotes => 'Notes';
  String get strStartDateAndTimeWOAsterisk => 'Start Date and Time';
  String get strStartDateAndTime => 'Start Date and Time';
  String get strScheduleDateAndTime => 'Schedule Date and Time*';
  String get strSingleTimeOrRecurring => 'Single Time or Recurring';
  String get strFrequency => 'Frequency ';
  String get strQuotationInDollar => 'Quote (in \$)';
  String get strFullPayment => 'Full Payment';
  String get strDownPayment => 'Down Payment';
  String get strRecurringPayment => 'Recurring Payment';
  String get strOrderID => 'Order ID ';
  String get strPaymentHistory => 'Payment History';
  String get strExtraPayment => 'Extra Payment';
  String get strReleasePayment => 'Release Payment';
  String get strNote => 'Note';
  String get strOngoingOrder => 'Ongoing Order';
  String get strTakeAction => 'Take Action';
  String get strRequestPayment => 'Request Payment';
  String get strRequestExtraPayment => 'Request Extra Payment';
  String get strRequestPaymentRelease => 'Request Payment Release';
  String get strNotifications => 'Notifications';
  String get strUpcomingOrder => 'Upcoming Order';
  String get strCompletedOrder => 'Completed Order';
  String get strPastOrder => 'Past Order';
  String get strCancelOrder => 'Cancel Order';
  String get strReportIssue => 'Report Issue';
  String get strSelectIssue => 'Select Issue';
  String get strExtraAmountRequested => 'Extra Amount Requested';
  String get strPartialAmountRequested => 'Partial Amount Requested';
  String get strChatDetails => 'Chat Details';
  String get strTypeMessage => 'Type message…..';
  String get strPaymentMode => 'Payment Mode';

  String get strEmptyResidentialPoolServiceAmount => 'Please enter residential pool service amount';
  String get strCommercialPoolServiceAmount => 'Please enter commercial pool service amount';
  String get strEmptyWeeklyServiceAmount => 'Please enter weekly service amount';
  String get strEmptySeasonalServiceAmount => 'Please enter seasonal service amount';
  String get strEmptyPoolTileCleaningAmount => 'Please enter pool tile cleaning amount';
  String get strEmptyStoneTitleDeckSealingAmount => 'Please enter stone title deck sealing amount';
  String get strEmptyAcidWashAmount => 'Please enter acid wash amount';
  String get strEmptyChangeSandAmount => 'Please enter change sand amount';
  String get strEmptyCleanFilterAmount => 'Please enter clean filter amount';
  String get strEmptyCleanSaltCellAmount => 'Please enter clean salt cell amount';
  String get strEmptyCleanPlumbingLinesAmount => 'Please enter clean plumbing lines amount';
  String get strEmptyDrainPoolAmount => 'Please enter drain pool amount';
  String get strEmptyHeaterTuneUpAmount => 'Please enter heater tune up amount';
  String get strEmptyOpenPoolAmount => 'Please enter open pool amount';
  String get strEmptyWinterizePoolAmount => 'Please enter winterize pool amount';
  String get strEmptyAutomaticPoolCleanerAmount => 'Please enter automatic pool cleaner amount';
  String get strEmptyChlorinatorAmount => 'Please enter chlorinator amount ';
  String get strEmptyFilterAmount => 'Please enter filter amount';
  String get strEmptyGasHeaterAmount => 'Please enter gas heater amount';
  String get strEmptyHandrailsAmount => 'Please enter handrails amount';
  String get strEmptyHeatPumpMotorsAmount => 'Please enter heat pump motors amount';
  String get strEmptyPoolPumpsAmount => 'Please enter pool pumps amount';
  String get strEmptySpaBlowersAmount => 'Please enter spa blowers amount';
  String get strEmptyPoolAutomationAmount => 'Please enter pool automation amount';
  String get strEmptyDownPaymentAmount => 'Please enter down payment';
  String get strEmptyFullPaymentAmount => 'Please enter full payment';
  String get strEmptyRecurringPaymentAmount => 'Please enter recurring payment amount';
  String get strValidDownPaymentAmount => 'Down payment must be less than total payment.';
  String get strValidRecurringPaymentAmount => 'Recurring payment must be less than total payment.';

  String get msgLoginFailMessage => "Invalid Email or Password.";
  String get strEmptyExtraAmount => 'Please enter extra amount';
  String get strEmptyIssue => 'Please select issue';
  String get strEmptyNote => 'Please enter note';

  String get profile => 'Profile';
  String get cards => 'Cards';
  String get chagepassword => 'Change Password';
  String get report => 'Reported Issue';
  String get terms => 'Terms and Conditions';
  String get strSingleTime => 'Single Time';
  String get strRecurring => 'Recurring';
  String get strWeekly => 'Weekly';
  String get strMonthly => 'Monthly';
  String get strBiMonthly => 'Bi Monthly';
  String get strQuarterly => 'Quarterly';
  String get strHalfYearly => 'Half Yearly';
  String get msgRequestForDownPayment => 'Are you sure want to request for down payment?';


///
  String get strWalli => "Walli";
String get strCollection => "Collection";
String get strFeatured => "Featured";
String get strRecent => "Recent";
String get strPopular => "Popular";
}

class _TranslationsDelegate extends LocalizationsDelegate<Translations> {
  const _TranslationsDelegate();

  @override
  bool isSupported(Locale locale) {
    return ['en', 'ar'].contains(locale.languageCode);
  }

  @override
  Future<Translations> load(Locale locale) async {
    // AppLocalizations class is where the JSON loading actually runs
    Translations localizations = new Translations(locale);
    return localizations;
  }

  @override
  bool shouldReload(_TranslationsDelegate old) => false;
}
