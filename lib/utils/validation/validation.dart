import 'package:tuple/tuple.dart';
import '../../localization/localization.dart';
import '../../utils/navigation/navigation_service.dart';

enum ValidationType {
  email,
  emailOrMobile,
  forgotPasswordPhone,
  password,
  oldPassword,
  newPassword,
  verifyNewPassword,
  firstName,
  lastName,
  fullName,
  phoneNumber,
  none,
  otp,
  cardNumber,
  cardHolderName,
  expirationDate,
  cvv,
  ssn,
  bankName,
  dob,
  address,
  city,
  state,
  country,
  zipCode,
  accountNumber,
  routingNumber,
  emailAddress,

  residentialPoolServiceAmount,
  commercialPoolServiceAmount,
  weeklyServiceAmount,
  seasonalServiceAmount,
  poolTileCleaningAmount,
  stoneTitleDeckSealingAmount,

  acidWashAmount,
  changeSandAmount,
  cleanFilterAmount,
  cleanSaltCellAmount,
  cleanPlumbingLinesAmount,
  drainPoolAmount,
  heaterTuneUpAmount,
  openPoolAmount,
  winterizePoolAmount,

  automaticPoolCleanerAmount,
  chlorinatorAmount,
  filterAmount,
  gasHeaterAmount,
  handrailsAmount,
  heatPumpMotorsAmount,
  poolPumpsAmount,
  spaBlowersAmount,
  poolAutomationAmount,

  downPaymentAmount,
  fullPaymentAmount,
  recurringPaymentAmount,

  extraAmount,
  issue,
  note,
}

class Validation {
  static const int _zero = 0;
  static const int _four = 4;
  static const int _six = 6;
  static const int _eight = 8;

  Tuple2<bool, String> validateFirstName(String value) {
    String _errorMessage = '';
    if (value.length == Validation._zero) {
      _errorMessage =
          Translations.of(NavigationService().context).msgEmptyFirstName;
    }
    return Tuple2(_errorMessage.isEmpty, _errorMessage);
  }

  Tuple2<bool, String> validateLastName(String value) {
    String _errorMessage = '';
    if (value.length == Validation._zero) {
      _errorMessage =
          Translations.of(NavigationService().context).msgEmptyLastName;
    }
    return Tuple2(_errorMessage.isEmpty, _errorMessage);
  }

  Tuple2<bool, String> validateEmail(String value) {
    String pattern1 =
        r'^(([^<>()[\]\\.,;:\s@\"]+(\.[^<>()[\]\\.,;:\s@\"]+)*)|(\".+\"))@((\[[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\])|(([a-zA-Z\-0-9]+\.)+[a-zA-Z]{2,}))';
    String pattern2 = pattern1;
    RegExp regExp1 = new RegExp(pattern1);
    RegExp regExp2 = new RegExp(pattern2);
    String _errorMessage = '';

    if (value.length == Validation._zero) {
      _errorMessage =
          Translations.of(NavigationService().context).msgEmptyEmail;
    } else if (!regExp1.hasMatch(value) || !regExp2.hasMatch(value)) {
      _errorMessage =
          Translations.of(NavigationService().context).msgValidEmail;
    }
    return Tuple2(_errorMessage.length == 0, _errorMessage);
  }

  Tuple2<bool, String> validateEmailOrPhone(String value) {
    String _errorMessage = '';
    if (value.length == Validation._zero) {
      _errorMessage =
          Translations.of(NavigationService().context).msgEmptyEmailOrMobile;
    } else {
      String pattern1 =
          r'^(([^<>()[\]\\.,;:\s@\"]+(\.[^<>()[\]\\.,;:\s@\"]+)*)|(\".+\"))@((\[[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\])|(([a-zA-Z\-0-9]+\.)+[a-zA-Z]{2,}))';
      String pattern2 = r'^[0-9-]*';
      RegExp regExp1 = new RegExp(pattern1);
      RegExp regExp2 = new RegExp(pattern2);
      if (regExp2.hasMatch(value)) {
        if (value.length < 10) {
          _errorMessage =
              Translations.of(NavigationService().context).msgValidPhotoNumber;
        }
      } else {
        if (regExp1.hasMatch(value)) {
          _errorMessage =
              Translations.of(NavigationService().context).msgValidEmail;
        }
      }
    }
    return Tuple2(_errorMessage.length == 0, _errorMessage);
  }

  Tuple2<bool, String> validateForgotPasswordPhone(String value) {
    String _errorMessage = '';
    if (value.length == Validation._zero) {
      _errorMessage =
          Translations.of(NavigationService().context).msgEmptyPhotoNumber;
    } else if (value.length < 10) {
      _errorMessage =
          Translations.of(NavigationService().context).msgValidPhotoNumber;
    }
    return Tuple2(_errorMessage.length == 0, _errorMessage);
  }

  Tuple2<bool, String> validatePassword(String value) {
    String _errorMessage = '';
    if (value.length == Validation._zero) {
      _errorMessage =
          Translations.of(NavigationService().context).msgEmptyPassword;
    } else if (value.length < Validation._six) {
      _errorMessage =
          Translations.of(NavigationService().context).msgValidPassword;
    }
    return Tuple2(_errorMessage.length == 0, _errorMessage);
  }

  Tuple2<bool, String> validateOldPassword(String value) {
    String _errorMessage = '';
    if (value.length == Validation._zero) {
      _errorMessage =
          Translations.of(NavigationService().context).msgEmptyPassword;
    } else if (value.length < Validation._six) {
      _errorMessage =
          Translations.of(NavigationService().context).msgValidOldPassword;
    }
    return Tuple2(_errorMessage.length == 0, _errorMessage);
  }

  Tuple2<bool, String> validateNewPassword(String value) {
    String _errorMessage = '';
    if (value.length == Validation._zero) {
      _errorMessage =
          Translations.of(NavigationService().context).msgEmptyNewPassword;
    } else if (value.length < Validation._six) {
      _errorMessage =
          Translations.of(NavigationService().context).msgValidNewPassword;
    }
    return Tuple2(_errorMessage.length == 0, _errorMessage);
  }

  Tuple2<bool, String> validateOtp(String value) {
    String _errorMessage = '';
    if (value.length == Validation._zero) {
      _errorMessage = Translations.of(NavigationService().context).msgEmptyOtp;
    } else if (value.length < Validation._four) {
      _errorMessage = Translations.of(NavigationService().context).msgValidOtp;
    }
    return Tuple2(_errorMessage.length == 0, _errorMessage);
  }

  Tuple2<bool, String> validateSSN(String value) {
    String _errorMessage = '';
    if (value.length == Validation._zero) {
      _errorMessage = Translations.of(NavigationService().context).msgEmptySSN;
    }
    return Tuple2(_errorMessage.length == 0, _errorMessage);
  }

  Tuple2<bool, String> validateVerifyNewPassword(String value) {
    String _errorMessage = '';
    if (value.length == Validation._zero) {
      _errorMessage = Translations.of(NavigationService().context)
          .msgEmptyVerifyNewPassword;
      //} else if (value.length < Validation._eight) {
      //  _errorMessage = Translations.of(NavigationService().context).msgValidVerifyNewPassword;
    }
    return Tuple2(_errorMessage.length == 0, _errorMessage);
  }

  Tuple2<bool, String> validatePhoneNumber(String value) {
    String _errorMessage = '';
    if (value.length == Validation._zero) {
      _errorMessage =
          Translations.of(NavigationService().context).msgEmptyPhotoNumber;
    } else if (value.length < 10) {
      _errorMessage =
          Translations.of(NavigationService().context).msgValidPhotoNumber;
    }
    return Tuple2(_errorMessage.length == 0, _errorMessage);
  }

  Tuple2<bool, String> validateCardNumber(String value) {
    String _errorMessage = '';
    if (value.length == Validation._zero) {
      _errorMessage =
          Translations.of(NavigationService().context).msgEmptyCardNumber;
    }
    return Tuple2(_errorMessage.isEmpty, _errorMessage);
  }

  Tuple2<bool, String> validateCardHolderName(String value) {
    String _errorMessage = '';
    if (value.length == Validation._zero) {
      _errorMessage =
          Translations.of(NavigationService().context).msgEmptyCardHolderName;
    }
    return Tuple2(_errorMessage.isEmpty, _errorMessage);
  }

  Tuple2<bool, String> validateFullName(String value) {
    String _errorMessage = '';
    if (value.length == Validation._zero) {
      _errorMessage =
          Translations.of(NavigationService().context).msgEmptyFullName;
    }
    return Tuple2(_errorMessage.isEmpty, _errorMessage);
  }

  Tuple2<bool, String> validateExpirationDate(String value) {
    String _errorMessage = '';
    if (value.length == Validation._zero) {
      _errorMessage =
          Translations.of(NavigationService().context).msgEmptyExpirationDate;
    }
    return Tuple2(_errorMessage.isEmpty, _errorMessage);
  }

  Tuple2<bool, String> validateCVV(String value) {
    String _errorMessage = '';
    if (value.length == Validation._zero) {
      _errorMessage = Translations.of(NavigationService().context).msgEmptyCVV;
    }
    return Tuple2(_errorMessage.isEmpty, _errorMessage);
  }

  Tuple2<bool, String> validateBankName(String value) {
    String _errorMessage = '';
    if (value.length == Validation._zero) {
      _errorMessage =
          Translations.of(NavigationService().context).msgEmptyBankName;
    }
    return Tuple2(_errorMessage.isEmpty, _errorMessage);
  }

  Tuple2<bool, String> validateEmailAddress(String value) {
    String _errorMessage = '';
    if (value.length == Validation._zero) {
      _errorMessage =
          Translations.of(NavigationService().context).msgEmptyEmailAddress;
    }
    return Tuple2(_errorMessage.isEmpty, _errorMessage);
  }

  // Tuple2<bool, String> validateDOB(String value) {
  //   String _errorMessage = '';
  //   if (value.length == Validation._zero) {
  //     _errorMessage = Translations.of(NavigationService().context).msgEmptyDOB;
  //   }
  //   return Tuple2(_errorMessage.length == 0, _errorMessage);
  // }

  Tuple2<bool, String> validateAddress(String value) {
    String _errorMessage = '';
    if (value.length == Validation._zero) {
      _errorMessage =
          Translations.of(NavigationService().context).msgEmptyAddress;
    }
    return Tuple2(_errorMessage.length == 0, _errorMessage);
  }

  Tuple2<bool, String> validateCity(String value) {
    String _errorMessage = '';
    if (value.length == Validation._zero) {
      _errorMessage = Translations.of(NavigationService().context).msgEmptyCity;
    }
    return Tuple2(_errorMessage.length == 0, _errorMessage);
  }

  Tuple2<bool, String> validateState(String value) {
    String _errorMessage = '';
    if (value.length == Validation._zero) {
      _errorMessage =
          Translations.of(NavigationService().context).msgEmptyState;
    }
    return Tuple2(_errorMessage.length == 0, _errorMessage);
  }

  Tuple2<bool, String> validateZipCode(String value) {
    String _errorMessage = '';
    if (value.length == Validation._zero) {
      _errorMessage =
          Translations.of(NavigationService().context).msgEmptyZipCode;
    }
    return Tuple2(_errorMessage.length == 0, _errorMessage);
  }

  Tuple2<bool, String> validateAccountNumber(String value) {
    String _errorMessage = '';
    if (value.length == Validation._zero) {
      _errorMessage =
          Translations.of(NavigationService().context).msgEmptyAccountNumber;
    }
    return Tuple2(_errorMessage.length == 0, _errorMessage);
  }

  Tuple2<bool, String> validateRoutingNumber(String value) {
    String _errorMessage = '';
    if (value.length == Validation._zero) {
      _errorMessage =
          Translations.of(NavigationService().context).msgEmptyRoutingNumber;
    }
    return Tuple2(_errorMessage.length == 0, _errorMessage);
  }

  Tuple2<bool, String> validateAmount(String value) {
    String _errorMessage = '';
    if (value.length == Validation._zero) {
      _errorMessage =
          Translations.of(NavigationService().context).msgEmptyAmount;
    }
    return Tuple2(_errorMessage.length == 0, _errorMessage);
  }

  Tuple2<bool, String> validateCountry(String value) {
    String _errorMessage = '';
    if (value.length == Validation._zero) {
      _errorMessage =
          Translations.of(NavigationService().context).msgEmptyCountry;
    }
    return Tuple2(_errorMessage.length == 0, _errorMessage);
  }

  Tuple2<bool, String> validateResidentialPoolServiceAmount(String value) {
    String _errorMessage = '';
    if (value.length == Validation._zero) {
      _errorMessage = Translations.of(NavigationService().context)
          .strEmptyResidentialPoolServiceAmount;
    }
    return Tuple2(_errorMessage.length == 0, _errorMessage);
  }

  Tuple2<bool, String> validateCommercialPoolServiceAmount(String value) {
    String _errorMessage = '';
    if (value.length == Validation._zero) {
      _errorMessage = Translations.of(NavigationService().context)
          .strCommercialPoolServiceAmount;
    }
    return Tuple2(_errorMessage.length == 0, _errorMessage);
  }

  Tuple2<bool, String> validateWeeklyServiceAmount(String value) {
    String _errorMessage = '';
    if (value.length == Validation._zero) {
      _errorMessage = Translations.of(NavigationService().context)
          .strEmptyWeeklyServiceAmount;
    }
    return Tuple2(_errorMessage.length == 0, _errorMessage);
  }

  Tuple2<bool, String> validateSeasonalServiceAmount(String value) {
    String _errorMessage = '';
    if (value.length == Validation._zero) {
      _errorMessage = Translations.of(NavigationService().context)
          .strEmptySeasonalServiceAmount;
    }
    return Tuple2(_errorMessage.length == 0, _errorMessage);
  }

  Tuple2<bool, String> validatePoolTileCleaningAmount(String value) {
    String _errorMessage = '';
    if (value.length == Validation._zero) {
      _errorMessage = Translations.of(NavigationService().context)
          .strEmptyPoolTileCleaningAmount;
    }
    return Tuple2(_errorMessage.length == 0, _errorMessage);
  }

  Tuple2<bool, String> validateStoneTitleDeckSealingAmount(String value) {
    String _errorMessage = '';
    if (value.length == Validation._zero) {
      _errorMessage = Translations.of(NavigationService().context)
          .strEmptyStoneTitleDeckSealingAmount;
    }
    return Tuple2(_errorMessage.length == 0, _errorMessage);
  }

  Tuple2<bool, String> validateAcidWashAmount(String value) {
    String _errorMessage = '';
    if (value.length == Validation._zero) {
      _errorMessage =
          Translations.of(NavigationService().context).strEmptyAcidWashAmount;
    }
    return Tuple2(_errorMessage.length == 0, _errorMessage);
  }

  Tuple2<bool, String> validateChangeSandAmount(String value) {
    String _errorMessage = '';
    if (value.length == Validation._zero) {
      _errorMessage =
          Translations.of(NavigationService().context).strEmptyChangeSandAmount;
    }
    return Tuple2(_errorMessage.length == 0, _errorMessage);
  }

  Tuple2<bool, String> validateCleanFilterAmount(String value) {
    String _errorMessage = '';
    if (value.length == Validation._zero) {
      _errorMessage = Translations.of(NavigationService().context)
          .strEmptyCleanFilterAmount;
    }
    return Tuple2(_errorMessage.length == 0, _errorMessage);
  }

  Tuple2<bool, String> validateCleanSaltCellAmount(String value) {
    String _errorMessage = '';
    if (value.length == Validation._zero) {
      _errorMessage = Translations.of(NavigationService().context)
          .strEmptyCleanSaltCellAmount;
    }
    return Tuple2(_errorMessage.length == 0, _errorMessage);
  }

  Tuple2<bool, String> validateCleanPlumbingLinesAmount(String value) {
    String _errorMessage = '';
    if (value.length == Validation._zero) {
      _errorMessage = Translations.of(NavigationService().context)
          .strEmptyCleanPlumbingLinesAmount;
    }
    return Tuple2(_errorMessage.length == 0, _errorMessage);
  }

  Tuple2<bool, String> validateDrainPoolAmount(String value) {
    String _errorMessage = '';
    if (value.length == Validation._zero) {
      _errorMessage =
          Translations.of(NavigationService().context).strEmptyDrainPoolAmount;
    }
    return Tuple2(_errorMessage.length == 0, _errorMessage);
  }

  Tuple2<bool, String> validateHeaterTuneUpAmount(String value) {
    String _errorMessage = '';
    if (value.length == Validation._zero) {
      _errorMessage = Translations.of(NavigationService().context)
          .strEmptyHeaterTuneUpAmount;
    }
    return Tuple2(_errorMessage.length == 0, _errorMessage);
  }

  Tuple2<bool, String> validateOpenPoolAmount(String value) {
    String _errorMessage = '';
    if (value.length == Validation._zero) {
      _errorMessage =
          Translations.of(NavigationService().context).strEmptyOpenPoolAmount;
    }
    return Tuple2(_errorMessage.length == 0, _errorMessage);
  }

  Tuple2<bool, String> validateWinterizePoolAmount(String value) {
    String _errorMessage = '';
    if (value.length == Validation._zero) {
      _errorMessage = Translations.of(NavigationService().context)
          .strEmptyWinterizePoolAmount;
    }
    return Tuple2(_errorMessage.length == 0, _errorMessage);
  }

  Tuple2<bool, String> validateAutomaticPoolCleanerAmount(String value) {
    String _errorMessage = '';
    if (value.length == Validation._zero) {
      _errorMessage = Translations.of(NavigationService().context)
          .strEmptyAutomaticPoolCleanerAmount;
    }
    return Tuple2(_errorMessage.length == 0, _errorMessage);
  }

  Tuple2<bool, String> validateChlorinatorAmount(String value) {
    String _errorMessage = '';
    if (value.length == Validation._zero) {
      _errorMessage = Translations.of(NavigationService().context)
          .strEmptyChlorinatorAmount;
    }
    return Tuple2(_errorMessage.length == 0, _errorMessage);
  }

  Tuple2<bool, String> validateFilterAmount(String value) {
    String _errorMessage = '';
    if (value.length == Validation._zero) {
      _errorMessage = Translations.of(NavigationService().context)
          .strEmptyCleanFilterAmount;
    }
    return Tuple2(_errorMessage.length == 0, _errorMessage);
  }

  Tuple2<bool, String> validateGasHeaterAmount(String value) {
    String _errorMessage = '';
    if (value.length == Validation._zero) {
      _errorMessage =
          Translations.of(NavigationService().context).strEmptyGasHeaterAmount;
    }
    return Tuple2(_errorMessage.length == 0, _errorMessage);
  }

  Tuple2<bool, String> validateHandrailsAmount(String value) {
    String _errorMessage = '';
    if (value.length == Validation._zero) {
      _errorMessage =
          Translations.of(NavigationService().context).strEmptyHandrailsAmount;
    }
    return Tuple2(_errorMessage.length == 0, _errorMessage);
  }

  Tuple2<bool, String> validateHeatPumpMotorsAmount(String value) {
    String _errorMessage = '';
    if (value.length == Validation._zero) {
      _errorMessage = Translations.of(NavigationService().context)
          .strEmptyHeatPumpMotorsAmount;
    }
    return Tuple2(_errorMessage.length == 0, _errorMessage);
  }

  Tuple2<bool, String> validatePoolPumpsAmount(String value) {
    String _errorMessage = '';
    if (value.length == Validation._zero) {
      _errorMessage =
          Translations.of(NavigationService().context).strEmptyPoolPumpsAmount;
    }
    return Tuple2(_errorMessage.length == 0, _errorMessage);
  }

  Tuple2<bool, String> validateSpaBlowersAmount(String value) {
    String _errorMessage = '';
    if (value.length == Validation._zero) {
      _errorMessage =
          Translations.of(NavigationService().context).strEmptySpaBlowersAmount;
    }
    return Tuple2(_errorMessage.length == 0, _errorMessage);
  }

  Tuple2<bool, String> validatepoolAutomationAmount(String value) {
    String _errorMessage = '';
    if (value.length == Validation._zero) {
      _errorMessage = Translations.of(NavigationService().context)
          .strEmptyPoolAutomationAmount;
    }
    return Tuple2(_errorMessage.length == 0, _errorMessage);
  }

  Tuple2<bool, String> validateFullPayment(String value) {
    String _errorMessage = '';
    if (value.length == Validation._zero) {
      _errorMessage = Translations.of(NavigationService().context)
          .strEmptyFullPaymentAmount;
    }
    return Tuple2(_errorMessage.length == 0, _errorMessage);
  }

  Tuple2<bool, String> validateDownPayment(String value) {
    String _errorMessage = '';
    if (value.length == Validation._zero) {
      _errorMessage = Translations.of(NavigationService().context)
          .strEmptyDownPaymentAmount;
    }
    return Tuple2(_errorMessage.length == 0, _errorMessage);
  }

  Tuple2<bool, String> validateRecurringPayment(String value) {
    String _errorMessage = '';
    if (value.length == Validation._zero) {
      _errorMessage = Translations.of(NavigationService().context)
          .strEmptyRecurringPaymentAmount;
    }
    return Tuple2(_errorMessage.length == 0, _errorMessage);
  }

  Tuple2<bool, String> validateExtraAmount(String value) {
    String _errorMessage = '';
    if (value.length == Validation._zero) {
      _errorMessage =
          Translations.of(NavigationService().context).strEmptyExtraAmount;
    }
    return Tuple2(_errorMessage.length == 0, _errorMessage);
  }

  Tuple2<bool, String> validateIssue(String value) {
    String _errorMessage = '';
    if (value.length == Validation._zero) {
      _errorMessage =
          Translations.of(NavigationService().context).strEmptyIssue;
    }
    return Tuple2(_errorMessage.length == 0, _errorMessage);
  }

  Tuple2<bool, String> validateNote(String value) {
    String _errorMessage = '';
    if (value.length == Validation._zero) {
      _errorMessage = Translations.of(NavigationService().context).strEmptyNote;
    }
    return Tuple2(_errorMessage.length == 0, _errorMessage);
  }

  Tuple3<bool, String, ValidationType> checkValidationForTextFieldWithType(
      {List<Tuple2<ValidationType, String>> list}) {
    Tuple3<bool, String, ValidationType> isValid =
        Tuple3(true, '', ValidationType.none);

    for (Tuple2<ValidationType, String> textOption in list) {
      Tuple2<bool, String> res = Tuple2(true, '');

      if (textOption.item1 == ValidationType.emailOrMobile) {
        res = this.validateEmailOrPhone(textOption.item2);
      } else if (textOption.item1 == ValidationType.email) {
        res = this.validateEmail(textOption.item2);
      } else if (textOption.item1 == ValidationType.forgotPasswordPhone) {
        res = this.validateForgotPasswordPhone(textOption.item2);
      } else if (textOption.item1 == ValidationType.emailAddress) {
        res = this.validateEmailAddress(textOption.item2);
      } else if (textOption.item1 == ValidationType.password) {
        res = this.validatePassword(textOption.item2);
      } else if (textOption.item1 == ValidationType.oldPassword) {
        res = this.validateOldPassword(textOption.item2);
      } else if (textOption.item1 == ValidationType.newPassword) {
        res = this.validateNewPassword(textOption.item2);
      } else if (textOption.item1 == ValidationType.verifyNewPassword) {
        res = this.validateVerifyNewPassword(textOption.item2);
      } else if (textOption.item1 == ValidationType.phoneNumber) {
        res = this.validatePhoneNumber(textOption.item2);
      } else if (textOption.item1 == ValidationType.firstName) {
        res = this.validateFirstName(textOption.item2);
      } else if (textOption.item1 == ValidationType.lastName) {
        res = this.validateLastName(textOption.item2);
      } else if (textOption.item1 == ValidationType.otp) {
        res = this.validateOtp(textOption.item2);
      } else if (textOption.item1 == ValidationType.ssn) {
        res = this.validateSSN(textOption.item2);
      } else if (textOption.item1 == ValidationType.cardHolderName) {
        res = this.validateCardHolderName(textOption.item2);
      } else if (textOption.item1 == ValidationType.cardNumber) {
        res = this.validateCardNumber(textOption.item2);
      } else if (textOption.item1 == ValidationType.expirationDate) {
        res = this.validateExpirationDate(textOption.item2);
      } else if (textOption.item1 == ValidationType.cvv) {
        res = this.validateCVV(textOption.item2);
      } else if (textOption.item1 == ValidationType.bankName) {
        res = this.validateBankName(textOption.item2);
      } else if (textOption.item1 == ValidationType.emailAddress) {
        res = this.validateBankName(textOption.item2);
      }
      // else if (textOption.item1 == ValidationType.dob) {
      //   res = this.validateDOB(textOption.item2);
      // }
      else if (textOption.item1 == ValidationType.address) {
        res = this.validateAddress(textOption.item2);
      } else if (textOption.item1 == ValidationType.city) {
        res = this.validateCity(textOption.item2);
      } else if (textOption.item1 == ValidationType.state) {
        res = this.validateState(textOption.item2);
      } else if (textOption.item1 == ValidationType.zipCode) {
        res = this.validateZipCode(textOption.item2);
      } else if (textOption.item1 == ValidationType.accountNumber) {
        res = this.validateAccountNumber(textOption.item2);
      } else if (textOption.item1 == ValidationType.routingNumber) {
        res = this.validateRoutingNumber(textOption.item2);
      } else if (textOption.item1 == ValidationType.country) {
        res = this.validateCountry(textOption.item2);
      } else if (textOption.item1 == ValidationType.fullName) {
        res = this.validateFullName(textOption.item2);
      } else if (textOption.item1 ==
          ValidationType.residentialPoolServiceAmount) {
        res = this.validateResidentialPoolServiceAmount(textOption.item2);
      } else if (textOption.item1 ==
          ValidationType.commercialPoolServiceAmount) {
        res = this.validateCommercialPoolServiceAmount(textOption.item2);
      } else if (textOption.item1 == ValidationType.weeklyServiceAmount) {
        res = this.validateWeeklyServiceAmount(textOption.item2);
      } else if (textOption.item1 == ValidationType.seasonalServiceAmount) {
        res = this.validateSeasonalServiceAmount(textOption.item2);
      } else if (textOption.item1 == ValidationType.poolTileCleaningAmount) {
        res = this.validatePoolTileCleaningAmount(textOption.item2);
      } else if (textOption.item1 ==
          ValidationType.stoneTitleDeckSealingAmount) {
        res = this.validateStoneTitleDeckSealingAmount(textOption.item2);
      } else if (textOption.item1 == ValidationType.acidWashAmount) {
        res = this.validateAcidWashAmount(textOption.item2);
      } else if (textOption.item1 == ValidationType.changeSandAmount) {
        res = this.validateChangeSandAmount(textOption.item2);
      } else if (textOption.item1 == ValidationType.cleanFilterAmount) {
        res = this.validateCleanFilterAmount(textOption.item2);
      } else if (textOption.item1 == ValidationType.cleanSaltCellAmount) {
        res = this.validateCleanSaltCellAmount(textOption.item2);
      } else if (textOption.item1 == ValidationType.cleanPlumbingLinesAmount) {
        res = this.validateCleanPlumbingLinesAmount(textOption.item2);
      } else if (textOption.item1 == ValidationType.drainPoolAmount) {
        res = this.validateDrainPoolAmount(textOption.item2);
      } else if (textOption.item1 == ValidationType.heaterTuneUpAmount) {
        res = this.validateHeaterTuneUpAmount(textOption.item2);
      } else if (textOption.item1 == ValidationType.openPoolAmount) {
        res = this.validateWinterizePoolAmount(textOption.item2);
      } else if (textOption.item1 ==
          ValidationType.automaticPoolCleanerAmount) {
        res = this.validateAutomaticPoolCleanerAmount(textOption.item2);
      } else if (textOption.item1 == ValidationType.chlorinatorAmount) {
        res = this.validateChlorinatorAmount(textOption.item2);
      } else if (textOption.item1 == ValidationType.filterAmount) {
        res = this.validateFilterAmount(textOption.item2);
      } else if (textOption.item1 == ValidationType.gasHeaterAmount) {
        res = this.validateGasHeaterAmount(textOption.item2);
      } else if (textOption.item1 == ValidationType.handrailsAmount) {
        res = this.validateHandrailsAmount(textOption.item2);
      } else if (textOption.item1 == ValidationType.heatPumpMotorsAmount) {
        res = this.validateHeatPumpMotorsAmount(textOption.item2);
      } else if (textOption.item1 == ValidationType.poolPumpsAmount) {
        res = this.validatePoolPumpsAmount(textOption.item2);
      } else if (textOption.item1 == ValidationType.spaBlowersAmount) {
        res = this.validateSpaBlowersAmount(textOption.item2);
      } else if (textOption.item1 == ValidationType.poolAutomationAmount) {
        res = this.validatepoolAutomationAmount(textOption.item2);
      } else if (textOption.item1 == ValidationType.fullPaymentAmount) {
        res = this.validateFullPayment(textOption.item2);
      } else if (textOption.item1 == ValidationType.downPaymentAmount) {
        res = this.validateDownPayment(textOption.item2);
      } else if (textOption.item1 == ValidationType.recurringPaymentAmount) {
        res = this.validateRecurringPayment(textOption.item2);
      } else if (textOption.item1 == ValidationType.extraAmount) {
        res = this.validateExtraAmount(textOption.item2);
      } else if (textOption.item1 == ValidationType.issue) {
        res = this.validateIssue(textOption.item2);
      } else if (textOption.item1 == ValidationType.note) {
        res = this.validateNote(textOption.item2);
      }

      isValid = Tuple3(res.item1, res.item2, textOption.item1);
      if (!isValid.item1) {
        break;
      }
    }
    return isValid;
  }
}
