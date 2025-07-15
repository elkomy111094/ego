import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:intl_phone_field/intl_phone_field.dart';
import 'package:intl_phone_field/country_picker_dialog.dart';
import 'package:intl_phone_field/phone_number.dart';

import '../../utils/countries.dart';

/// Enum to specify the border type for the phone field.
enum BorderType { outline, underline }

/// A reusable custom phone form field widget with country dial code selection and validation.
class CustomPhoneField extends StatefulWidget {
  /// Controller to access the phone number.
  final TextEditingController? controller;

  /// Initial country code (e.g., 'US', 'IN').
  final String initialCountryCode;

  /// Callback when the phone number changes. Returns the complete number (with country dial code).
  final void Function(String?)? onChanged;

  /// Callback when the country changes. Returns the country dial code (e.g., '+1', '+91').
  final void Function(String)? onCountryChanged;

  /// Custom validator function for additional validation. Returns null if valid, error message if invalid.
  final String? Function(String?)? customValidator;

  /// Decoration for the input field.
  final InputDecoration? decoration;

  /// Style for the country picker dialog.
  final PickerDialogStyle? pickerDialogStyle;

  /// Whether the field is enabled.
  final bool enabled;

  /// Hint text for the field.
  final String? hintText;

  /// Type of border for the input field (outline or underline).
  final BorderType borderType;

  const CustomPhoneField({
    super.key,
    this.controller,
    this.initialCountryCode = 'US',
    this.onChanged,
    this.onCountryChanged,
    this.customValidator,
    this.decoration,
    this.pickerDialogStyle,
    this.enabled = true,
    this.hintText,
    this.borderType = BorderType.outline, // Default to outline
  });

  @override
  State<CustomPhoneField> createState() => _CustomPhoneFieldState();
}

class _CustomPhoneFieldState extends State<CustomPhoneField> {
  late TextEditingController _controller;
  String? _errorMessage;
  String? _phoneNumber;
  String? _countryDialCode; // Stores dial code (e.g., '+1')
  String? _countryIsoCode;  // Stores ISO code (e.g., 'US') for validation

  // Map of country ISO codes to expected phone number lengths (excluding dial code)
  // Based on ISO 3166-1 alpha-2 codes and approximate phone number lengths
  // Note: Lengths are simplified; use `phone_number` package for production
  final Map<String, int> _countryPhoneLengths = {
    'AD': 6,  // Andorra
    'AE': 9,  // United Arab Emirates
    'AF': 9,  // Afghanistan
    'AG': 10, // Antigua and Barbuda
    'AI': 10, // Anguilla
    'AL': 9,  // Albania
    'AM': 8,  // Armenia
    'AO': 9,  // Angola
    'AQ': 6,  // Antarctica (variable, simplified)
    'AR': 10, // Argentina
    'AS': 10, // American Samoa
    'AT': 10, // Austria
    'AU': 9,  // Australia
    'AW': 7,  // Aruba
    'AX': 8,  // Åland Islands
    'AZ': 9,  // Azerbaijan
    'BA': 8,  // Bosnia and Herzegovina
    'BB': 10, // Barbados
    'BD': 10, // Bangladesh
    'BE': 9,  // Belgium
    'BF': 8,  // Burkina Faso
    'BG': 9,  // Bulgaria
    'BH': 8,  // Bahrain
    'BI': 8,  // Burundi
    'BJ': 8,  // Benin
    'BL': 9,  // Saint Barthélemy
    'BM': 10, // Bermuda
    'BN': 7,  // Brunei Darussalam
    'BO': 8,  // Bolivia
    'BQ': 7,  // Bonaire, Sint Eustatius and Saba
    'BR': 11, // Brazil
    'BS': 10, // Bahamas
    'BT': 8,  // Bhutan
    'BV': 6,  // Bouvet Island (variable, simplified)
    'BW': 8,  // Botswana
    'BY': 9,  // Belarus
    'BZ': 7,  // Belize
    'CA': 10, // Canada
    'CC': 9,  // Cocos (Keeling) Islands
    'CD': 9,  // Congo, Democratic Republic
    'CF': 8,  // Central African Republic
    'CG': 9,  // Congo
    'CH': 9,  // Switzerland
    'CI': 8,  // Côte d'Ivoire
    'CK': 5,  // Cook Islands
    'CL': 9,  // Chile
    'CM': 9,  // Cameroon
    'CN': 11, // China
    'CO': 10, // Colombia
    'CR': 8,  // Costa Rica
    'CU': 8,  // Cuba
    'CV': 7,  // Cabo Verde
    'CW': 7,  // Curaçao
    'CX': 9,  // Christmas Island
    'CY': 8,  // Cyprus
    'CZ': 9,  // Czechia
    'DE': 10, // Germany
    'DJ': 8,  // Djibouti
    'DK': 8,  // Denmark
    'DM': 10, // Dominica
    'DO': 10, // Dominican Republic
    'DZ': 9,  // Algeria
    'EC': 9,  // Ecuador
    'EE': 8,  // Estonia
    'EG': 10, // Egypt
    'EH': 9,  // Western Sahara
    'ER': 7,  // Eritrea
    'ES': 9,  // Spain
    'ET': 9,  // Ethiopia
    'FI': 9,  // Finland
    'FJ': 7,  // Fiji
    'FK': 6,  // Falkland Islands
    'FM': 7,  // Micronesia
    'FO': 6,  // Faroe Islands
    'FR': 9,  // France
    'GA': 7,  // Gabon
    'GB': 10, // United Kingdom
    'GD': 10, // Grenada
    'GE': 9,  // Georgia
    'GF': 9,  // French Guiana
    'GG': 10, // Guernsey
    'GH': 9,  // Ghana
    'GI': 8,  // Gibraltar
    'GL': 6,  // Greenland
    'GM': 7,  // Gambia
    'GN': 9,  // Guinea
    'GP': 9,  // Guadeloupe
    'GQ': 9,  // Equatorial Guinea
    'GR': 10, // Greece
    'GS': 6,  // South Georgia
    'GT': 8,  // Guatemala
    'GU': 10, // Guam
    'GW': 7,  // Guinea-Bissau
    'GY': 7,  // Guyana
    'HK': 8,  // Hong Kong
    'HM': 6,  // Heard Island (variable, simplified)
    'HN': 8,  // Honduras
    'HR': 9,  // Croatia
    'HT': 8,  // Haiti
    'HU': 9,  // Hungary
    'ID': 10, // Indonesia
    'IE': 9,  // Ireland
    'IL': 9,  // Israel
    'IM': 10, // Isle of Man
    'IN': 10, // India
    'IO': 7,  // British Indian Ocean Territory
    'IQ': 10, // Iraq
    'IR': 10, // Iran
    'IS': 7,  // Iceland
    'IT': 10, // Italy
    'JE': 10, // Jersey
    'JM': 10, // Jamaica
    'JO': 9,  // Jordan
    'JP': 10, // Japan
    'KE': 10, // Kenya
    'KG': 9,  // Kyrgyzstan
    'KH': 9,  // Cambodia
    'KI': 8,  // Kiribati
    'KM': 7,  // Comoros
    'KN': 10, // Saint Kitts and Nevis
    'KP': 8,  // North Korea
    'KR': 10, // South Korea
    'KW': 8,  // Kuwait
    'KY': 10, // Cayman Islands
    'KZ': 10, // Kazakhstan
    'LA': 9,  // Laos
    'LB': 8,  // Lebanon
    'LC': 10, // Saint Lucia
    'LI': 7,  // Liechtenstein
    'LK': 9,  // Sri Lanka
    'LR': 7,  // Liberia
    'LS': 8,  // Lesotho
    'LT': 8,  // Lithuania
    'LU': 9,  // Luxembourg
    'LV': 8,  // Latvia
    'LY': 9,  // Libya
    'MA': 9,  // Morocco
    'MC': 8,  // Monaco
    'MD': 8,  // Moldova
    'ME': 8,  // Montenegro
    'MF': 9,  // Saint Martin
    'MG': 7,  // Madagascar
    'MH': 7,  // Marshall Islands
    'MK': 8,  // North Macedonia
    'ML': 8,  // Mali
    'MM': 9,  // Myanmar
    'MN': 8,  // Mongolia
    'MO': 8,  // Macao
    'MP': 10, // Northern Mariana Islands
    'MQ': 9,  // Martinique
    'MR': 8,  // Mauritania
    'MS': 10, // Montserrat
    'MT': 8,  // Malta
    'MU': 8,  // Mauritius
    'MV': 7,  // Maldives
    'MW': 9,  // Malawi
    'MX': 10, // Mexico
    'MY': 9,  // Malaysia
    'MZ': 9,  // Mozambique
    'NA': 9,  // Namibia
    'NC': 6,  // New Caledonia
    'NE': 8,  // Niger
    'NF': 6,  // Norfolk Island
    'NG': 10, // Nigeria
    'NI': 8,  // Nicaragua
    'NL': 9,  // Netherlands
    'NO': 8,  // Norway
    'NP': 10, // Nepal
    'NR': 7,  // Nauru
    'NU': 6,  // Niue
    'NZ': 9,  // New Zealand
    'OM': 8,  // Oman
    'PA': 8,  // Panama
    'PE': 9,  // Peru
    'PF': 6,  // French Polynesia
    'PG': 7,  // Papua New Guinea
    'PH': 10, // Philippines
    'PK': 10, // Pakistan
    'PL': 9,  // Poland
    'PM': 6,  // Saint Pierre and Miquelon
    'PN': 6,  // Pitcairn
    'PR': 10, // Puerto Rico
    'PS': 9,  // Palestine
    'PT': 9,  // Portugal
    'PW': 7,  // Palau
    'PY': 9,  // Paraguay
    'QA': 8,  // Qatar
    'RE': 9,  // Réunion
    'RO': 9,  // Romania
    'RS': 9,  // Serbia
    'RU': 10, // Russia
    'RW': 9,  // Rwanda
    'SA': 9,  // Saudi Arabia
    'SB': 7,  // Solomon Islands
    'SC': 7,  // Seychelles
    'SD': 9,  // Sudan
    'SE': 9,  // Sweden
    'SG': 8,  // Singapore
    'SH': 6,  // Saint Helena
    'SI': 8,  // Slovenia
    'SJ': 8,  // Svalbard and Jan Mayen
    'SK': 9,  // Slovakia
    'SL': 8,  // Sierra Leone
    'SM': 8,  // San Marino
    'SN': 9,  // Senegal
    'SO': 8,  // Somalia
    'SR': 7,  // Suriname
    'SS': 9,  // South Sudan
    'ST': 7,  // Sao Tome and Principe
    'SV': 8,  // El Salvador
    'SX': 10, // Sint Maarten
    'SY': 9,  // Syria
    'SZ': 8,  // Eswatini
    'TC': 10, // Turks and Caicos Islands
    'TD': 8,  // Chad
    'TF': 6,  // French Southern Territories
    'TG': 8,  // Togo
    'TH': 9,  // Thailand
    'TJ': 9,  // Tajikistan
    'TK': 6,  // Tokelau
    'TL': 8,  // Timor-Leste
    'TM': 8,  // Turkmenistan
    'TN': 8,  // Tunisia
    'TO': 7,  // Tonga
    'TR': 10, // Turkey
    'TT': 10, // Trinidad and Tobago
    'TV': 6,  // Tuvalu
    'TW': 9,  // Taiwan
    'TZ': 9,  // Tanzania
    'UA': 9,  // Ukraine
    'UG': 9,  // Uganda
    'UM': 10, // United States Minor Outlying Islands
    'US': 10, // United States
    'UY': 8,  // Uruguay
    'UZ': 9,  // Uzbekistan
    'VA': 6,  // Vatican City
    'VC': 10, // Saint Vincent and the Grenadines
    'VE': 10, // Venezuela
    'VG': 10, // Virgin Islands, British
    'VI': 10, // Virgin Islands, U.S.
    'VN': 10, // Vietnam
    'VU': 7,  // Vanuatu
    'WF': 6,  // Wallis and Futuna
    'WS': 7,  // Samoa
    'YE': 9,  // Yemen
    'YT': 9,  // Mayotte
    'ZA': 9,  // South Africa
    'ZM': 9,  // Zambia
    'ZW': 9,  // Zimbabwe
  };

  @override
  void initState() {
    super.initState();
    _controller = widget.controller ?? TextEditingController();
    _countryIsoCode = widget.initialCountryCode.toUpperCase();
    _countryDialCode = _getInitialDialCode(widget.initialCountryCode);
  }

  /// Helper to get initial dial code based on ISO code
  String _getInitialDialCode(String isoCode) {
    // Simplified mapping for initial dial code; in practice, use intl_phone_field's country list
    final country = Countries.allCountries.firstWhere(
          (c) => c['code'] == isoCode.toUpperCase(),
      orElse: () => {'dial_code': '+1'}, // Default to US if not found
    );
    return country['dial_code'] as String;
  }

  @override
  void dispose() {
    if (widget.controller == null) {
      _controller.dispose();
    }
    super.dispose();
  }

  /// Validates the phone number based on country length and custom validator.
  String? _validatePhoneNumber(PhoneNumber? phone) {
    if (phone == null || phone.number.isEmpty) {
      return 'Please enter a phone number.';
    }

    // Extract national number (digits only)
    final nationalNumber = phone.number.replaceAll(RegExp(r'[^0-9]'), '');
    final countryIsoCode = _countryIsoCode ?? widget.initialCountryCode.toUpperCase();
    final expectedLength = _countryPhoneLengths[countryIsoCode] ?? 10; // Default to 10 if not specified

    // Check if the number contains only digits
    if (!RegExp(r'^[0-9]+$').hasMatch(nationalNumber)) {
      return 'Phone number must contain only digits.';
    }

    if (nationalNumber.length < expectedLength) {
      return 'Phone number for $countryIsoCode is too short. Must be $expectedLength digits (entered: ${nationalNumber.length}).';
    }

    if (nationalNumber.length > expectedLength) {
      return 'Phone number for $countryIsoCode is too long. Must be $expectedLength digits (entered: ${nationalNumber.length}).';
    }

    // Run custom validator if provided
    if (widget.customValidator != null) {
      return widget.customValidator!(phone.completeNumber);
    }

    return null;
  }

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 45.h, // Fixed height for the field
      child: IntlPhoneField(
        controller: _controller,
        textAlignVertical: TextAlignVertical.center, // Center text vertically
        style: Theme.of(context).textTheme.titleMedium, // Consistent text style for number
        dropdownTextStyle: Theme.of(context).textTheme.bodyLarge, // Match country code style
        flagsButtonPadding: const EdgeInsets.only(left: 8), // Align country code selector
        decoration: widget.decoration ??
            InputDecoration(
              hintText: widget.hintText,
              border: widget.borderType == BorderType.outline
                  ? const OutlineInputBorder()
                  :  UnderlineInputBorder(borderSide: BorderSide(color: Theme.of(context).colorScheme.onPrimaryContainer)),
              enabledBorder: widget.borderType == BorderType.outline
                  ? const OutlineInputBorder()
                  :  UnderlineInputBorder(borderSide: BorderSide(color: Theme.of(context).colorScheme.outline)),
              focusedBorder: widget.borderType == BorderType.outline
                  ? const OutlineInputBorder(
                borderSide: BorderSide(color: Colors.blue, width: 2.0),
              )
                  : const UnderlineInputBorder(
                borderSide: BorderSide(color: Colors.blue, width: 2.0),
              ),
              errorBorder: widget.borderType == BorderType.outline
                  ? const OutlineInputBorder(
                borderSide: BorderSide(color: Colors.red),
              )
                  : const UnderlineInputBorder(
                borderSide: BorderSide(color: Colors.red),
              ),
              focusedErrorBorder: widget.borderType == BorderType.outline
                  ? const OutlineInputBorder(
                borderSide: BorderSide(color: Colors.red, width: 2.0),
              )
                  : const UnderlineInputBorder(
                borderSide: BorderSide(color: Colors.red, width: 2.0),
              ),
              contentPadding: EdgeInsets.only(top: 8.h), // Minimal padding for alignment
              errorText: _errorMessage,
              errorStyle: const TextStyle(color: Colors.red, fontSize: 16),
            ),
        initialCountryCode: widget.initialCountryCode,
        enabled: widget.enabled,
        pickerDialogStyle: widget.pickerDialogStyle ??
            PickerDialogStyle(
              countryNameStyle: const TextStyle(fontSize: 16),
            ),
        onChanged: (phone) {
          setState(() {
            _phoneNumber = phone.completeNumber;
            _errorMessage = _validatePhoneNumber(phone);
          });
          if (widget.onChanged != null) {
            widget.onChanged!(phone.completeNumber);
          }
        },
        validator: _validatePhoneNumber,
        onCountryChanged: (country) {
          setState(() {
            _countryIsoCode = country.code.toUpperCase();
            _countryDialCode = country.dialCode;
            _errorMessage = _validatePhoneNumber(
              _phoneNumber != null
                  ? PhoneNumber(
                number: _controller.text,
                countryISOCode: _countryIsoCode!,
                countryCode: _countryDialCode!,
              )
                  : null,
            );
          });
          if (widget.onCountryChanged != null) {
            widget.onCountryChanged!(country.dialCode);
          }
        },
      ),
    );
  }

  /// Returns the current phone number (with dial code).
  String? get phoneNumber => _phoneNumber;

  /// Returns the current country dial code.
  String? get countryDialCode => _countryDialCode;

  /// Validates the current phone number and returns true if valid.
  bool validate() {
    setState(() {
      _errorMessage = _validatePhoneNumber(
        _phoneNumber != null
            ? PhoneNumber(
          number: _controller.text,
          countryISOCode: _countryIsoCode ?? widget.initialCountryCode,
          countryCode: _countryDialCode ?? _getInitialDialCode(widget.initialCountryCode),
        )
            : null,
      );
    });
    return _errorMessage == null;
  }

  /// Clears the phone number field.
  void clear() {
    setState(() {
      _controller.clear();
      _phoneNumber = null;
      _errorMessage = null;
    });
  }
}
