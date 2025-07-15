// ignore_for_file: non_constant_identifier_names, constant_identifier_names

import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/cupertino.dart';

import '../../app/get_it/get_it.dart';
import 'lang_repo.dart';

abstract class Loc {
 /* static void switchLanguage(BuildContext context) {
    Locale currentLocale = context.locale;

    // Switch between English and Arabic
    if (currentLocale.languageCode == 'en') {
      context.setLocale(const Locale('ar'));
      di<LangRepo>().setLang("ar", context);
    } else {
      context.setLocale(const Locale('en'));
      di<LangRepo>().setLang("en", context);
    }
    //Nav.mainLayout(context);
    // Rebuild the UI to reflect the language change
  }*/



  static String noTradingAccounts() => 'no_trading_accounts'.tr();
  static String addTradingAccount() => 'add_trading_account'.tr();
  static String openDemoAccount() => 'open_demo_account'.tr();
  static String openRealAccount() => 'open_real_account'.tr();
  static String personalInformation() => 'personal_information'.tr();
  static String userName() => 'user_name'.tr();
  static String firstName() => 'first_name'.tr();
  static String secondName() => 'second_name'.tr();
  static String dateOfBirth() => 'date_of_birth'.tr();
  static String email() => 'email'.tr();
  static String useHedgeInTrading() => 'use_hedge_in_trading'.tr();
  static String server() => 'server'.tr();
  static String accountType() => 'account_type'.tr();
  static String leverage() => 'leverage'.tr();
  static String deposit() => 'deposit'.tr();
  static String agreements() => 'agreements'.tr();
  static String acceptTerms() => 'accept_terms'.tr();
  static String requiredField() => 'required_field'.tr();
  static String register() => 'register'.tr();
  static String errorOccurred() => 'error_occurred'.tr();
  static String pleaseSelectDob() => 'please_select_dob'.tr();
  static String ok() => 'ok'.tr();

  // Account types
  static String forexHedgedUsd() => 'forex_hedged_usd'.tr();
  static String forexHedgedEur() => 'forex_hedged_eur'.tr();
  static String forexHedgedJpy() => 'forex_hedged_jpy'.tr();
  static String forexHedgedGbp() => 'forex_hedged_gbp'.tr();
  static String forexHedgedChf() => 'forex_hedged_chf'.tr();
  static String forexHedgedUsdFloatingLeverage() => 'forex_hedged_usd_floating_leverage'.tr();

  // Leverages
  static String leverage1_1() => 'leverage_1_1'.tr();
  static String leverage1_3() => 'leverage_1_3'.tr();
  static String leverage1_5() => 'leverage_1_5'.tr();
  static String leverage1_10() => 'leverage_1_10'.tr();
  static String leverage1_15() => 'leverage_1_15'.tr();
  static String leverage1_25() => 'leverage_1_25'.tr();
  static String leverage1_33() => 'leverage_1_33'.tr();
  static String leverage1_50() => 'leverage_1_50'.tr();
  static String leverage1_100() => 'leverage_1_100'.tr();
  static String leverage1_200() => 'leverage_1_200'.tr();
  static String leverage1_500() => 'leverage_1_500'.tr();
  static String leverage1_1000() => 'leverage_1_1000'.tr();

  // Deposits
  static String deposit3000() => 'deposit_3000'.tr();
  static String deposit5000() => 'deposit_5000'.tr();
  static String deposit10000() => 'deposit_10000'.tr();
  static String deposit25000() => 'deposit_25000'.tr();
  static String deposit50000() => 'deposit_50000'.tr();
  static String deposit100000() => 'deposit_100000'.tr();
  
  
  ///XXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXX///
  

  static String en() => 'en';

  static String start_now() => 'start_now'.tr();

  static String next() => 'next'.tr();

  static String cameraSubtitle() => 'camersSubtitle'.tr();

  static String login() => 'login'.tr();

  static String midiationServices() => 'midiationServices'.tr();

  static String monthlyServices() => 'monthlyServices'.tr();



  static String phone() => 'phone'.tr();

  static String gender() => 'gender'.tr();

  static String noInternetConnection() => 'noInternetConnection'.tr();

  static String checkNetworkSettings() => 'checkNetworkSettings'.tr();

  static String connectedNoInternet() => 'connectedNoInternet'.tr();

  static String checkNetworkSettingsLater() => 'checkNetworkSettingsLater'.tr();

  /// -------------------------------------------------
  /// 
  /// 
  /// 
  /// 
  /// 
  /// 
  /// 
  /// 
  /// 
  /// 
  /// 
  static String updateAvailableTitle() => 'update_available_title'.tr();
  static String updateAvailableMessage() => 'update_available_message'.tr();
  static String updateNow() => 'update_now'.tr();
  static String skip() => 'skip'.tr();
  static String errorLaunchUrl() => 'error_launch_url'.tr();
  static String noInternetTitle() => 'no_internet_title'.tr();
  static String noInternetMessage() => 'no_internet_message'.tr();
  static String retry() => 'retry'.tr();
  static String retrying() => 'retrying'.tr();
  static String chooseThemeTitle() => 'choose_theme_title'.tr();
  static String systemDefault() => 'system_default'.tr();
  static String lightTheme() => 'light_theme'.tr();
  static String darkTheme() => 'dark_theme'.tr();
  static String cancelButton() => 'cancel_button'.tr();

  // Terms and Conditions dialog keys
  static String termsWelcomeTitle(String appName) =>
      'terms_welcome_title'.tr(args: [appName]);

  static String termsIntroText1() => 'terms_intro_text1'.tr();

  static String termsPrivacyPolicy() => 'terms_privacy_policy'.tr();

  static String termsIntroText2() => 'terms_intro_text2'.tr();

  static String termsIntroText3() => 'terms_intro_text3'.tr();

  static String termsAcceptStatement1() => 'terms_accept_statement1'.tr();

  static String termsEULA() => 'terms_eula'.tr();

  static String termsAnd() => 'terms_and'.tr();

  static String termsPrivacyPolicyBold() => 'terms_privacy_policy_bold'.tr();

  static String termsAcceptStatement2() => 'terms_accept_statement2'.tr();

  static String termsAcceptButton() => 'terms_accept_button'.tr();

  static String termsDeclineButton() => 'terms_decline_button'.tr();

  static String termsRealAccountNotice() => 'terms_real_account_notice'.tr();
  static String yes() => 'yes'.tr();
  static String noConnection() => 'no_connection'.tr();
  static String openWifiSettings() => 'open_wifi_settings'.tr();
  static String visitDetails() => 'visitDetails'.tr();
  static String trade() => 'trade'.tr();
  static String order() => 'order'.tr();
  static String time() => 'time'.tr();
  static String symbol() => 'symbol'.tr();
  static String profit() => 'profit'.tr();
  static String balance() => 'balance'.tr();
  static String equity() => 'equity'.tr();
  static String margin() => 'margin'.tr();
  static String freeMargin() => 'free_margin'.tr();
  static String marginLevel() => 'margin_level'.tr();
  static String positions() => 'positions'.tr();
  static String allPositionsClosed() => 'all_positions_closed'.tr();
  static String buy() => 'buy'.tr();
  static String sell() => 'sell'.tr();
  static String modifyPosition() => 'modify_position'.tr();
  static String sl() => 'sl'.tr();
  static String tp() => 'tp'.tr();
  static String modify() => 'modify'.tr();
  static String closePosition() => 'close_position'.tr();
  static String close() => 'close'.tr();
  static String request() => 'request'.tr();
  static String accounts() => 'accounts'.tr();
  static String changeMasterPassword() => 'change_master_password'.tr();
  static String changeInvestorPassword() => 'change_investor_password'.tr();
  static String clearSavedPassword() => 'clear_saved_password'.tr();
  static String deleteAccount() => 'delete_account'.tr();
  static String traderVoltTest() => 'trader_volt_test'.tr();
  static String traderVoltLtd() => 'trader_volt_ltd'.tr();
  static String loginId() => 'login_id'.tr();
  static String traderVoltQuotesDemo() => 'trader_volt_quotes_demo'.tr();
  static String accessPointEu0Hedge() => 'access_point_eu0_hedge'.tr();
  static String balanceGbp() => 'balance_gbp'.tr();
  static String currentMasterPassword() => 'current_master_password'.tr();
  static String newMasterPassword() => 'new_master_password'.tr();
  static String passwordRequirements() => 'password_requirements'.tr();
  static String done() => 'done'.tr();
  static String noName() => 'no_name'.tr();

  static String learnTrading() => 'learn_trading'.tr();
  static String loginExistingAccount() => 'login_existing_account'.tr();
  static String traderVoltDemo() => 'trader_volt_demo'.tr();
  static String traderVoltDemoB() => 'trader_volt_demo_b'.tr();

  static String password() => 'password'.tr();
  static String savePassword() => 'save_password'.tr();
  static String forgotPassword() => 'forgot_password'.tr();
  static String loginButton() => 'login_button'.tr();


  static String traderVoltQuotes() => 'trader_volt_quotes'.tr();
  static String useSearch() => 'use_search'.tr();
  static String brokerageCaution() => 'brokerage_caution'.tr();
  static String regulatoryInfo() => 'regulatory_info'.tr();


  static String useSearchToFindCompany() => 'use_search_to_find_company'.tr();

  static String contactDetailsInfo() => 'contact_details_info'.tr();


  static String brokersTitle() => 'brokers_title'.tr();
  static String findBrokerHint() => 'find_broker_hint'.tr();
  static String noBrokersFound() => 'no_brokers_found'.tr();
  static String noData() => 'no_data'.tr();
  static String cantFindBroker() => 'cant_find_broker'.tr();
  static String brokerSavedSuccessfully() => 'broker_saved_successfully'.tr();
  static String language() => 'language'.tr();
  static String lockScreen() => 'lock_screen'.tr();
  static String lockScreenWhenHidden() => 'lock_screen_when_hidden'.tr();
  static String apply() => 'apply'.tr();
  static String cancel() => 'cancel'.tr();
  static String name() => 'name'.tr();
  static String traderVolt() => 'trader_volt'.tr();
  
  static String demo() => 'demo'.tr();
 
  static String forexHedgedGpb() => 'forex_hedged_gpb'.tr();
  static String newAccountSuccessfullyCreated() => 'new_account_successfully_created'.tr();


  static String passwordValue() => 'password_value'.tr();
  static String investor() => 'investor'.tr();
  static String investorValue() => 'investor_value'.tr();
  static String downloadDesktopVersion() => 'download_desktop_version'.tr();




  static String min2Chars() => 'min_2_chars'.tr();


  static String pleaseSelect() => 'please_select'.tr();
 
  static String phoneHint() => 'phone_hint'.tr();

  static String emailHint() => 'email_hint'.tr();
  static String accountInformation() => 'account_information'.tr();


  static String bidLabel() => 'bid_label'.tr();
  static String askLabel() => 'ask_label'.tr();
  static String tradingViewTitle() => 'trading_view_title'.tr();
  static String mailboxTitle() => 'mailbox_title'.tr();
  static String cancelLabel() => 'cancel_label'.tr();

  static String toLabel() => 'to_label'.tr();
  static String subjectLabel() => 'subject_label'.tr();
  static String yourMessageLabel() => 'your_message_label'.tr();
  static String replyPrefix() => 'reply_prefix'.tr();
  static String deleteLabel() => 'delete_label'.tr();
  static String readLabel() => 'read_label'.tr();
  static String otpTitle() => 'otp_title'.tr();
  static String authorizationLabel() => 'authorization_label'.tr();

  static String enterCodeInstruction() => 'enter_code_instruction'.tr();
  static String bindToAccount() => 'bind_to_account'.tr();
  static String changePassword() => 'change_password'.tr();
  static String synchronizeTime() => 'synchronize_time'.tr();
  static String lastInPrefix() => 'last_in_prefix'.tr();

  static String historyTitle() => 'history_title'.tr();
  static String positionsTab() => 'positions_tab'.tr();
  static String ordersTab() => 'orders_tab'.tr();
  static String dealsTab() => 'deals_tab'.tr();

  static String filled() => 'filled'.tr();
  static String canceled() => 'canceled'.tr();
  static String total() => 'total'.tr();

  static String swap() => 'swap'.tr();
  static String commission() => 'commission'.tr();

  static String at() => 'at'.tr();
  static String stopLoss() => 'stop_loss'.tr();
  static String takeProfit() => 'take_profit'.tr();
  static String chart() => 'chart'.tr();
  static String open() => 'open'.tr();
  static String id() => 'id'.tr();
  static String commition() => 'commition'.tr();
  static String allSymbols() => 'all_symbols'.tr();
  static String selectDate() => 'select_date'.tr();
  static String today() => 'today'.tr();
  static String thisWeek() => 'this_week'.tr();
  static String thisMonth() => 'this_month'.tr();
  static String customPeriod() => 'custom_period'.tr();


  static String quotes() => 'quotes'.tr();
  static String somethingWentWrong() => 'something_went_wrong'.tr();
  static String charts() => 'charts'.tr();
  static String exposure() => 'exposure'.tr();
  static String manageAccount() => 'manage_account'.tr();
  static String loginOrOpen() => 'login_or_open'.tr();
  static String getStarted() => 'get_started'.tr();

  static String news() => 'news'.tr();
  static String mailbox() => 'mailbox'.tr();
  static String journal() => 'journal'.tr();
  static String settings() => 'settings'.tr();
  static String economicCalendar() => 'economic_calendar'.tr();
  static String userGuide() => 'user_guide'.tr();
  static String about() => 'about'.tr();
  static String commaSeparator() => 'commaSeparator'.tr();
  static String stopLossLabel() => 'S/L:'.tr();
  static String swapLabel() => 'Swap:'.tr();
  static String zeroValue() => '0.00'.tr();
  static String takeProfitLabel() => 'T/P:'.tr();
  static String positionIdPrefix() => 'positionIdPrefix'.tr();
  static String titleSuffix() => ':'.tr();
  static String dottedLine() => '.'.tr();
  static String buyLabel() => 'buyLabel'.tr();

  static String newOrder() => 'newOrder'.tr();

  static String bulkOperations() => 'bulkOperations'.tr();
  static String closeAllPositions() => 'closeAllPositions'.tr();
  static String closeProfitablePositions() => 'closeProfitablePositions'.tr();
  static String closeLosingPositions() => 'closeLosingPositions'.tr();
  static String closeAction() => 'closeAction'.tr();
  static String closingOrderFailed() => 'closingOrderFailed'.tr();
  static String hideButton() => 'hideButton'.tr();
  static String doneButton() => 'doneButton'.tr();
  static String balanceValue() => 'balanceValue'.tr();
  static String onLine() => 'online'.tr();
  static String offLine() => 'offline'.tr();
  static String equityValue() => 'equityValue'.tr();
  static String marginValue() => 'marginValue'.tr();
  static String freeMarginValue() => 'freeMarginValue'.tr();
  static String marginLevelValue() => 'marginLevelValue'.tr();
  static String atSeparator() => 'atSeparator'.tr();
  static String modifyPositionAction() => 'modifyPositionAction'.tr();
  static String stopLossAbbreviation() => 'stopLossAbbreviation'.tr();
  static String takeProfitAbbreviation() => 'takeProfitAbbreviation'.tr();
  static String modifyAction() => 'modifyAction'.tr();
  static String closePositionAction() => 'closePositionAction'.tr();
  static String closeOrderAction() => 'closeOrderAction'.tr();
  static String requestAction() => 'requestAction'.tr();
  static String symbolHeader() => 'symbolHeader'.tr();
  static String bidHeader() => 'bidHeader'.tr();
  static String askHeader() => 'askHeader'.tr();
  static String properties() => 'properties'.tr();
  static String depthOfMarket() => 'depthOfMarket'.tr();
  static String marketStatistics() => 'marketStatistics'.tr();
  static String simpleViewMode() => 'simpleViewMode'.tr();
  static String advancedViewMode() => 'advancedViewMode'.tr();
  static String viewMode() => 'viewMode'.tr();
  static String indicatorUp() => 'indicatorUp'.tr();
  static String indicatorDown() => 'indicatorDown'.tr();
  static String indicatorDot() => 'indicatorDot'.tr();
  static String openDemoAccountTitle() => 'open_demo_account_title'.tr();
  static String tradervoltLtd() => 'tradervolt_ltd'.tr();
  static String websiteUrl() => 'website_url'.tr();
  static String accountOpeningTerms() => 'account_opening_terms'.tr();
  static String openAccountButton() => 'open_account_button'.tr();
  static String realTradingAccountNotice() => 'real_trading_account_notice'.tr();
  static String maintenanceTitle() => 'maintenance_title'.tr();
  static String maintenanceMessage() => 'maintenance_message'.tr();
  static String checkAgain() => 'check_again'.tr();
  static String checkingStatus() => 'checking_status'.tr();
  


 
  static String advancedMode() => 'advanced_mode'.tr();
  static String advancedModeDesc() => 'advanced_mode_desc'.tr();
  static String orderSounds() => 'order_sounds'.tr();
  static String playSoundsDesc() => 'play_sounds_desc'.tr();
  static String oneClickTrading() => 'one_click_trading'.tr();
  static String oneClickTradingDesc() => 'one_click_trading_desc'.tr();
  static String security() => 'security'.tr();
  static String otp() => 'otp'.tr();
  static String otpDesc() => 'otp_desc'.tr();
  static String interface() => 'interface'.tr();

  static String chooseTheme() => 'choose_theme'.tr();

  static String decimalPoint() => 'decimal_point'.tr();
  static String zeroDigit() => 'zero_digit'.tr();

  static String cantFindBrokerTitle() => 'cant_find_broker_title'.tr();
  static String cantFindBrokerMessage() => 'cant_find_broker_message'.tr();
  static String okButton() => 'ok_button'.tr();
  static String pleaseWait() => 'please_wait'.tr();
  
  
  ///
  /// 
  /// 
  /// 
  /// 
  /// 
  /// 
  /// 
  /// 
  /// 
  /// 
  /// 
  /// 
  
  

  static String date() => 'date'.tr();

  static String visitStatus() => 'visitStatus'.tr();

  static String newStatus() => 'newStatus'.tr();

  static String visitContract() => 'visitContract'.tr();

  static String visits() => 'visits'.tr();

  static String previousVisits() => 'previousVisits'.tr();

  static String upcomingVisits() => 'upcomingVisits'.tr();

  static String confirmContractCancel() => 'confirmContractCancel'.tr();

  static String server_key() => 'server_key'.tr();

  static String contractDetails() => 'contractDetails'.tr();



  static String contractNumber() => 'contractNumber'.tr();

  static String amount() => 'amount'.tr();

  static String requestDate() => 'requestDate'.tr();

  static String active() => 'active'.tr();

  static String expired() => 'expired'.tr();

  static String password_weak() => 'password_weak'.tr();

  static String contracts() => 'contracts'.tr();

  static String password_must_contain() => 'password_must_contain'.tr();

  static String search() => 'search'.tr();

  static String soonSubtitle() => 'soonSubtitle'.tr();

  static String confirm() => 'confirm'.tr();

  static String pick_file_source() => 'pick_file_source'.tr();

  static String gallery() => 'gallery'.tr();

  static String camera() => 'camera'.tr();

  static String english() => 'en'.tr();
  static String mandarinChinese() => 'mandarinChinese'.tr();
  static String hindi() => 'hi'.tr();
  static String spanish() => 'es'.tr();
  static String french() => 'fr'.tr();
  static String arabic() => 'ar'.tr();
  static String bengali() => 'bn'.tr();
  static String portuguese() => 'pt'.tr();
  static String russian() => 'ru'.tr();
  static String urdu() => 'ur'.tr();
  static String unknownLanguage() => 'unknownLanguage'.tr();
  static String alert() => 'alert'.tr();

  static String splash_title_1() => 'splash_title_1'.tr();

  static String splash_title_2() => 'splash_title_2'.tr();

  static String splash_title_3() => 'splash_title_3'.tr();

  static String splash_sub_title_1() => 'splash_sub_title_1'.tr();

  static String splash_sub_title_2() => 'splash_sub_title_2'.tr();

  static String splash_sub_title_3() => 'splash_sub_title_3'.tr();

  static String login_page_subtitle() => 'login_page_subtitle'.tr();

  static String phone_number() => 'phone_number'.tr();

  static String continuee() => 'continuee'.tr();

  static String terms_hint() => 'terms_hint'.tr();

  static String terms_and_conditions() => 'terms_and_conditions'.tr();

  static String agree() => 'agree'.tr();

  static String soon() => 'soon'.tr();

  static String confirm_register() => 'confirm_register'.tr();

  static String confirmation_code_sent_to_number() =>
      'confirmation_code_sent_to_number'.tr();

  static String confirm_code() => 'confirm_code'.tr();

  static String write_name() => 'write_name'.tr();

  static String create_account() => "create_account".tr();

  static String searchInCountries() => "country".tr();

  static String terms_and_condition_content() =>
      "terms_and_condition_content".tr();

  static String about_to_finish() => 'about_to_finish'.tr();

  static String enter_name_to_continue() => 'enter_name_to_continue'.tr();

  static String didnt_receive_code() => 'didnt_receive_code'.tr();

  static String resend_code() => 'resend_code'.tr();

  static String emptyPhoneNumber() => 'emptyPhoneNumber'.tr();

  static String generalUnvaildPhoneNumber() => 'unvaildPhoneNumber'.tr();

  static String otbIsEmpty() => 'otbEmptyValue'.tr();

  static String egyptUnvaildPhoneNumber() =>
      'EgyptPhoneNumberValidMassage'.tr();

  static String home() => 'home'.tr();

  static String aboutPrivacy() => 'aboutPrivacy'.tr();

  static String askForHelpMassage() => 'askForHelpMassage'.tr();

  static String askForHelpTitle() => 'askForHelpTitle'.tr();

  static String chat() => 'chat'.tr();

  static String addPerson() => 'addPerson'.tr();

  static String mySettings() => 'mySettings'.tr();

  static String searchHintText() => 'searchHintText'.tr();

  static String aiTitle() => 'aiTitle'.tr();

  static String chatExample() => 'chatExample'.tr();

  static String sendMassageHint() => 'sendMassageHint'.tr();

  static String send() => 'send'.tr();

  static String addPerson2() => 'addPerson2'.tr();

  static String contactInfoForProposedPerson() =>
      'contactInfoForProposedPerson'.tr();

  static String addContactFormExample() => 'addContactFormExample'.tr();

  static String personName() => 'personName'.tr();

  static String phoneNumber() => 'phoneNumber'.tr();

  static String male() => 'male'.tr();

  static String byDays() => 'byDays'.tr();

  static String byMonths() => 'byMonths'.tr();

  static String female() => 'female'.tr();

  static String placeOfBirth() => 'placeOfBirth'.tr();

  static String placeOfWork() => 'placeOfWork'.tr();

  static String noteAboutPerson() => 'noteAboutPerson'.tr();

  static String noteAboutPersonExample() => 'noteAboutPersonExample'.tr();

  static String whatDoYouWork() => 'whatDoYouWork'.tr();

  static String wordsYouCanEasilyCommunicateWith() =>
      'wordsYouCanEasilyCommunicateWith'.tr();

  static String wordsYouCanEasilyCommunicateWithExample() =>
      'wordsYouCanEasilyCommunicateWithExample'.tr();

  static String second() => 'second'.tr();

  static String dismiss() => 'dismiss'.tr();

  static String add() => 'add'.tr();

  static String writeYourSearchWords() => 'writeYourSearchWord'.tr();

  static String appName() => 'appName'.tr();

  static String youCanShareYourContactsTile() =>
      'youCanShareYourContactsTile'.tr();

  static String shareMyContacts() => 'shareMyContacts'.tr();

  static String areYouSureToShareYourContacts() =>
      'areYouSureToShareYourContacts'.tr();

  static String shareContactsDialogSubtitle() =>
      'shareContactsDialogSubtitle'.tr();

  static String dontWanna() => 'iDontWant'.tr();

  static String yesShare() => 'yesShare'.tr();

  static String noCancel() => 'noCancel'.tr();


  static String filter() => 'filter'.tr();

  static String welcome() => 'welcome'.tr();

  static String aboutApp() => 'aboutApp'.tr();

  static String shareApp() => 'shareApp'.tr();

  static String friendYouShareWith() => 'friendYouShareWith'.tr();

  static String noSearchResult() => 'noSearchResult'.tr();

  static String forBetterSearchResultMassage() =>
      'forBetterSearchResultMassage'.tr();

  static String pleaseAcceptTermsAndConditions() =>
      'acceptTermsAndConditions'.tr();

  static String lastUpdate() => 'lastUpdate'.tr();

  static String aboutAppDescription() => 'aboutAppDescription'.tr();

  static String callUs() => 'call_us'.tr();

  static String rate_app() => 'rateApp'.tr();

  static String update_contacts_message() => 'update_contacts_message'.tr();

  static String update() => 'update'.tr();

  static String another_time() => 'another_time'.tr();

  static String emptyName() => 'emptyUserName'.tr();

  static String loginErrorMassage() => 'loginErrorMassage'.tr();

  static String updateImageMessage() => 'updateImageMessage'.tr();

  static String genderValidationMassageNew() => 'genderValidateMassage'.tr();

  static String placeOfBirthValidateMassage() =>
      'placeOfBirthValidateMassage'.tr();

  static String placeOfWorkValidateMassage() =>
      'placeOfWorkValidateMassage'.tr();

  static String notesValidationMassage() => 'notesValidationMassage'.tr();

  static String emptyNationality() => 'emptyNationality'.tr();

  static String emptyIdNumber() => 'emptyIdNumber'.tr();

  static String wordsToCommunicateValidationMassage() =>
      'wordsToCommunicateValidationMassage'.tr();

  static String jobValidationMassage() => 'jobValidationMassage'.tr();

  static String addSuccessfullMassage() => 'addSuccessfullyAdd'.tr();

  static String shareSuccessfullMassage() => 'shareSuccessfullyAdd'.tr();

  static String categories() => "categories".tr();

  static String countryLabel() => 'countryLabel'.tr();

 

  static String noCity() => 'noCity'.tr();

  static String noPlaceOfWork() => 'noPlaceOfWork'.tr();

  static String accessDenied() => 'accessDenied'.tr();

  static String searchIsEmpty() => 'searchIsEmpty'.tr();

  static String saveAndUpdateAnotherContact() =>
      'saveAndUpdateAnotherContact'.tr();

  static String SaveOnlyTheCurrent() => 'saveOnlyTheCurrent'.tr();

  static String saveEditedData() => 'saveEditedData'.tr();

  static String logoutTitle() => 'logoutTitle'.tr();

  static String logoutSubtitle() => 'logoutSubtitle'.tr();

  static String areYouSureAboutDeleting() => 'areYouSureAboutSave'.tr();



  
  
  static String openMobileData() => 'open_mobile_data'.tr();
  static String no() => 'no'.tr();

  static String noPlaceOfBirth() => 'noPlaceOfBirth'.tr();

  static String noJob() => 'noJob'.tr();

  static String delete() => 'delete'.tr();

  static String selectImageFromGallery() => 'selectImageFromGallery'.tr();

  static String selectImage() => 'selectImage'.tr();

  static String profileHasNoImags() => 'profileHasNoImags'.tr();

  static String city() => 'city'.tr();




 

  static String reset() => 'reset'.tr();

  static String verificationFailed() => 'verificationFailed'.tr();

  static String changeLang() => 'changeLang'.tr();

  static String englishLanguage() => 'english'.tr();

  static String arabicLanguage() => 'arabic'.tr();

  static String noImageSelected() => 'noImageSelected'.tr();

  static String uploadImage() => 'uploadImage'.tr();


  static String clear() => 'clear'.tr();

  static String emptyShareContracts() => 'emptyShareContracts'.tr();

  static String toShareClickHere() => 'toShareClickHere'.tr();

  static String pleaseShareContracts() => 'pleaseShareContracts'.tr();

  static String uploadContracts() => 'uploadContracts'.tr();

  static String uploadContractsSuccessfully() =>
      'uploadContractsSuccessfully'.tr();

  static String save() => 'save'.tr();

  static String errorIn() => 'errorIn'.tr();

  static String updateContactsFromPhone() => 'updateContactsFromPhone'.tr();

  static String noContactsToUpdate() => 'noContactsToUpdate'.tr();

  static String resetFilter() => 'resetFilter'.tr();

  static String allContact() => 'allContacts'.tr();

  static String edit() => 'edit'.tr();

  static String deleteAll() => 'deleteAll'.tr();

  static String deleteWarninigMassage() => 'pleaseSelectContactsToDelete'.tr();

  static String sendNotification() => 'sendNotification'.tr();

  static String updateContacts() => 'updateContacts'.tr();

  static String helpYourFriends() => 'helpYourFriends'.tr();

  static String messageIsEmpty() => 'messageIsEmpty'.tr();

  static String reviewUnavailable() => 'reviewUnavailable'.tr();

  static String noReviews() => 'noReviews'.tr();

  static String writeReview() => 'writeReview'.tr();

  static String noReviewMassage() => 'noReviewMassage'.tr();



  static String loginToYourAccount() => 'loginToYourAccount'.tr();

  static String enterYourDataToCompleteAuthentication() =>
      'enterYourDataToCompleteAuthentication'.tr();

  static String forgetPassword() => 'forgetPassword'.tr();

  static String dontHaveAnAccount() => 'dontHaveAnAccount'.tr();

  

  static String pleaseEnterEmail() => 'pleaseEnterEmail'.tr();

  static String pleaseEnterValidEmail() => 'pleaseEnterValidEmail'.tr();

  static String invalidIdNumber() => 'invalidIdNumber'.tr();

  static String pleaseSelectGender() => 'pleaseSelectGender'.tr();

  static String editProfile() => 'editProfile'.tr();

  static String IDNumber() => "idNumber".tr();

  static String accountNumber() => "accountNumber".tr();

  static String confirmPassword() => 'confirmPassword'.tr();

  static String notifications() => 'notifications'.tr();

  static String support() => 'support'.tr();

  static String pleaseInsertYourEmailToRestoreYourPassword() =>
      'pleaseInsertYourEmailToRestoreYourPassword'.tr();

  static String insertOtpThatSentToYourEmail() =>
      'insertOtpThatSentToYourEmail'.tr();

  static String otpCode() => 'otpCode'.tr();

  static String registerNow() => 'registerNow'.tr();

  static String loginAsGuest() => 'loginAsGuest'.tr();

  static String contacts() => 'contacts'.tr();

  static String profile() => 'profile'.tr();

  static String myLocation() => 'myLocation'.tr();

  static String servicesPerHour() => 'servicesPerHour'.tr();

  static String period() => 'period'.tr();

  static String morning() => 'morning'.tr();

  static String afternoon() => 'afternoon'.tr();

  static String allDay() => 'allDay'.tr();

  static String nationality() => 'nationality'.tr();

  static String selectVisitDays() => 'selectVisitDays'.tr();

  static String selectDateForFirstVisit() => 'selectDateForFirstVisit'.tr();

  static String selectContractDuration() => 'selectContractDuration'.tr();

  static String numbersOfWorkersForEveryVisit() =>
      'numbersOfWorkersForEveryVisit'.tr();

  static String numbersOfVisitDays() => 'numbersOfVisitDays'.tr();

  static String saturday() => 'saturday'.tr();

  static String sunday() => 'sunday'.tr();

  static String monday() => 'monday'.tr();

  static String tuesday() => 'tuesday'.tr();

  static String wednesday() => 'wednesday'.tr();

  static String thursday() => 'thursday'.tr();

  static String friday() => 'friday'.tr();

  static String choseYourAddress() => 'choseYourAddress'.tr();

  static String addNewAddress() => 'addNewAddress'.tr();

  static String companyName() => 'companyName'.tr();

  static String cost() => 'cost'.tr();

  static String discount() => 'discount'.tr();

  static String tax() => 'tax'.tr();



  static String startDate() => 'startDate'.tr();

  static String address() => 'address'.tr();

  static String chosenDays() => 'chosenDays'.tr();

  static String serviceDetails() => 'serviceDetails'.tr();

  static String paymentDetails() => 'paymentDetails'.tr();

  static String contractDuration() => 'contractDuration'.tr();

  static String numberOfWorkers() => 'numberOfWorkers'.tr();

  static String howManyPerWeek() => 'howManyPerWeek'.tr();

  static String numberOfDailyWorkHours() => 'numberOfDailyWorkHours'.tr();

  static String forwardToPay() => 'forwardToPay'.tr();

  static String doYouWantToSelectThisLocation() =>
      'doYouWantToSelectThisLocation'.tr();

  static String tapOnALocationToGetTheAddress() =>
      'tapOnALocationToGetTheAddress'.tr();

  static String registerNew() => 'registerNew'.tr();

  static String alreadyHaveAnAccount() => 'alreadyHaveAccount'.tr();

  static String verifySentCode() => 'verifySentCode'.tr();

  static String enterSentCode() => 'enterSentCode'.tr();

  static String enterSentCodeToVerify() => 'enterSentCodeToVerify'.tr();

  static String price() => 'price'.tr();

  static String areYouSureAboutReserving() => 'areYouSureAboutReserving'.tr();

  static String bookNow() => 'bookNow'.tr();

  static String reservationSuccess() => 'reservationSuccess'.tr();

  static String signUpInOurApp() => 'signUpInOurApp'.tr();

  static String enterUsernameAndPhoneNumberToRegister() =>
      'enterUsernameAndPhoneNumberToRegister'.tr();

  static String invalidName() => 'invalidName'.tr();

  static String pleaseCheckInternetConnection() =>
      'pleaseCheckInternetConnection'.tr();

  static String noTitle() => 'noTitle'.tr();

  static String noAds() => 'noAds'.tr();



  static String pleaseSelectDate() => 'pleaseSelectDate'.tr();

  static String pleaseSelectVisitDate() => 'pleaseSelectVisitDate'.tr();

  static String pleaseSelectNationality() => 'pleaseSelectNationality'.tr();

  static String pleaseSelectThePeriod() => 'pleaseSelectThePeriod'.tr();

  static String pleaseSelectAddress() => 'pleaseSelectAddress'.tr();

  static String noVisits() => 'noVisits'.tr();

  static String paymentMethod() => 'paymentMethod'.tr();

  static String cardNumber() => 'cardNumber'.tr();

  static String cardHolderName() => 'cardHolderName'.tr();

  static String cvv() => 'cvv'.tr();

  static String expiryDate() => 'expiryDate'.tr();

  static String enterCardNumber() => 'enterCardNumber'.tr();

  static String invalidCardNumber() => 'invalidCardNumber'.tr();

  static String enterCardHolderName() => 'enterCardHolderName'.tr();

  static String enterCVV() => 'enterCVV'.tr();

  static String invalidCVV() => 'invalidCVV'.tr();

  static String enterExpiryDate() => 'enterExpiryDate'.tr();

  static String invalidExpiryDate() => 'invalidExpiryDate'.tr();

  static String invalidDateFormat() => 'invalidDateFormat'.tr();

  static String payAmount() => 'payAmount'.tr();

  static String noContracts() => 'noContracts'.tr();

  static String noAccountPleaseCreateOne() => 'noAccountPleaseCreateOne'.tr();

  static String doYouWantToCreateAccount() => 'doYouWantToCreateAccount'.tr();

  static String yesIWant() => 'yesIWant'.tr();

  static String unknownNow() => 'unknownNow'.tr();

  static String enableLocationToRegister() => 'enableLocationToRegister'.tr();

  static String unableToLocateYourPosition() =>
      'unableToLocateYourPosition'.tr();

  // ------------------ mutigina's localization ---------------------
  static String onBoardingTitle1() => 'onBoardingTitle1'.tr();

  static String onBoardingDescription1() => 'onBoardingDescription1'.tr();

  static String onBoardingTitle2() => 'onBoardingTitle2'.tr();

  static String currencySAR() => 'currencySAR'.tr();

  static String confirmed() => 'confirmed'.tr();

  static String notConfirmed() => 'notConfirmed'.tr();

  static String mediationServices() => 'mediationServices'.tr();

  static String offers() => 'offers'.tr();

  static String dearCustomer() => 'dearCustomer'.tr();

  static String welcomeToCompany() => 'welcomeToCompany'.tr();

  static String cleaning() => 'cleaning'.tr();

  static String chooseContractDays() => 'chooseContractDays'.tr();

  static String day() => 'day'.tr();

  static String month() => 'month'.tr();

  static String chooseContractMonths() => 'chooseContractMonths'.tr();

  static String abha() => 'abha'.tr();

  static String alAhsa() => 'alAhsa'.tr();

  static String alBaha() => 'alBaha'.tr();

  static String alKharj() => 'alKharj'.tr();

  static String arRass() => 'arRass'.tr();

  static String riyadh() => 'riyadh'.tr();

  static String noWorkers() => 'noWorkers'.tr();

  static String alQassim() => 'alQassim'.tr();

  static String medina() => 'medina'.tr();

  static String chooseCity() => 'chooseCity'.tr();

  static String searchCity() => 'searchCity'.tr();

  static String pleaseSelectCity() => 'pleaseSelectCity'.tr();

  static String packagePrice() => 'packagePrice'.tr();

  static String taxValue() => 'taxValue'.tr();

  static String totalPackagePrice() => 'totalPackagePrice'.tr();

  static String selectContractMonths() => 'selectContractMonths'.tr();

  static String pleaseSelectPrice() => 'pleaseSelectPrice'.tr();


  static String age() => 'age'.tr();

  static String experience() => 'experience'.tr();

  static String salary() => 'salary'.tr();

  static String recruitmentFees() => 'recruitmentFees'.tr();

  static String religion() => 'religion'.tr();

  static String job() => 'job'.tr();



  static String skills() => 'skills'.tr();

  static String failedTitle() => 'failedTitle'.tr();

  static String failedMessage() => 'failedMessage'.tr();

  static String successTitle() => 'successTitle'.tr();

  static String successMessage() => 'successMessage'.tr();

  static String showContract() => 'showContract'.tr();

  static String mutiginaCompany() => 'mutiginaCompany'.tr();

  static String service() => 'service'.tr();

  static String serviceType() => 'serviceType'.tr();

  static String stayForMonth() => 'stayForMonth'.tr();

  static String packageDetails() => 'packageDetails'.tr();

  static String noServices() => 'noServices'.tr();

  static String startDateContract() => 'startDateContract'.tr();

  static String contractStatus() => 'contractStatus'.tr();

  static String startContractDate() => 'startContractDate'.tr();

  static String numberOfVisits() => 'numberOfVisits'.tr();

  static String countOfRemainingVisits() => 'countOfRemainingVisits'.tr();

  static String visit() => 'visit'.tr();

  static String visitDate() => 'visitDate'.tr();
  static String currentContracts() => 'currentContracts'.tr();
  static String viewAll() => 'viewAll'.tr();
  static String services() => 'services'.tr();
  static String myCurrentOrders() => 'myCurrentOrders'.tr();
  static String serviceSystem() => 'serviceSystem'.tr();
  static String cleaningServices() => 'cleaningServices'.tr();
  static String babysitter() => 'babysitter'.tr();
  static String cooking() => 'cooking'.tr();
  static String privateDriver() => 'privateDriver'.tr();
  static String personalCare() => 'personalCare'.tr();
  static String hostingService() => 'hostingService'.tr();
  static String perHour() => 'perHour'.tr();
  static String perDay() => 'perDay'.tr();
  static String perMonth() => 'perMonth'.tr();
  static String remainingDuration() => 'remainingDuration'.tr();
  static String activeContracts() => 'activeContracts'.tr();
  static String previousContracts() => 'previousContracts'.tr();
  static String renewContract() => 'renewContract'.tr();
  static String currentOrders() => 'currentOrders'.tr();
  static String previousOrders() => 'previousOrders'.tr();
  static String myOrders() => 'myOrders'.tr();
  static String viewDetails() => 'viewDetails'.tr();
  static String savedAddresses() => 'savedAddresses'.tr();
  static String deliveryAddresses() => 'deliveryAddresses'.tr();

  static String monthlyTimeframe() => 'monthly_timeframe'.tr();


  
  
}
