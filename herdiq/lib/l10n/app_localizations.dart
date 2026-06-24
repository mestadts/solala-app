import 'dart:async';

import 'package:flutter/foundation.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:intl/intl.dart' as intl;

import 'app_localizations_ar.dart';
import 'app_localizations_en.dart';

// ignore_for_file: type=lint

/// Callers can lookup localized strings with an instance of AppL
/// returned by `AppL.of(context)`.
///
/// Applications need to include `AppL.delegate()` in their app's
/// `localizationDelegates` list, and the locales they support in the app's
/// `supportedLocales` list. For example:
///
/// ```dart
/// import 'l10n/app_localizations.dart';
///
/// return MaterialApp(
///   localizationsDelegates: AppL.localizationsDelegates,
///   supportedLocales: AppL.supportedLocales,
///   home: MyApplicationHome(),
/// );
/// ```
///
/// ## Update pubspec.yaml
///
/// Please make sure to update your pubspec.yaml to include the following
/// packages:
///
/// ```yaml
/// dependencies:
///   # Internationalization support.
///   flutter_localizations:
///     sdk: flutter
///   intl: any # Use the pinned version from flutter_localizations
///
///   # Rest of dependencies
/// ```
///
/// ## iOS Applications
///
/// iOS applications define key application metadata, including supported
/// locales, in an Info.plist file that is built into the application bundle.
/// To configure the locales supported by your app, you’ll need to edit this
/// file.
///
/// First, open your project’s ios/Runner.xcworkspace Xcode workspace file.
/// Then, in the Project Navigator, open the Info.plist file under the Runner
/// project’s Runner folder.
///
/// Next, select the Information Property List item, select Add Item from the
/// Editor menu, then select Localizations from the pop-up menu.
///
/// Select and expand the newly-created Localizations item then, for each
/// locale your application supports, add a new item and select the locale
/// you wish to add from the pop-up menu in the Value field. This list should
/// be consistent with the languages listed in the AppL.supportedLocales
/// property.
abstract class AppL {
  AppL(String locale)
    : localeName = intl.Intl.canonicalizedLocale(locale.toString());

  final String localeName;

  static AppL of(BuildContext context) {
    return Localizations.of<AppL>(context, AppL)!;
  }

  static const LocalizationsDelegate<AppL> delegate = _AppLDelegate();

  /// A list of this localizations delegate along with the default localizations
  /// delegates.
  ///
  /// Returns a list of localizations delegates containing this delegate along with
  /// GlobalMaterialLocalizations.delegate, GlobalCupertinoLocalizations.delegate,
  /// and GlobalWidgetsLocalizations.delegate.
  ///
  /// Additional delegates can be added by appending to this list in
  /// MaterialApp. This list does not have to be used at all if a custom list
  /// of delegates is preferred or required.
  static const List<LocalizationsDelegate<dynamic>> localizationsDelegates =
      <LocalizationsDelegate<dynamic>>[
        delegate,
        GlobalMaterialLocalizations.delegate,
        GlobalCupertinoLocalizations.delegate,
        GlobalWidgetsLocalizations.delegate,
      ];

  /// A list of this localizations delegate's supported locales.
  static const List<Locale> supportedLocales = <Locale>[
    Locale('ar'),
    Locale('en'),
  ];

  /// No description provided for @appTitle.
  ///
  /// In ar, this message translates to:
  /// **'سلالة'**
  String get appTitle;

  /// No description provided for @appTagline.
  ///
  /// In ar, this message translates to:
  /// **'ثروتك الحيوانية، تُدار بذكاء'**
  String get appTagline;

  /// No description provided for @btnContinue.
  ///
  /// In ar, this message translates to:
  /// **'متابعة'**
  String get btnContinue;

  /// No description provided for @btnSave.
  ///
  /// In ar, this message translates to:
  /// **'حفظ'**
  String get btnSave;

  /// No description provided for @btnCancel.
  ///
  /// In ar, this message translates to:
  /// **'إلغاء'**
  String get btnCancel;

  /// No description provided for @btnDelete.
  ///
  /// In ar, this message translates to:
  /// **'حذف'**
  String get btnDelete;

  /// No description provided for @btnSkip.
  ///
  /// In ar, this message translates to:
  /// **'تخطي'**
  String get btnSkip;

  /// No description provided for @btnNext.
  ///
  /// In ar, this message translates to:
  /// **'التالي'**
  String get btnNext;

  /// No description provided for @btnBack.
  ///
  /// In ar, this message translates to:
  /// **'رجوع'**
  String get btnBack;

  /// No description provided for @btnClose.
  ///
  /// In ar, this message translates to:
  /// **'إغلاق'**
  String get btnClose;

  /// No description provided for @btnCopyId.
  ///
  /// In ar, this message translates to:
  /// **'نسخ الرقم'**
  String get btnCopyId;

  /// No description provided for @navHome.
  ///
  /// In ar, this message translates to:
  /// **'الرئيسية'**
  String get navHome;

  /// No description provided for @navAnimals.
  ///
  /// In ar, this message translates to:
  /// **'الحيوانات'**
  String get navAnimals;

  /// No description provided for @navHealth.
  ///
  /// In ar, this message translates to:
  /// **'الصحة'**
  String get navHealth;

  /// No description provided for @navSettings.
  ///
  /// In ar, this message translates to:
  /// **'الإعدادات'**
  String get navSettings;

  /// No description provided for @loginTitle.
  ///
  /// In ar, this message translates to:
  /// **'مرحبًا بعودتك'**
  String get loginTitle;

  /// No description provided for @loginSubtitle.
  ///
  /// In ar, this message translates to:
  /// **'تسجيل الدخول إلى حساب سلالة'**
  String get loginSubtitle;

  /// No description provided for @loginPhone.
  ///
  /// In ar, this message translates to:
  /// **'رقم الهاتف'**
  String get loginPhone;

  /// No description provided for @loginPhoneHint.
  ///
  /// In ar, this message translates to:
  /// **'5XX XXX XXX (بدون صفر)'**
  String get loginPhoneHint;

  /// No description provided for @loginPhoneValidation.
  ///
  /// In ar, this message translates to:
  /// **'يرجى إدخال رقم الهاتف'**
  String get loginPhoneValidation;

  /// No description provided for @loginPassword.
  ///
  /// In ar, this message translates to:
  /// **'كلمة المرور'**
  String get loginPassword;

  /// No description provided for @loginPasswordHint.
  ///
  /// In ar, this message translates to:
  /// **'أدخل كلمة المرور'**
  String get loginPasswordHint;

  /// No description provided for @loginPasswordValidation.
  ///
  /// In ar, this message translates to:
  /// **'يرجى إدخال كلمة المرور'**
  String get loginPasswordValidation;

  /// No description provided for @loginForgotPassword.
  ///
  /// In ar, this message translates to:
  /// **'نسيت كلمة المرور؟'**
  String get loginForgotPassword;

  /// No description provided for @loginBtn.
  ///
  /// In ar, this message translates to:
  /// **'تسجيل الدخول'**
  String get loginBtn;

  /// No description provided for @loginOrWith.
  ///
  /// In ar, this message translates to:
  /// **'أو تابع باستخدام'**
  String get loginOrWith;

  /// No description provided for @loginNoAccount.
  ///
  /// In ar, this message translates to:
  /// **'ليس لديك حساب؟ '**
  String get loginNoAccount;

  /// No description provided for @loginRegisterLink.
  ///
  /// In ar, this message translates to:
  /// **'إنشاء حساب'**
  String get loginRegisterLink;

  /// No description provided for @selectCountry.
  ///
  /// In ar, this message translates to:
  /// **'اختر الدولة'**
  String get selectCountry;

  /// No description provided for @countrySearchHint.
  ///
  /// In ar, this message translates to:
  /// **'ابحث عن الدولة'**
  String get countrySearchHint;

  /// No description provided for @otpTitle.
  ///
  /// In ar, this message translates to:
  /// **'التحقق من الرقم'**
  String get otpTitle;

  /// No description provided for @otpSubtitle.
  ///
  /// In ar, this message translates to:
  /// **'أدخل الرمز المكوّن من 6 أرقام المُرسَل إلى '**
  String get otpSubtitle;

  /// No description provided for @otpYourNumber.
  ///
  /// In ar, this message translates to:
  /// **'رقمك'**
  String get otpYourNumber;

  /// No description provided for @otpResendIn.
  ///
  /// In ar, this message translates to:
  /// **'إعادة الإرسال بعد {seconds} ثانية'**
  String otpResendIn(int seconds);

  /// No description provided for @otpResend.
  ///
  /// In ar, this message translates to:
  /// **'إعادة إرسال الرمز'**
  String get otpResend;

  /// No description provided for @otpVerifyBtn.
  ///
  /// In ar, this message translates to:
  /// **'تحقق وتابع'**
  String get otpVerifyBtn;

  /// No description provided for @forgotTitle.
  ///
  /// In ar, this message translates to:
  /// **'نسيت كلمة المرور؟'**
  String get forgotTitle;

  /// No description provided for @forgotSubtitle.
  ///
  /// In ar, this message translates to:
  /// **'أدخل رقم جوالك وسنرسل لك رمز التحقق لإعادة تعيين كلمة المرور.'**
  String get forgotSubtitle;

  /// No description provided for @forgotSendBtn.
  ///
  /// In ar, this message translates to:
  /// **'إرسال رمز التحقق'**
  String get forgotSendBtn;

  /// No description provided for @forgotRemember.
  ///
  /// In ar, this message translates to:
  /// **'تتذكر كلمة المرور؟ '**
  String get forgotRemember;

  /// No description provided for @forgotSignInLink.
  ///
  /// In ar, this message translates to:
  /// **'تسجيل الدخول'**
  String get forgotSignInLink;

  /// No description provided for @resetTitle.
  ///
  /// In ar, this message translates to:
  /// **'إعادة تعيين كلمة المرور'**
  String get resetTitle;

  /// No description provided for @resetSubtitle.
  ///
  /// In ar, this message translates to:
  /// **'أدخل كلمة مرور جديدة لحسابك.'**
  String get resetSubtitle;

  /// No description provided for @resetNewPassword.
  ///
  /// In ar, this message translates to:
  /// **'كلمة المرور الجديدة'**
  String get resetNewPassword;

  /// No description provided for @resetNewPasswordHint.
  ///
  /// In ar, this message translates to:
  /// **'8 أحرف على الأقل'**
  String get resetNewPasswordHint;

  /// No description provided for @resetPasswordMinLength.
  ///
  /// In ar, this message translates to:
  /// **'يجب أن تتكون كلمة المرور من 8 أحرف على الأقل'**
  String get resetPasswordMinLength;

  /// No description provided for @resetConfirmPassword.
  ///
  /// In ar, this message translates to:
  /// **'تأكيد كلمة المرور الجديدة'**
  String get resetConfirmPassword;

  /// No description provided for @resetConfirmHint.
  ///
  /// In ar, this message translates to:
  /// **'أعد إدخال كلمة المرور الجديدة'**
  String get resetConfirmHint;

  /// No description provided for @resetPasswordMismatch.
  ///
  /// In ar, this message translates to:
  /// **'كلمتا المرور غير متطابقتين'**
  String get resetPasswordMismatch;

  /// No description provided for @resetBtn.
  ///
  /// In ar, this message translates to:
  /// **'إعادة التعيين'**
  String get resetBtn;

  /// No description provided for @resetSuccess.
  ///
  /// In ar, this message translates to:
  /// **'تمت إعادة تعيين كلمة المرور. يرجى تسجيل الدخول.'**
  String get resetSuccess;

  /// No description provided for @registerStep0Title.
  ///
  /// In ar, this message translates to:
  /// **'إنشاء حساب'**
  String get registerStep0Title;

  /// No description provided for @registerStep0Subtitle.
  ///
  /// In ar, this message translates to:
  /// **'انضم إلى سلالة لإدارة ثروتك الحيوانية'**
  String get registerStep0Subtitle;

  /// No description provided for @registerSendOtp.
  ///
  /// In ar, this message translates to:
  /// **'إرسال الرمز'**
  String get registerSendOtp;

  /// No description provided for @registerHaveAccount.
  ///
  /// In ar, this message translates to:
  /// **'لديك حساب بالفعل؟ '**
  String get registerHaveAccount;

  /// No description provided for @registerSignInLink.
  ///
  /// In ar, this message translates to:
  /// **'تسجيل الدخول'**
  String get registerSignInLink;

  /// No description provided for @registerStep2Title.
  ///
  /// In ar, this message translates to:
  /// **'أكمل ملفك الشخصي'**
  String get registerStep2Title;

  /// No description provided for @registerStep2Subtitle.
  ///
  /// In ar, this message translates to:
  /// **'أوشكت على الانتهاء! أدخل اسمك وكلمة المرور.'**
  String get registerStep2Subtitle;

  /// No description provided for @registerFullName.
  ///
  /// In ar, this message translates to:
  /// **'الاسم الكامل'**
  String get registerFullName;

  /// No description provided for @registerFullNameHint.
  ///
  /// In ar, this message translates to:
  /// **'أحمد الراشدي'**
  String get registerFullNameHint;

  /// No description provided for @registerFullNameValidation.
  ///
  /// In ar, this message translates to:
  /// **'يرجى إدخال اسمك الكامل'**
  String get registerFullNameValidation;

  /// No description provided for @registerPasswordHint.
  ///
  /// In ar, this message translates to:
  /// **'8 أحرف على الأقل'**
  String get registerPasswordHint;

  /// No description provided for @registerConfirmPassword.
  ///
  /// In ar, this message translates to:
  /// **'تأكيد كلمة المرور'**
  String get registerConfirmPassword;

  /// No description provided for @registerConfirmHint.
  ///
  /// In ar, this message translates to:
  /// **'أعد إدخال كلمة المرور'**
  String get registerConfirmHint;

  /// No description provided for @registerCreateBtn.
  ///
  /// In ar, this message translates to:
  /// **'إنشاء الحساب'**
  String get registerCreateBtn;

  /// No description provided for @onboardingSlide1Title.
  ///
  /// In ar, this message translates to:
  /// **'تتبّع كل حيوان'**
  String get onboardingSlide1Title;

  /// No description provided for @onboardingSlide1Desc.
  ///
  /// In ar, this message translates to:
  /// **'أدر قطيعك بالكامل في مكان واحد. خصّص رقمًا فريدًا لكل حيوان ولا تفقد أثره أبدًا.'**
  String get onboardingSlide1Desc;

  /// No description provided for @onboardingSlide2Title.
  ///
  /// In ar, this message translates to:
  /// **'متابعة صحة قطيعك'**
  String get onboardingSlide2Title;

  /// No description provided for @onboardingSlide2Desc.
  ///
  /// In ar, this message translates to:
  /// **'سجّل التطعيمات والعلاجات والأوزان. احصل على تذكيرات قبل موعد التطعيمات.'**
  String get onboardingSlide2Desc;

  /// No description provided for @onboardingSlide3Title.
  ///
  /// In ar, this message translates to:
  /// **'مسح وتعريف فوري'**
  String get onboardingSlide3Title;

  /// No description provided for @onboardingSlide3Desc.
  ///
  /// In ar, this message translates to:
  /// **'كل حيوان يحصل على رمز QR. امسحه في الحقل لعرض الملف الكامل فورًا.'**
  String get onboardingSlide3Desc;

  /// No description provided for @onboardingSlide4Title.
  ///
  /// In ar, this message translates to:
  /// **'سجلات ملكية آمنة'**
  String get onboardingSlide4Title;

  /// No description provided for @onboardingSlide4Desc.
  ///
  /// In ar, this message translates to:
  /// **'انقل الملكية مع سجل كامل غير قابل للتغيير. كل معاملة دائمة ومحمية.'**
  String get onboardingSlide4Desc;

  /// No description provided for @onboardingGetStarted.
  ///
  /// In ar, this message translates to:
  /// **'ابدأ الآن'**
  String get onboardingGetStarted;

  /// No description provided for @countryTitle.
  ///
  /// In ar, this message translates to:
  /// **'اختر الدولة'**
  String get countryTitle;

  /// No description provided for @countrySubtitle.
  ///
  /// In ar, this message translates to:
  /// **'أين تقع مزرعتك؟'**
  String get countrySubtitle;

  /// No description provided for @countrySearch.
  ///
  /// In ar, this message translates to:
  /// **'ابحث عن الدولة…'**
  String get countrySearch;

  /// No description provided for @orgTypeTitle.
  ///
  /// In ar, this message translates to:
  /// **'نوع المنشأة'**
  String get orgTypeTitle;

  /// No description provided for @orgTypeSubtitle.
  ///
  /// In ar, this message translates to:
  /// **'اختر النوع الذي يصف إدارتك للثروة الحيوانية.'**
  String get orgTypeSubtitle;

  /// No description provided for @orgTypeIndividual.
  ///
  /// In ar, this message translates to:
  /// **'فردي / شخصي'**
  String get orgTypeIndividual;

  /// No description provided for @orgTypeIndividualDesc.
  ///
  /// In ar, this message translates to:
  /// **'تُدير حيواناتك الخاصة. مثالي للمربّين وأصحاب القطعان الصغيرة.'**
  String get orgTypeIndividualDesc;

  /// No description provided for @orgTypeSmallFarm.
  ///
  /// In ar, this message translates to:
  /// **'مزرعة صغيرة'**
  String get orgTypeSmallFarm;

  /// No description provided for @orgTypeSmallFarmDesc.
  ///
  /// In ar, this message translates to:
  /// **'مزرعة عائلية أو صغيرة بأنواع متعددة من الحيوانات.'**
  String get orgTypeSmallFarmDesc;

  /// No description provided for @orgTypeCommercial.
  ///
  /// In ar, this message translates to:
  /// **'مزرعة تجارية'**
  String get orgTypeCommercial;

  /// No description provided for @orgTypeCommercialDesc.
  ///
  /// In ar, this message translates to:
  /// **'عملية واسعة النطاق مع عمال وتقارير متقدمة وتحويلات جماعية.'**
  String get orgTypeCommercialDesc;

  /// No description provided for @orgTypeGovt.
  ///
  /// In ar, this message translates to:
  /// **'حكومي / رقابي'**
  String get orgTypeGovt;

  /// No description provided for @orgTypeGovtDesc.
  ///
  /// In ar, this message translates to:
  /// **'جهة رسمية تشرف على تسجيل الثروة الحيوانية والامتثال.'**
  String get orgTypeGovtDesc;

  /// No description provided for @orgSetupTitle.
  ///
  /// In ar, this message translates to:
  /// **'إعداد مزرعتك'**
  String get orgSetupTitle;

  /// No description provided for @orgSetupSubtitle.
  ///
  /// In ar, this message translates to:
  /// **'أخبرنا عن منشأتك لتخصيص سلالة لك.'**
  String get orgSetupSubtitle;

  /// No description provided for @orgSetupName.
  ///
  /// In ar, this message translates to:
  /// **'اسم المزرعة / المنشأة'**
  String get orgSetupName;

  /// No description provided for @orgSetupNameHint.
  ///
  /// In ar, this message translates to:
  /// **'مثال: مزرعة الراشدي'**
  String get orgSetupNameHint;

  /// No description provided for @orgSetupNameValidation.
  ///
  /// In ar, this message translates to:
  /// **'يرجى إدخال اسم المزرعة'**
  String get orgSetupNameValidation;

  /// No description provided for @orgSetupLocation.
  ///
  /// In ar, this message translates to:
  /// **'الموقع / المدينة'**
  String get orgSetupLocation;

  /// No description provided for @orgSetupLocationHint.
  ///
  /// In ar, this message translates to:
  /// **'مثال: الرياض'**
  String get orgSetupLocationHint;

  /// No description provided for @orgSetupLocationValidation.
  ///
  /// In ar, this message translates to:
  /// **'يرجى إدخال موقع مزرعتك'**
  String get orgSetupLocationValidation;

  /// No description provided for @orgSetupHerdSize.
  ///
  /// In ar, this message translates to:
  /// **'الحجم التقريبي للقطيع (اختياري)'**
  String get orgSetupHerdSize;

  /// No description provided for @orgSetupHerdSizeHint.
  ///
  /// In ar, this message translates to:
  /// **'مثال: 50'**
  String get orgSetupHerdSizeHint;

  /// No description provided for @orgSetupFinish.
  ///
  /// In ar, this message translates to:
  /// **'إنهاء الإعداد'**
  String get orgSetupFinish;

  /// No description provided for @orgSetupLegal.
  ///
  /// In ar, this message translates to:
  /// **'بالمتابعة، فأنت توافق على شروط الخدمة وسياسة الخصوصية.'**
  String get orgSetupLegal;

  /// No description provided for @dashboardGreeting.
  ///
  /// In ar, this message translates to:
  /// **'صباح الخير،'**
  String get dashboardGreeting;

  /// No description provided for @dashboardDefaultFarmName.
  ///
  /// In ar, this message translates to:
  /// **'مزرعتي'**
  String get dashboardDefaultFarmName;

  /// No description provided for @dashboardUpcomingEvents.
  ///
  /// In ar, this message translates to:
  /// **'الأحداث القادمة'**
  String get dashboardUpcomingEvents;

  /// No description provided for @dashboardRecentActivity.
  ///
  /// In ar, this message translates to:
  /// **'النشاط الأخير'**
  String get dashboardRecentActivity;

  /// No description provided for @dashboardNoUpcoming.
  ///
  /// In ar, this message translates to:
  /// **'لا توجد أحداث قادمة'**
  String get dashboardNoUpcoming;

  /// No description provided for @dashboardNoActivity.
  ///
  /// In ar, this message translates to:
  /// **'لا يوجد نشاط حديث'**
  String get dashboardNoActivity;

  /// No description provided for @dashboardOverdue.
  ///
  /// In ar, this message translates to:
  /// **'متأخر'**
  String get dashboardOverdue;

  /// No description provided for @dashboardDue.
  ///
  /// In ar, this message translates to:
  /// **'مستحق'**
  String get dashboardDue;

  /// No description provided for @dashboardTotalAnimals.
  ///
  /// In ar, this message translates to:
  /// **'إجمالي الحيوانات'**
  String get dashboardTotalAnimals;

  /// No description provided for @dashboardAddAnimal.
  ///
  /// In ar, this message translates to:
  /// **'إضافة حيوان'**
  String get dashboardAddAnimal;

  /// No description provided for @dashboardHerdOverview.
  ///
  /// In ar, this message translates to:
  /// **'نظرة عامة على القطيع'**
  String get dashboardHerdOverview;

  /// No description provided for @dashboardCategories.
  ///
  /// In ar, this message translates to:
  /// **'التصنيفات'**
  String get dashboardCategories;

  /// No description provided for @dashboardSpeciesBreakdown.
  ///
  /// In ar, this message translates to:
  /// **'إحصائيات القطيع'**
  String get dashboardSpeciesBreakdown;

  /// No description provided for @dashboardSeeAll.
  ///
  /// In ar, this message translates to:
  /// **'عرض الكل'**
  String get dashboardSeeAll;

  /// No description provided for @dashboardEventsThisWeek.
  ///
  /// In ar, this message translates to:
  /// **'أحداث هذا الأسبوع'**
  String get dashboardEventsThisWeek;

  /// No description provided for @animalsTitle.
  ///
  /// In ar, this message translates to:
  /// **'الحيوانات'**
  String get animalsTitle;

  /// No description provided for @animalsTotal.
  ///
  /// In ar, this message translates to:
  /// **'{count} إجمالي'**
  String animalsTotal(int count);

  /// No description provided for @animalsAdd.
  ///
  /// In ar, this message translates to:
  /// **'إضافة'**
  String get animalsAdd;

  /// No description provided for @animalsSearch.
  ///
  /// In ar, this message translates to:
  /// **'ابحث بالاسم أو الرقم أو الوسم…'**
  String get animalsSearch;

  /// No description provided for @animalsFilterAll.
  ///
  /// In ar, this message translates to:
  /// **'الكل'**
  String get animalsFilterAll;

  /// No description provided for @animalsEmpty.
  ///
  /// In ar, this message translates to:
  /// **'لا توجد حيوانات بعد'**
  String get animalsEmpty;

  /// No description provided for @animalsEmptyHint.
  ///
  /// In ar, this message translates to:
  /// **'اضغط + إضافة لتسجيل أول حيوان'**
  String get animalsEmptyHint;

  /// No description provided for @animalsNoMatch.
  ///
  /// In ar, this message translates to:
  /// **'لا توجد حيوانات تطابق البحث'**
  String get animalsNoMatch;

  /// No description provided for @animalsNoMatchHint.
  ///
  /// In ar, this message translates to:
  /// **'جرّب اسمًا أو فلترًا آخر'**
  String get animalsNoMatchHint;

  /// No description provided for @addAnimalStep0Title.
  ///
  /// In ar, this message translates to:
  /// **'اختر النوع'**
  String get addAnimalStep0Title;

  /// No description provided for @addAnimalStep0Subtitle.
  ///
  /// In ar, this message translates to:
  /// **'ما نوع الحيوان الذي تسجّله؟'**
  String get addAnimalStep0Subtitle;

  /// No description provided for @addAnimalStep1Title.
  ///
  /// In ar, this message translates to:
  /// **'المعلومات الأساسية'**
  String get addAnimalStep1Title;

  /// No description provided for @addAnimalStep1Subtitle.
  ///
  /// In ar, this message translates to:
  /// **'الاسم اختياري — يمكنك استخدام الرقم التعريفي بدلاً منه.'**
  String get addAnimalStep1Subtitle;

  /// No description provided for @addAnimalNameLabel.
  ///
  /// In ar, this message translates to:
  /// **'اسم الحيوان (اختياري)'**
  String get addAnimalNameLabel;

  /// No description provided for @addAnimalNameHint.
  ///
  /// In ar, this message translates to:
  /// **'مثال: ليلى'**
  String get addAnimalNameHint;

  /// No description provided for @addAnimalGenderLabel.
  ///
  /// In ar, this message translates to:
  /// **'الجنس'**
  String get addAnimalGenderLabel;

  /// No description provided for @addAnimalDobLabel.
  ///
  /// In ar, this message translates to:
  /// **'تاريخ الميلاد (اختياري)'**
  String get addAnimalDobLabel;

  /// No description provided for @addAnimalDobHint.
  ///
  /// In ar, this message translates to:
  /// **'YYYY-MM-DD'**
  String get addAnimalDobHint;

  /// No description provided for @addAnimalStep2Title.
  ///
  /// In ar, this message translates to:
  /// **'السلالة'**
  String get addAnimalStep2Title;

  /// No description provided for @addAnimalStep2Subtitle.
  ///
  /// In ar, this message translates to:
  /// **'السلالة حقل إلزامي — اختر من القائمة أو أضف سلالة جديدة.'**
  String get addAnimalStep2Subtitle;

  /// No description provided for @addAnimalBreedLabel.
  ///
  /// In ar, this message translates to:
  /// **'السلالة'**
  String get addAnimalBreedLabel;

  /// No description provided for @addAnimalBreedSkip.
  ///
  /// In ar, this message translates to:
  /// **'تخطي الآن'**
  String get addAnimalBreedSkip;

  /// No description provided for @addAnimalStep3Title.
  ///
  /// In ar, this message translates to:
  /// **'اللون والوسم'**
  String get addAnimalStep3Title;

  /// No description provided for @addAnimalStep3Subtitle.
  ///
  /// In ar, this message translates to:
  /// **'لون موحّد ووسم رقمي للتعريف.'**
  String get addAnimalStep3Subtitle;

  /// No description provided for @addAnimalColorLabel.
  ///
  /// In ar, this message translates to:
  /// **'لون الحيوان'**
  String get addAnimalColorLabel;

  /// No description provided for @addAnimalTagLabel.
  ///
  /// In ar, this message translates to:
  /// **'رقم الوسم (0–500)'**
  String get addAnimalTagLabel;

  /// No description provided for @addAnimalStep4Title.
  ///
  /// In ar, this message translates to:
  /// **'إضافة صورة'**
  String get addAnimalStep4Title;

  /// No description provided for @addAnimalStep4Subtitle.
  ///
  /// In ar, this message translates to:
  /// **'تساعد الصورة على تعريف الحيوان بسرعة.'**
  String get addAnimalStep4Subtitle;

  /// No description provided for @addAnimalPhotoTap.
  ///
  /// In ar, this message translates to:
  /// **'اضغط لإضافة صورة\n(اختياري)'**
  String get addAnimalPhotoTap;

  /// No description provided for @addAnimalChoosePhoto.
  ///
  /// In ar, this message translates to:
  /// **'اختر صورة'**
  String get addAnimalChoosePhoto;

  /// No description provided for @addAnimalSaveBtn.
  ///
  /// In ar, this message translates to:
  /// **'حفظ الحيوان'**
  String get addAnimalSaveBtn;

  /// No description provided for @addAnimalSuccessTitle.
  ///
  /// In ar, this message translates to:
  /// **'تمّ تسجيل الحيوان!'**
  String get addAnimalSuccessTitle;

  /// No description provided for @addAnimalSuccessMsg.
  ///
  /// In ar, this message translates to:
  /// **'تمت إضافة الحيوان إلى القطيع.\nهذا هو رقمه التعريفي الفريد:'**
  String get addAnimalSuccessMsg;

  /// No description provided for @addAnimalSystemIdLabel.
  ///
  /// In ar, this message translates to:
  /// **'الرقم التعريفي'**
  String get addAnimalSystemIdLabel;

  /// No description provided for @addAnimalIdPermanent.
  ///
  /// In ar, this message translates to:
  /// **'هذا الرقم دائم ولا يمكن تغييره'**
  String get addAnimalIdPermanent;

  /// No description provided for @addAnimalBackToList.
  ///
  /// In ar, this message translates to:
  /// **'العودة إلى الحيوانات'**
  String get addAnimalBackToList;

  /// No description provided for @addAnimalPurposeLabel.
  ///
  /// In ar, this message translates to:
  /// **'الغرض'**
  String get addAnimalPurposeLabel;

  /// No description provided for @addAnimalAgeClassLabel.
  ///
  /// In ar, this message translates to:
  /// **'السن'**
  String get addAnimalAgeClassLabel;

  /// No description provided for @addAnimalAgeClassAuto.
  ///
  /// In ar, this message translates to:
  /// **'تلقائي من تاريخ الميلاد'**
  String get addAnimalAgeClassAuto;

  /// No description provided for @addAnimalPenLabel.
  ///
  /// In ar, this message translates to:
  /// **'الحظيرة (اختياري)'**
  String get addAnimalPenLabel;

  /// No description provided for @addAnimalPenNone.
  ///
  /// In ar, this message translates to:
  /// **'بدون حظيرة'**
  String get addAnimalPenNone;

  /// No description provided for @addAnimalWeightLabel.
  ///
  /// In ar, this message translates to:
  /// **'الوزن (كغ، اختياري)'**
  String get addAnimalWeightLabel;

  /// No description provided for @addAnimalWeightHint.
  ///
  /// In ar, this message translates to:
  /// **'مثال: 45.5'**
  String get addAnimalWeightHint;

  /// No description provided for @addAnimalPriceLabel.
  ///
  /// In ar, this message translates to:
  /// **'السعر (ريال، اختياري)'**
  String get addAnimalPriceLabel;

  /// No description provided for @addAnimalPriceHint.
  ///
  /// In ar, this message translates to:
  /// **'مثال: 1200'**
  String get addAnimalPriceHint;

  /// No description provided for @addAnimalPhotoCamera.
  ///
  /// In ar, this message translates to:
  /// **'التقاط صورة'**
  String get addAnimalPhotoCamera;

  /// No description provided for @addAnimalPhotoGallery.
  ///
  /// In ar, this message translates to:
  /// **'اختيار من المعرض'**
  String get addAnimalPhotoGallery;

  /// No description provided for @animalDuplicate.
  ///
  /// In ar, this message translates to:
  /// **'نسخ الحيوان'**
  String get animalDuplicate;

  /// No description provided for @animalDuplicateHint.
  ///
  /// In ar, this message translates to:
  /// **'النسخ يملأ النموذج تلقائيًا — غيّر فقط ما يختلف'**
  String get animalDuplicateHint;

  /// No description provided for @animalActionEdit.
  ///
  /// In ar, this message translates to:
  /// **'تعديل'**
  String get animalActionEdit;

  /// No description provided for @animalActionSell.
  ///
  /// In ar, this message translates to:
  /// **'تسجيل كمباع'**
  String get animalActionSell;

  /// No description provided for @animalActionSlaughter.
  ///
  /// In ar, this message translates to:
  /// **'تسجيل كمذبوح'**
  String get animalActionSlaughter;

  /// No description provided for @animalActionMarkDead.
  ///
  /// In ar, this message translates to:
  /// **'تسجيل كنافق'**
  String get animalActionMarkDead;

  /// No description provided for @animalActionSlaughterConfirm.
  ///
  /// In ar, this message translates to:
  /// **'هل تريد تسجيل ذبح هذا الحيوان؟'**
  String get animalActionSlaughterConfirm;

  /// No description provided for @animalActionDeadConfirm.
  ///
  /// In ar, this message translates to:
  /// **'هل تريد تسجيل نفوق هذا الحيوان؟'**
  String get animalActionDeadConfirm;

  /// No description provided for @btnConfirm.
  ///
  /// In ar, this message translates to:
  /// **'تأكيد'**
  String get btnConfirm;

  /// No description provided for @animalDetailTabHealth.
  ///
  /// In ar, this message translates to:
  /// **'الصحة'**
  String get animalDetailTabHealth;

  /// No description provided for @animalDetailTabWeight.
  ///
  /// In ar, this message translates to:
  /// **'الوزن'**
  String get animalDetailTabWeight;

  /// No description provided for @animalDetailTabOwnership.
  ///
  /// In ar, this message translates to:
  /// **'الملكية'**
  String get animalDetailTabOwnership;

  /// No description provided for @animalDetailTabBreeding.
  ///
  /// In ar, this message translates to:
  /// **'التكاثر'**
  String get animalDetailTabBreeding;

  /// No description provided for @animalDetailNotFound.
  ///
  /// In ar, this message translates to:
  /// **'الحيوان غير موجود'**
  String get animalDetailNotFound;

  /// No description provided for @animalDetailGender.
  ///
  /// In ar, this message translates to:
  /// **'الجنس'**
  String get animalDetailGender;

  /// No description provided for @animalDetailBreed.
  ///
  /// In ar, this message translates to:
  /// **'السلالة'**
  String get animalDetailBreed;

  /// No description provided for @animalDetailDob.
  ///
  /// In ar, this message translates to:
  /// **'تاريخ الميلاد'**
  String get animalDetailDob;

  /// No description provided for @animalDetailWeight.
  ///
  /// In ar, this message translates to:
  /// **'الوزن'**
  String get animalDetailWeight;

  /// No description provided for @animalDetailTag.
  ///
  /// In ar, this message translates to:
  /// **'الوسم: '**
  String get animalDetailTag;

  /// No description provided for @animalDetailCurrentOwner.
  ///
  /// In ar, this message translates to:
  /// **'المالك الحالي'**
  String get animalDetailCurrentOwner;

  /// No description provided for @animalDetailTransferOwnership.
  ///
  /// In ar, this message translates to:
  /// **'نقل الملكية'**
  String get animalDetailTransferOwnership;

  /// No description provided for @animalDetailTransferHistory.
  ///
  /// In ar, this message translates to:
  /// **'سجل الملكية'**
  String get animalDetailTransferHistory;

  /// No description provided for @animalDetailNoTransfers.
  ///
  /// In ar, this message translates to:
  /// **'لا توجد عمليات نقل بعد'**
  String get animalDetailNoTransfers;

  /// No description provided for @animalDetailNoHealth.
  ///
  /// In ar, this message translates to:
  /// **'لا توجد سجلات صحية بعد'**
  String get animalDetailNoHealth;

  /// No description provided for @animalDetailNoWeight.
  ///
  /// In ar, this message translates to:
  /// **'لا توجد سجلات وزن بعد'**
  String get animalDetailNoWeight;

  /// No description provided for @animalDetailOfficial.
  ///
  /// In ar, this message translates to:
  /// **'رسمي'**
  String get animalDetailOfficial;

  /// No description provided for @animalDetailQrTitle.
  ///
  /// In ar, this message translates to:
  /// **'رمز QR'**
  String get animalDetailQrTitle;

  /// No description provided for @animalDetailDeleteTitle.
  ///
  /// In ar, this message translates to:
  /// **'حذف {name}؟'**
  String animalDetailDeleteTitle(String name);

  /// No description provided for @animalDetailDeleteMsg.
  ///
  /// In ar, this message translates to:
  /// **'سيتم إزالة {name} نهائيًا من سجلاتك.'**
  String animalDetailDeleteMsg(String name);

  /// No description provided for @editAnimalTitle.
  ///
  /// In ar, this message translates to:
  /// **'تعديل {name}'**
  String editAnimalTitle(String name);

  /// No description provided for @editAnimalCannotChange.
  ///
  /// In ar, this message translates to:
  /// **'(لا يمكن تغييره)'**
  String get editAnimalCannotChange;

  /// No description provided for @editAnimalNameLabel.
  ///
  /// In ar, this message translates to:
  /// **'اسم الحيوان'**
  String get editAnimalNameLabel;

  /// No description provided for @editAnimalNameHint.
  ///
  /// In ar, this message translates to:
  /// **'مثال: ليلى'**
  String get editAnimalNameHint;

  /// No description provided for @editAnimalNameValidation.
  ///
  /// In ar, this message translates to:
  /// **'الاسم مطلوب'**
  String get editAnimalNameValidation;

  /// No description provided for @editAnimalBreedLabel.
  ///
  /// In ar, this message translates to:
  /// **'السلالة'**
  String get editAnimalBreedLabel;

  /// No description provided for @editAnimalBreedHint.
  ///
  /// In ar, this message translates to:
  /// **'مثال: نجدي'**
  String get editAnimalBreedHint;

  /// No description provided for @editAnimalGenderLabel.
  ///
  /// In ar, this message translates to:
  /// **'الجنس'**
  String get editAnimalGenderLabel;

  /// No description provided for @editAnimalDobLabel.
  ///
  /// In ar, this message translates to:
  /// **'تاريخ الميلاد'**
  String get editAnimalDobLabel;

  /// No description provided for @editAnimalWeightLabel.
  ///
  /// In ar, this message translates to:
  /// **'الوزن الحالي (كغ)'**
  String get editAnimalWeightLabel;

  /// No description provided for @editAnimalWeightHint.
  ///
  /// In ar, this message translates to:
  /// **'مثال: 45.5'**
  String get editAnimalWeightHint;

  /// No description provided for @editAnimalTagLabel.
  ///
  /// In ar, this message translates to:
  /// **'وسم المربّي'**
  String get editAnimalTagLabel;

  /// No description provided for @editAnimalTagHint.
  ///
  /// In ar, this message translates to:
  /// **'مثال: RED-001'**
  String get editAnimalTagHint;

  /// No description provided for @editAnimalStatusLabel.
  ///
  /// In ar, this message translates to:
  /// **'الحالة'**
  String get editAnimalStatusLabel;

  /// No description provided for @editAnimalSaveBtn.
  ///
  /// In ar, this message translates to:
  /// **'حفظ التعديلات'**
  String get editAnimalSaveBtn;

  /// No description provided for @editAnimalNotFound.
  ///
  /// In ar, this message translates to:
  /// **'الحيوان غير موجود'**
  String get editAnimalNotFound;

  /// No description provided for @genderMale.
  ///
  /// In ar, this message translates to:
  /// **'ذكر'**
  String get genderMale;

  /// No description provided for @genderFemale.
  ///
  /// In ar, this message translates to:
  /// **'أنثى'**
  String get genderFemale;

  /// No description provided for @qrScanTitle.
  ///
  /// In ar, this message translates to:
  /// **'مسح رمز QR'**
  String get qrScanTitle;

  /// No description provided for @qrScanInstruction.
  ///
  /// In ar, this message translates to:
  /// **'وجّه الكاميرا نحو رمز QR الخاص بـ سلالة'**
  String get qrScanInstruction;

  /// No description provided for @qrScanDemo.
  ///
  /// In ar, this message translates to:
  /// **'عرض تجريبي: اختر حيوانًا'**
  String get qrScanDemo;

  /// No description provided for @qrScanDemoSubtitle.
  ///
  /// In ar, this message translates to:
  /// **'اختر حيوانًا لمحاكاة المسح'**
  String get qrScanDemoSubtitle;

  /// No description provided for @healthTitle.
  ///
  /// In ar, this message translates to:
  /// **'الصحة'**
  String get healthTitle;

  /// No description provided for @healthUpcomingEvents.
  ///
  /// In ar, this message translates to:
  /// **'الأحداث القادمة'**
  String get healthUpcomingEvents;

  /// No description provided for @healthRecentRecords.
  ///
  /// In ar, this message translates to:
  /// **'السجلات الأخيرة'**
  String get healthRecentRecords;

  /// No description provided for @healthNoUpcoming.
  ///
  /// In ar, this message translates to:
  /// **'لا توجد أحداث قادمة'**
  String get healthNoUpcoming;

  /// No description provided for @healthNoRecords.
  ///
  /// In ar, this message translates to:
  /// **'لا توجد سجلات صحية بعد'**
  String get healthNoRecords;

  /// No description provided for @healthAddRecord.
  ///
  /// In ar, this message translates to:
  /// **'إضافة سجل'**
  String get healthAddRecord;

  /// No description provided for @healthDue.
  ///
  /// In ar, this message translates to:
  /// **'مستحق'**
  String get healthDue;

  /// No description provided for @healthOverdue.
  ///
  /// In ar, this message translates to:
  /// **'متأخر'**
  String get healthOverdue;

  /// No description provided for @healthOptionVaccination.
  ///
  /// In ar, this message translates to:
  /// **'تطعيم'**
  String get healthOptionVaccination;

  /// No description provided for @healthOptionVaccinationDesc.
  ///
  /// In ar, this message translates to:
  /// **'تسجيل لقاح مع تاريخ الاستحقاق التالي'**
  String get healthOptionVaccinationDesc;

  /// No description provided for @healthOptionTreatment.
  ///
  /// In ar, this message translates to:
  /// **'علاج'**
  String get healthOptionTreatment;

  /// No description provided for @healthOptionTreatmentDesc.
  ///
  /// In ar, this message translates to:
  /// **'تسجيل علاج طبي أو فحص'**
  String get healthOptionTreatmentDesc;

  /// No description provided for @healthOptionWeight.
  ///
  /// In ar, this message translates to:
  /// **'وزن'**
  String get healthOptionWeight;

  /// No description provided for @healthOptionWeightDesc.
  ///
  /// In ar, this message translates to:
  /// **'تسجيل قياس وزن'**
  String get healthOptionWeightDesc;

  /// No description provided for @healthOptionPregnancy.
  ///
  /// In ar, this message translates to:
  /// **'حمل'**
  String get healthOptionPregnancy;

  /// No description provided for @healthOptionPregnancyDesc.
  ///
  /// In ar, this message translates to:
  /// **'تسجيل تاريخ التلقيح والولادة المتوقعة'**
  String get healthOptionPregnancyDesc;

  /// No description provided for @healthOptionDeworming.
  ///
  /// In ar, this message translates to:
  /// **'تطفيل'**
  String get healthOptionDeworming;

  /// No description provided for @healthOptionDewormingDesc.
  ///
  /// In ar, this message translates to:
  /// **'تسجيل علاج التطفيل مع تاريخ الاستحقاق التالي'**
  String get healthOptionDewormingDesc;

  /// No description provided for @addVaccinationTitle.
  ///
  /// In ar, this message translates to:
  /// **'إضافة تطعيم'**
  String get addVaccinationTitle;

  /// No description provided for @addVaccinationAnimal.
  ///
  /// In ar, this message translates to:
  /// **'الحيوان'**
  String get addVaccinationAnimal;

  /// No description provided for @addVaccinationSelectAnimal.
  ///
  /// In ar, this message translates to:
  /// **'اختر الحيوان'**
  String get addVaccinationSelectAnimal;

  /// No description provided for @addVaccinationVaccineName.
  ///
  /// In ar, this message translates to:
  /// **'اسم اللقاح'**
  String get addVaccinationVaccineName;

  /// No description provided for @addVaccinationVaccineHint.
  ///
  /// In ar, this message translates to:
  /// **'مثال: لقاح الحمى القلاعية'**
  String get addVaccinationVaccineHint;

  /// No description provided for @addVaccinationRequired.
  ///
  /// In ar, this message translates to:
  /// **'مطلوب'**
  String get addVaccinationRequired;

  /// No description provided for @addVaccinationDateGiven.
  ///
  /// In ar, this message translates to:
  /// **'تاريخ التطعيم'**
  String get addVaccinationDateGiven;

  /// No description provided for @addVaccinationNextDue.
  ///
  /// In ar, this message translates to:
  /// **'تاريخ الاستحقاق التالي (اختياري)'**
  String get addVaccinationNextDue;

  /// No description provided for @addVaccinationVet.
  ///
  /// In ar, this message translates to:
  /// **'الطبيب البيطري'**
  String get addVaccinationVet;

  /// No description provided for @addVaccinationVetHint.
  ///
  /// In ar, this message translates to:
  /// **'مثال: د. خالد حسن'**
  String get addVaccinationVetHint;

  /// No description provided for @addVaccinationNotes.
  ///
  /// In ar, this message translates to:
  /// **'ملاحظات (اختياري)'**
  String get addVaccinationNotes;

  /// No description provided for @addVaccinationNotesHint.
  ///
  /// In ar, this message translates to:
  /// **'أي ملاحظات إضافية...'**
  String get addVaccinationNotesHint;

  /// No description provided for @addVaccinationSaveBtn.
  ///
  /// In ar, this message translates to:
  /// **'حفظ التطعيم'**
  String get addVaccinationSaveBtn;

  /// No description provided for @addVaccinationSelectFirst.
  ///
  /// In ar, this message translates to:
  /// **'يرجى اختيار حيوان أولاً'**
  String get addVaccinationSelectFirst;

  /// No description provided for @dateHint.
  ///
  /// In ar, this message translates to:
  /// **'YYYY-MM-DD'**
  String get dateHint;

  /// No description provided for @addTreatmentTitle.
  ///
  /// In ar, this message translates to:
  /// **'إضافة علاج'**
  String get addTreatmentTitle;

  /// No description provided for @addTreatmentType.
  ///
  /// In ar, this message translates to:
  /// **'نوع العلاج'**
  String get addTreatmentType;

  /// No description provided for @addTreatmentTypeHint.
  ///
  /// In ar, this message translates to:
  /// **'مثال: علاج جلدي، مضاد حيوي'**
  String get addTreatmentTypeHint;

  /// No description provided for @addTreatmentDate.
  ///
  /// In ar, this message translates to:
  /// **'التاريخ'**
  String get addTreatmentDate;

  /// No description provided for @addTreatmentMeds.
  ///
  /// In ar, this message translates to:
  /// **'الأدوية (اختياري)'**
  String get addTreatmentMeds;

  /// No description provided for @addTreatmentMedsHint.
  ///
  /// In ar, this message translates to:
  /// **'مثال: أوكسيتتراسايكلين 20مج'**
  String get addTreatmentMedsHint;

  /// No description provided for @addTreatmentVet.
  ///
  /// In ar, this message translates to:
  /// **'الطبيب البيطري'**
  String get addTreatmentVet;

  /// No description provided for @addTreatmentVetHint.
  ///
  /// In ar, this message translates to:
  /// **'مثال: د. سارة المطيري'**
  String get addTreatmentVetHint;

  /// No description provided for @addTreatmentNotes.
  ///
  /// In ar, this message translates to:
  /// **'ملاحظات (اختياري)'**
  String get addTreatmentNotes;

  /// No description provided for @addTreatmentNotesHint.
  ///
  /// In ar, this message translates to:
  /// **'الملاحظات، المتابعة...'**
  String get addTreatmentNotesHint;

  /// No description provided for @addTreatmentSaveBtn.
  ///
  /// In ar, this message translates to:
  /// **'حفظ العلاج'**
  String get addTreatmentSaveBtn;

  /// No description provided for @addTreatmentSelectFirst.
  ///
  /// In ar, this message translates to:
  /// **'يرجى اختيار حيوان أولاً'**
  String get addTreatmentSelectFirst;

  /// No description provided for @addWeightTitle.
  ///
  /// In ar, this message translates to:
  /// **'تسجيل الوزن'**
  String get addWeightTitle;

  /// No description provided for @addWeightLabel.
  ///
  /// In ar, this message translates to:
  /// **'الوزن'**
  String get addWeightLabel;

  /// No description provided for @addWeightHint.
  ///
  /// In ar, this message translates to:
  /// **'مثال: 45.5'**
  String get addWeightHint;

  /// No description provided for @addWeightRequired.
  ///
  /// In ar, this message translates to:
  /// **'مطلوب'**
  String get addWeightRequired;

  /// No description provided for @addWeightInvalid.
  ///
  /// In ar, this message translates to:
  /// **'رقم غير صحيح'**
  String get addWeightInvalid;

  /// No description provided for @addWeightUnit.
  ///
  /// In ar, this message translates to:
  /// **'الوحدة'**
  String get addWeightUnit;

  /// No description provided for @addWeightDateLabel.
  ///
  /// In ar, this message translates to:
  /// **'تاريخ القياس'**
  String get addWeightDateLabel;

  /// No description provided for @addWeightOfficial.
  ///
  /// In ar, this message translates to:
  /// **'قياس رسمي'**
  String get addWeightOfficial;

  /// No description provided for @addWeightOfficialDesc.
  ///
  /// In ar, this message translates to:
  /// **'موثّق من بيطري أو ميزان رسمي'**
  String get addWeightOfficialDesc;

  /// No description provided for @addWeightSaveBtn.
  ///
  /// In ar, this message translates to:
  /// **'حفظ الوزن'**
  String get addWeightSaveBtn;

  /// No description provided for @addWeightSelectFirst.
  ///
  /// In ar, this message translates to:
  /// **'يرجى اختيار حيوان أولاً'**
  String get addWeightSelectFirst;

  /// No description provided for @addPregnancyTitle.
  ///
  /// In ar, this message translates to:
  /// **'تسجيل الحمل'**
  String get addPregnancyTitle;

  /// No description provided for @addPregnancyInfo.
  ///
  /// In ar, this message translates to:
  /// **'فترة الحمل: الأغنام/الماعز ~5 أشهر · الأبقار ~9 أشهر · الإبل ~13 شهرًا · الخيول ~11 شهرًا'**
  String get addPregnancyInfo;

  /// No description provided for @addPregnancyDamLabel.
  ///
  /// In ar, this message translates to:
  /// **'الأم (الأم المرضعة)'**
  String get addPregnancyDamLabel;

  /// No description provided for @addPregnancyDamHint.
  ///
  /// In ar, this message translates to:
  /// **'اختر أنثى'**
  String get addPregnancyDamHint;

  /// No description provided for @addPregnancyMatingDate.
  ///
  /// In ar, this message translates to:
  /// **'تاريخ التلقيح'**
  String get addPregnancyMatingDate;

  /// No description provided for @addPregnancyExpected.
  ///
  /// In ar, this message translates to:
  /// **'الولادة المتوقعة (محسوبة تلقائيًا)'**
  String get addPregnancyExpected;

  /// No description provided for @addPregnancySireLabel.
  ///
  /// In ar, this message translates to:
  /// **'الفحل (اختياري)'**
  String get addPregnancySireLabel;

  /// No description provided for @addPregnancySireHint.
  ///
  /// In ar, this message translates to:
  /// **'اسم أو رقم الفحل'**
  String get addPregnancySireHint;

  /// No description provided for @addPregnancyNotes.
  ///
  /// In ar, this message translates to:
  /// **'ملاحظات (اختياري)'**
  String get addPregnancyNotes;

  /// No description provided for @addPregnancyNotesHint.
  ///
  /// In ar, this message translates to:
  /// **'أي ملاحظات إضافية'**
  String get addPregnancyNotesHint;

  /// No description provided for @addPregnancySaveBtn.
  ///
  /// In ar, this message translates to:
  /// **'حفظ سجل الحمل'**
  String get addPregnancySaveBtn;

  /// No description provided for @addDewormingTitle.
  ///
  /// In ar, this message translates to:
  /// **'تسجيل التطفيل'**
  String get addDewormingTitle;

  /// No description provided for @addDewormingAnimal.
  ///
  /// In ar, this message translates to:
  /// **'الحيوان'**
  String get addDewormingAnimal;

  /// No description provided for @addDewormingSelectAnimal.
  ///
  /// In ar, this message translates to:
  /// **'اختر الحيوان'**
  String get addDewormingSelectAnimal;

  /// No description provided for @addDewormingProduct.
  ///
  /// In ar, this message translates to:
  /// **'المنتج'**
  String get addDewormingProduct;

  /// No description provided for @addDewormingDateGiven.
  ///
  /// In ar, this message translates to:
  /// **'تاريخ العلاج'**
  String get addDewormingDateGiven;

  /// No description provided for @addDewormingNextDue.
  ///
  /// In ar, this message translates to:
  /// **'تاريخ الاستحقاق التالي (تلقائي: +3 أشهر)'**
  String get addDewormingNextDue;

  /// No description provided for @addDewormingDose.
  ///
  /// In ar, this message translates to:
  /// **'الجرعة (اختياري)'**
  String get addDewormingDose;

  /// No description provided for @addDewormingDoseHint.
  ///
  /// In ar, this message translates to:
  /// **'مثال: 5 مل، قرصان'**
  String get addDewormingDoseHint;

  /// No description provided for @addDewormingNotes.
  ///
  /// In ar, this message translates to:
  /// **'ملاحظات (اختياري)'**
  String get addDewormingNotes;

  /// No description provided for @addDewormingNotesHint.
  ///
  /// In ar, this message translates to:
  /// **'أي ملاحظات إضافية'**
  String get addDewormingNotesHint;

  /// No description provided for @addDewormingSaveBtn.
  ///
  /// In ar, this message translates to:
  /// **'حفظ سجل التطفيل'**
  String get addDewormingSaveBtn;

  /// No description provided for @healthHistoryWeightTrend.
  ///
  /// In ar, this message translates to:
  /// **'اتجاه الوزن'**
  String get healthHistoryWeightTrend;

  /// No description provided for @healthHistoryTimeline.
  ///
  /// In ar, this message translates to:
  /// **'الجدول الزمني الصحي'**
  String get healthHistoryTimeline;

  /// No description provided for @healthHistoryNoRecords.
  ///
  /// In ar, this message translates to:
  /// **'لا توجد سجلات صحية لهذا الحيوان'**
  String get healthHistoryNoRecords;

  /// No description provided for @breedingAddRecord.
  ///
  /// In ar, this message translates to:
  /// **'إضافة سجل تكاثر'**
  String get breedingAddRecord;

  /// No description provided for @breedingRecordsTitle.
  ///
  /// In ar, this message translates to:
  /// **'سجلات التكاثر'**
  String get breedingRecordsTitle;

  /// No description provided for @breedingNoRecords.
  ///
  /// In ar, this message translates to:
  /// **'لا توجد سجلات تكاثر بعد'**
  String get breedingNoRecords;

  /// No description provided for @breedingNoRecordsHint.
  ///
  /// In ar, this message translates to:
  /// **'سجّل روابط الأم والأب ونتائج الولادة'**
  String get breedingNoRecordsHint;

  /// No description provided for @breedingDam.
  ///
  /// In ar, this message translates to:
  /// **'♀ الأم'**
  String get breedingDam;

  /// No description provided for @breedingSire.
  ///
  /// In ar, this message translates to:
  /// **'♂ الأب'**
  String get breedingSire;

  /// No description provided for @breedingUnknown.
  ///
  /// In ar, this message translates to:
  /// **'مجهول'**
  String get breedingUnknown;

  /// No description provided for @breedingOffspringInfo.
  ///
  /// In ar, this message translates to:
  /// **'{born} مولود، {surviving} ناجٍ'**
  String breedingOffspringInfo(int born, int surviving);

  /// No description provided for @breedingWizardStep0Title.
  ///
  /// In ar, this message translates to:
  /// **'تأكيد الأم'**
  String get breedingWizardStep0Title;

  /// No description provided for @breedingWizardStep0Subtitle.
  ///
  /// In ar, this message translates to:
  /// **'سيتم تسجيل التكاثر للحيوان التالي.'**
  String get breedingWizardStep0Subtitle;

  /// No description provided for @breedingWizardStep0ConfirmBtn.
  ///
  /// In ar, this message translates to:
  /// **'تأكيد — متابعة'**
  String get breedingWizardStep0ConfirmBtn;

  /// No description provided for @breedingWizardUnnamed.
  ///
  /// In ar, this message translates to:
  /// **'بدون اسم'**
  String get breedingWizardUnnamed;

  /// No description provided for @breedingWizardFemale.
  ///
  /// In ar, this message translates to:
  /// **'أنثى'**
  String get breedingWizardFemale;

  /// No description provided for @breedingWizardStep1Title.
  ///
  /// In ar, this message translates to:
  /// **'اختر الفحل (الأب)'**
  String get breedingWizardStep1Title;

  /// No description provided for @breedingWizardStep1Subtitle.
  ///
  /// In ar, this message translates to:
  /// **'اختر من قطيعك أو علّمه كمجهول.'**
  String get breedingWizardStep1Subtitle;

  /// No description provided for @breedingWizardSireUnknown.
  ///
  /// In ar, this message translates to:
  /// **'الفحل مجهول / خارجي'**
  String get breedingWizardSireUnknown;

  /// No description provided for @breedingWizardSelectMale.
  ///
  /// In ar, this message translates to:
  /// **'اختر من الذكور'**
  String get breedingWizardSelectMale;

  /// No description provided for @breedingWizardSelectMaleHint.
  ///
  /// In ar, this message translates to:
  /// **'اختر حيوانًا ذكرًا'**
  String get breedingWizardSelectMaleHint;

  /// No description provided for @breedingWizardOrManual.
  ///
  /// In ar, this message translates to:
  /// **'أو أدخل الاسم يدويًا'**
  String get breedingWizardOrManual;

  /// No description provided for @breedingWizardSireHint.
  ///
  /// In ar, this message translates to:
  /// **'اسم الفحل / الرقم التعريفي (اختياري)'**
  String get breedingWizardSireHint;

  /// No description provided for @breedingWizardStep2Title.
  ///
  /// In ar, this message translates to:
  /// **'التلقيح والولادة المتوقعة'**
  String get breedingWizardStep2Title;

  /// No description provided for @breedingWizardStep2Subtitle.
  ///
  /// In ar, this message translates to:
  /// **'تُحسب الولادة المتوقعة تلقائيًا حسب النوع.'**
  String get breedingWizardStep2Subtitle;

  /// No description provided for @breedingWizardMatingDate.
  ///
  /// In ar, this message translates to:
  /// **'تاريخ التلقيح'**
  String get breedingWizardMatingDate;

  /// No description provided for @breedingWizardExpectedDelivery.
  ///
  /// In ar, this message translates to:
  /// **'الولادة المتوقعة (محسوبة تلقائيًا)'**
  String get breedingWizardExpectedDelivery;

  /// No description provided for @breedingWizardStep3Title.
  ///
  /// In ar, this message translates to:
  /// **'نتيجة الولادة'**
  String get breedingWizardStep3Title;

  /// No description provided for @breedingWizardStep3Subtitle.
  ///
  /// In ar, this message translates to:
  /// **'سجّل نتائج الولادة.'**
  String get breedingWizardStep3Subtitle;

  /// No description provided for @breedingWizardTotalOffspring.
  ///
  /// In ar, this message translates to:
  /// **'إجمالي المواليد'**
  String get breedingWizardTotalOffspring;

  /// No description provided for @breedingWizardSurviving.
  ///
  /// In ar, this message translates to:
  /// **'الناجون'**
  String get breedingWizardSurviving;

  /// No description provided for @breedingWizardMalesBorn.
  ///
  /// In ar, this message translates to:
  /// **'الذكور المولودون'**
  String get breedingWizardMalesBorn;

  /// No description provided for @breedingWizardFemalesBorn.
  ///
  /// In ar, this message translates to:
  /// **'الإناث المولودات'**
  String get breedingWizardFemalesBorn;

  /// No description provided for @breedingWizardNotes.
  ///
  /// In ar, this message translates to:
  /// **'ملاحظات (اختياري)'**
  String get breedingWizardNotes;

  /// No description provided for @breedingWizardNotesHint.
  ///
  /// In ar, this message translates to:
  /// **'مثال: توأم، كلاهما بصحة جيدة...'**
  String get breedingWizardNotesHint;

  /// No description provided for @breedingWizardStep4Title.
  ///
  /// In ar, this message translates to:
  /// **'مراجعة وتأكيد'**
  String get breedingWizardStep4Title;

  /// No description provided for @breedingWizardStep4Subtitle.
  ///
  /// In ar, this message translates to:
  /// **'يرجى المراجعة قبل الحفظ. هذا السجل دائم.'**
  String get breedingWizardStep4Subtitle;

  /// No description provided for @breedingWizardMother.
  ///
  /// In ar, this message translates to:
  /// **'الأم'**
  String get breedingWizardMother;

  /// No description provided for @breedingWizardFather.
  ///
  /// In ar, this message translates to:
  /// **'الأب'**
  String get breedingWizardFather;

  /// No description provided for @breedingWizardGenderSplit.
  ///
  /// In ar, this message translates to:
  /// **'توزيع الجنس'**
  String get breedingWizardGenderSplit;

  /// No description provided for @breedingWizardSaveBtn.
  ///
  /// In ar, this message translates to:
  /// **'حفظ سجل التكاثر'**
  String get breedingWizardSaveBtn;

  /// No description provided for @stepLabel.
  ///
  /// In ar, this message translates to:
  /// **'خطوة {step} من {total}'**
  String stepLabel(int step, int total);

  /// No description provided for @transferTitle.
  ///
  /// In ar, this message translates to:
  /// **'نقل الملكية'**
  String get transferTitle;

  /// No description provided for @transferTypeTitle.
  ///
  /// In ar, this message translates to:
  /// **'نوع النقل'**
  String get transferTypeTitle;

  /// No description provided for @transferTypeSubtitle.
  ///
  /// In ar, this message translates to:
  /// **'كيف يتم نقل هذا الحيوان؟'**
  String get transferTypeSubtitle;

  /// No description provided for @transferTypeSale.
  ///
  /// In ar, this message translates to:
  /// **'بيع'**
  String get transferTypeSale;

  /// No description provided for @transferTypeSaleDesc.
  ///
  /// In ar, this message translates to:
  /// **'نقل بمقابل مادي'**
  String get transferTypeSaleDesc;

  /// No description provided for @transferTypeGift.
  ///
  /// In ar, this message translates to:
  /// **'هبة'**
  String get transferTypeGift;

  /// No description provided for @transferTypeGiftDesc.
  ///
  /// In ar, this message translates to:
  /// **'نقل بدون مقابل'**
  String get transferTypeGiftDesc;

  /// No description provided for @transferTypeInternal.
  ///
  /// In ar, this message translates to:
  /// **'داخلي'**
  String get transferTypeInternal;

  /// No description provided for @transferTypeInternalDesc.
  ///
  /// In ar, this message translates to:
  /// **'نقل داخل المنشأة'**
  String get transferTypeInternalDesc;

  /// No description provided for @transferPriceTitle.
  ///
  /// In ar, this message translates to:
  /// **'سعر البيع'**
  String get transferPriceTitle;

  /// No description provided for @transferPriceSubtitle.
  ///
  /// In ar, this message translates to:
  /// **'أدخل السعر المتفق عليه'**
  String get transferPriceSubtitle;

  /// No description provided for @transferPriceLabel.
  ///
  /// In ar, this message translates to:
  /// **'السعر'**
  String get transferPriceLabel;

  /// No description provided for @transferPriceHint.
  ///
  /// In ar, this message translates to:
  /// **'مثال: 5000'**
  String get transferPriceHint;

  /// No description provided for @transferCurrencyLabel.
  ///
  /// In ar, this message translates to:
  /// **'العملة'**
  String get transferCurrencyLabel;

  /// No description provided for @transferNewOwnerTitle.
  ///
  /// In ar, this message translates to:
  /// **'المالك الجديد'**
  String get transferNewOwnerTitle;

  /// No description provided for @transferNewOwnerSubtitle.
  ///
  /// In ar, this message translates to:
  /// **'ابحث برقم الجوال أو اختر من جهات الاتصال'**
  String get transferNewOwnerSubtitle;

  /// No description provided for @transferPhoneLabel.
  ///
  /// In ar, this message translates to:
  /// **'رقم الجوال'**
  String get transferPhoneLabel;

  /// No description provided for @transferPhoneHint.
  ///
  /// In ar, this message translates to:
  /// **'+966 5XX XXX XXXX'**
  String get transferPhoneHint;

  /// No description provided for @transferPickContact.
  ///
  /// In ar, this message translates to:
  /// **'اختيار من جهات الاتصال'**
  String get transferPickContact;

  /// No description provided for @orLabel.
  ///
  /// In ar, this message translates to:
  /// **'أو'**
  String get orLabel;

  /// No description provided for @permissionContactsDenied.
  ///
  /// In ar, this message translates to:
  /// **'لم يتم منح إذن جهات الاتصال'**
  String get permissionContactsDenied;

  /// No description provided for @transferOrPick.
  ///
  /// In ar, this message translates to:
  /// **'أو اختر من جهات الاتصال التجريبية:'**
  String get transferOrPick;

  /// No description provided for @transferDocTitle.
  ///
  /// In ar, this message translates to:
  /// **'إرفاق وثيقة'**
  String get transferDocTitle;

  /// No description provided for @transferDocSubtitle.
  ///
  /// In ar, this message translates to:
  /// **'اختياري: أرفق اتفاقية البيع أو شهادة النقل'**
  String get transferDocSubtitle;

  /// No description provided for @transferDocTap.
  ///
  /// In ar, this message translates to:
  /// **'اضغط لإرفاق وثيقة'**
  String get transferDocTap;

  /// No description provided for @transferDocAttached.
  ///
  /// In ar, this message translates to:
  /// **'وثيقة مرفقة'**
  String get transferDocAttached;

  /// No description provided for @transferDocTypes.
  ///
  /// In ar, this message translates to:
  /// **'PDF، JPG، أو PNG'**
  String get transferDocTypes;

  /// No description provided for @transferDocSkip.
  ///
  /// In ar, this message translates to:
  /// **'متابعة بدون وثيقة'**
  String get transferDocSkip;

  /// No description provided for @transferReviewTitle.
  ///
  /// In ar, this message translates to:
  /// **'مراجعة النقل'**
  String get transferReviewTitle;

  /// No description provided for @transferReviewSubtitle.
  ///
  /// In ar, this message translates to:
  /// **'يرجى المراجعة قبل التأكيد. هذا الإجراء لا يمكن التراجع عنه.'**
  String get transferReviewSubtitle;

  /// No description provided for @transferAnimalLabel.
  ///
  /// In ar, this message translates to:
  /// **'الحيوان'**
  String get transferAnimalLabel;

  /// No description provided for @transferTypeLabel.
  ///
  /// In ar, this message translates to:
  /// **'نوع النقل'**
  String get transferTypeLabel;

  /// No description provided for @transferFromLabel.
  ///
  /// In ar, this message translates to:
  /// **'من'**
  String get transferFromLabel;

  /// No description provided for @transferToLabel.
  ///
  /// In ar, this message translates to:
  /// **'إلى'**
  String get transferToLabel;

  /// No description provided for @transferPriceReview.
  ///
  /// In ar, this message translates to:
  /// **'السعر'**
  String get transferPriceReview;

  /// No description provided for @transferDocLabel.
  ///
  /// In ar, this message translates to:
  /// **'الوثيقة'**
  String get transferDocLabel;

  /// No description provided for @transferDocAttachedVal.
  ///
  /// In ar, this message translates to:
  /// **'مرفقة'**
  String get transferDocAttachedVal;

  /// No description provided for @transferDocNone.
  ///
  /// In ar, this message translates to:
  /// **'لا يوجد'**
  String get transferDocNone;

  /// No description provided for @transferDateLabel.
  ///
  /// In ar, this message translates to:
  /// **'التاريخ'**
  String get transferDateLabel;

  /// No description provided for @transferWarning.
  ///
  /// In ar, this message translates to:
  /// **'هذا النقل دائم ولا يمكن التراجع عنه. سيتم حفظ السجل بشكل دائم.'**
  String get transferWarning;

  /// No description provided for @transferConfirmBtn.
  ///
  /// In ar, this message translates to:
  /// **'تأكيد النقل'**
  String get transferConfirmBtn;

  /// No description provided for @settingsTitle.
  ///
  /// In ar, this message translates to:
  /// **'الإعدادات'**
  String get settingsTitle;

  /// No description provided for @settingsSectionOrg.
  ///
  /// In ar, this message translates to:
  /// **'المنشأة'**
  String get settingsSectionOrg;

  /// No description provided for @settingsOrgSettings.
  ///
  /// In ar, this message translates to:
  /// **'إعدادات المنشأة'**
  String get settingsOrgSettings;

  /// No description provided for @settingsWorkerMgmt.
  ///
  /// In ar, this message translates to:
  /// **'إدارة العمال'**
  String get settingsWorkerMgmt;

  /// No description provided for @settingsWorkerMgmtDesc.
  ///
  /// In ar, this message translates to:
  /// **'إدارة أعضاء الفريق والأدوار'**
  String get settingsWorkerMgmtDesc;

  /// No description provided for @settingsSectionData.
  ///
  /// In ar, this message translates to:
  /// **'البيانات'**
  String get settingsSectionData;

  /// No description provided for @settingsImport.
  ///
  /// In ar, this message translates to:
  /// **'استيراد الحيوانات'**
  String get settingsImport;

  /// No description provided for @settingsImportDesc.
  ///
  /// In ar, this message translates to:
  /// **'استيراد من ملف CSV أو Excel'**
  String get settingsImportDesc;

  /// No description provided for @settingsImportBadge.
  ///
  /// In ar, this message translates to:
  /// **'جديد'**
  String get settingsImportBadge;

  /// No description provided for @settingsExport.
  ///
  /// In ar, this message translates to:
  /// **'تصدير البيانات'**
  String get settingsExport;

  /// No description provided for @settingsExportDesc.
  ///
  /// In ar, this message translates to:
  /// **'تصدير قائمة الحيوانات إلى CSV'**
  String get settingsExportDesc;

  /// No description provided for @settingsSectionPref.
  ///
  /// In ar, this message translates to:
  /// **'التفضيلات'**
  String get settingsSectionPref;

  /// No description provided for @settingsNotifications.
  ///
  /// In ar, this message translates to:
  /// **'الإشعارات'**
  String get settingsNotifications;

  /// No description provided for @settingsNotificationsDesc.
  ///
  /// In ar, this message translates to:
  /// **'تذكيرات التطعيم والتنبيهات'**
  String get settingsNotificationsDesc;

  /// No description provided for @settingsLanguage.
  ///
  /// In ar, this message translates to:
  /// **'اللغة'**
  String get settingsLanguage;

  /// No description provided for @settingsSectionAccount.
  ///
  /// In ar, this message translates to:
  /// **'الحساب'**
  String get settingsSectionAccount;

  /// No description provided for @settingsHelp.
  ///
  /// In ar, this message translates to:
  /// **'المساعدة والدعم'**
  String get settingsHelp;

  /// No description provided for @settingsHelpDesc.
  ///
  /// In ar, this message translates to:
  /// **'الأسئلة الشائعة والتواصل'**
  String get settingsHelpDesc;

  /// No description provided for @settingsLogout.
  ///
  /// In ar, this message translates to:
  /// **'تسجيل الخروج'**
  String get settingsLogout;

  /// No description provided for @settingsLogoutDesc.
  ///
  /// In ar, this message translates to:
  /// **'تسجيل الخروج من حسابك'**
  String get settingsLogoutDesc;

  /// No description provided for @settingsLogoutTitle.
  ///
  /// In ar, this message translates to:
  /// **'تسجيل الخروج؟'**
  String get settingsLogoutTitle;

  /// No description provided for @settingsLogoutMsg.
  ///
  /// In ar, this message translates to:
  /// **'ستحتاج إلى تسجيل الدخول مجددًا للوصول إلى قطيعك.'**
  String get settingsLogoutMsg;

  /// No description provided for @profileEditTitle.
  ///
  /// In ar, this message translates to:
  /// **'تعديل الملف الشخصي'**
  String get profileEditTitle;

  /// No description provided for @profileFullName.
  ///
  /// In ar, this message translates to:
  /// **'الاسم الكامل'**
  String get profileFullName;

  /// No description provided for @profilePhone.
  ///
  /// In ar, this message translates to:
  /// **'رقم الجوال'**
  String get profilePhone;

  /// No description provided for @profileSaveBtn.
  ///
  /// In ar, this message translates to:
  /// **'حفظ التعديلات'**
  String get profileSaveBtn;

  /// No description provided for @profileUnnamed.
  ///
  /// In ar, this message translates to:
  /// **'مستخدم'**
  String get profileUnnamed;

  /// No description provided for @roleOwner.
  ///
  /// In ar, this message translates to:
  /// **'مالك'**
  String get roleOwner;

  /// No description provided for @settingsOrgSettingsDesc.
  ///
  /// In ar, this message translates to:
  /// **'إعدادات المنشأة'**
  String get settingsOrgSettingsDesc;

  /// No description provided for @orgSettingsTitle.
  ///
  /// In ar, this message translates to:
  /// **'إعدادات المنشأة'**
  String get orgSettingsTitle;

  /// No description provided for @orgSettingsNameLabel.
  ///
  /// In ar, this message translates to:
  /// **'اسم المزرعة / المنشأة'**
  String get orgSettingsNameLabel;

  /// No description provided for @orgSettingsNameRequired.
  ///
  /// In ar, this message translates to:
  /// **'مطلوب'**
  String get orgSettingsNameRequired;

  /// No description provided for @orgSettingsTypeLabel.
  ///
  /// In ar, this message translates to:
  /// **'نوع المنشأة'**
  String get orgSettingsTypeLabel;

  /// No description provided for @orgSettingsCountryLabel.
  ///
  /// In ar, this message translates to:
  /// **'الدولة'**
  String get orgSettingsCountryLabel;

  /// No description provided for @orgSettingsSaveBtn.
  ///
  /// In ar, this message translates to:
  /// **'حفظ التعديلات'**
  String get orgSettingsSaveBtn;

  /// No description provided for @orgTypeOptionIndividual.
  ///
  /// In ar, this message translates to:
  /// **'فردي'**
  String get orgTypeOptionIndividual;

  /// No description provided for @orgTypeOptionSmall.
  ///
  /// In ar, this message translates to:
  /// **'مزرعة صغيرة'**
  String get orgTypeOptionSmall;

  /// No description provided for @orgTypeOptionCommercial.
  ///
  /// In ar, this message translates to:
  /// **'مزرعة تجارية'**
  String get orgTypeOptionCommercial;

  /// No description provided for @orgTypeOptionGovt.
  ///
  /// In ar, this message translates to:
  /// **'حكومي'**
  String get orgTypeOptionGovt;

  /// No description provided for @workersTitle.
  ///
  /// In ar, this message translates to:
  /// **'العمال'**
  String get workersTitle;

  /// No description provided for @workersCount.
  ///
  /// In ar, this message translates to:
  /// **'{count} عضو في الفريق'**
  String workersCount(int count);

  /// No description provided for @workersInviteBtn.
  ///
  /// In ar, this message translates to:
  /// **'دعوة عامل'**
  String get workersInviteBtn;

  /// No description provided for @workersRoleWorker.
  ///
  /// In ar, this message translates to:
  /// **'عامل'**
  String get workersRoleWorker;

  /// No description provided for @workersRoleSupervisor.
  ///
  /// In ar, this message translates to:
  /// **'مشرف'**
  String get workersRoleSupervisor;

  /// No description provided for @workersInviteTitle.
  ///
  /// In ar, this message translates to:
  /// **'دعوة عامل'**
  String get workersInviteTitle;

  /// No description provided for @workersInviteNameLabel.
  ///
  /// In ar, this message translates to:
  /// **'الاسم'**
  String get workersInviteNameLabel;

  /// No description provided for @workersInviteNameHint.
  ///
  /// In ar, this message translates to:
  /// **'مثال: فيصل الدوسري'**
  String get workersInviteNameHint;

  /// No description provided for @workersInvitePhoneLabel.
  ///
  /// In ar, this message translates to:
  /// **'رقم الجوال'**
  String get workersInvitePhoneLabel;

  /// No description provided for @workersInvitePhoneHint.
  ///
  /// In ar, this message translates to:
  /// **'+966 5XX XXX XXXX'**
  String get workersInvitePhoneHint;

  /// No description provided for @workersInviteRoleLabel.
  ///
  /// In ar, this message translates to:
  /// **'الدور'**
  String get workersInviteRoleLabel;

  /// No description provided for @workersInviteSendBtn.
  ///
  /// In ar, this message translates to:
  /// **'إرسال الدعوة'**
  String get workersInviteSendBtn;

  /// No description provided for @importTitle.
  ///
  /// In ar, this message translates to:
  /// **'استيراد الحيوانات'**
  String get importTitle;

  /// No description provided for @importStep0.
  ///
  /// In ar, this message translates to:
  /// **'اختر الملف'**
  String get importStep0;

  /// No description provided for @importStep1.
  ///
  /// In ar, this message translates to:
  /// **'تعيين الأعمدة'**
  String get importStep1;

  /// No description provided for @importStep2.
  ///
  /// In ar, this message translates to:
  /// **'معاينة'**
  String get importStep2;

  /// No description provided for @importStep3.
  ///
  /// In ar, this message translates to:
  /// **'استيراد'**
  String get importStep3;

  /// No description provided for @importPickTitle.
  ///
  /// In ar, this message translates to:
  /// **'اختر الملف'**
  String get importPickTitle;

  /// No description provided for @importPickSubtitle.
  ///
  /// In ar, this message translates to:
  /// **'اختر ملف CSV أو Excel يحتوي على بيانات حيواناتك.'**
  String get importPickSubtitle;

  /// No description provided for @importPickTap.
  ///
  /// In ar, this message translates to:
  /// **'اضغط لاختيار الملف'**
  String get importPickTap;

  /// No description provided for @importPickTypes.
  ///
  /// In ar, this message translates to:
  /// **'يدعم .csv و .xlsx'**
  String get importPickTypes;

  /// No description provided for @importRowsDetected.
  ///
  /// In ar, this message translates to:
  /// **'{count} صف مكتشف'**
  String importRowsDetected(int count);

  /// No description provided for @importAutoMapped.
  ///
  /// In ar, this message translates to:
  /// **'{count} عمود تم ربطه تلقائياً'**
  String importAutoMapped(int count);

  /// No description provided for @importDetectedColumns.
  ///
  /// In ar, this message translates to:
  /// **'الأعمدة المكتشفة'**
  String get importDetectedColumns;

  /// No description provided for @importMoreRows.
  ///
  /// In ar, this message translates to:
  /// **'صف إضافي'**
  String get importMoreRows;

  /// No description provided for @importDownloadTemplate.
  ///
  /// In ar, this message translates to:
  /// **'تحميل نموذج CSV'**
  String get importDownloadTemplate;

  /// No description provided for @importPickBtn.
  ///
  /// In ar, this message translates to:
  /// **'اختر الملف'**
  String get importPickBtn;

  /// No description provided for @importMapTitle.
  ///
  /// In ar, this message translates to:
  /// **'تعيين الأعمدة'**
  String get importMapTitle;

  /// No description provided for @importMapSubtitle.
  ///
  /// In ar, this message translates to:
  /// **'طابق أعمدة جدولك مع حقول سلالة.'**
  String get importMapSubtitle;

  /// No description provided for @importCsvColumn.
  ///
  /// In ar, this message translates to:
  /// **'عمود CSV'**
  String get importCsvColumn;

  /// No description provided for @importMapContinue.
  ///
  /// In ar, this message translates to:
  /// **'متابعة إلى المعاينة'**
  String get importMapContinue;

  /// No description provided for @importPreviewTitle.
  ///
  /// In ar, this message translates to:
  /// **'معاينة البيانات'**
  String get importPreviewTitle;

  /// No description provided for @importPreviewReady.
  ///
  /// In ar, this message translates to:
  /// **'{count} صف جاهز'**
  String importPreviewReady(int count);

  /// No description provided for @importNoErrors.
  ///
  /// In ar, this message translates to:
  /// **'لا توجد أخطاء'**
  String get importNoErrors;

  /// No description provided for @importStartBtn.
  ///
  /// In ar, this message translates to:
  /// **'بدء الاستيراد'**
  String get importStartBtn;

  /// No description provided for @importProgressTitle.
  ///
  /// In ar, this message translates to:
  /// **'جارٍ الاستيراد…'**
  String get importProgressTitle;

  /// No description provided for @importProgress.
  ///
  /// In ar, this message translates to:
  /// **'{done} / {total} حيوان'**
  String importProgress(int done, int total);

  /// No description provided for @importBtn.
  ///
  /// In ar, this message translates to:
  /// **'استيراد {count} حيوان'**
  String importBtn(int count);

  /// No description provided for @importSuccessTitle.
  ///
  /// In ar, this message translates to:
  /// **'اكتمل الاستيراد!'**
  String get importSuccessTitle;

  /// No description provided for @importSuccessMsg.
  ///
  /// In ar, this message translates to:
  /// **'تمت إضافة {count} حيوان إلى قطيعك'**
  String importSuccessMsg(int count);

  /// No description provided for @importSuccessNote.
  ///
  /// In ar, this message translates to:
  /// **'حصل كل حيوان على رقم سلالة فريد'**
  String get importSuccessNote;

  /// No description provided for @importViewAnimals.
  ///
  /// In ar, this message translates to:
  /// **'عرض الحيوانات'**
  String get importViewAnimals;

  /// No description provided for @languageArabic.
  ///
  /// In ar, this message translates to:
  /// **'العربية'**
  String get languageArabic;

  /// No description provided for @languageEnglish.
  ///
  /// In ar, this message translates to:
  /// **'English'**
  String get languageEnglish;

  /// No description provided for @languageToggleTitle.
  ///
  /// In ar, this message translates to:
  /// **'اللغة / Language'**
  String get languageToggleTitle;

  /// No description provided for @languageSelect.
  ///
  /// In ar, this message translates to:
  /// **'اختر اللغة'**
  String get languageSelect;

  /// No description provided for @breedPickerTitle.
  ///
  /// In ar, this message translates to:
  /// **'اختر السلالة'**
  String get breedPickerTitle;

  /// No description provided for @breedPickerSearch.
  ///
  /// In ar, this message translates to:
  /// **'ابحث عن سلالة…'**
  String get breedPickerSearch;

  /// No description provided for @breedPickerAddCustom.
  ///
  /// In ar, this message translates to:
  /// **'إضافة سلالة مخصصة'**
  String get breedPickerAddCustom;

  /// No description provided for @breedPickerCustomHint.
  ///
  /// In ar, this message translates to:
  /// **'أدخل اسم السلالة'**
  String get breedPickerCustomHint;

  /// No description provided for @breedPickerCustomSave.
  ///
  /// In ar, this message translates to:
  /// **'إضافة'**
  String get breedPickerCustomSave;

  /// No description provided for @breedPickerNoneSelected.
  ///
  /// In ar, this message translates to:
  /// **'لم يتم الاختيار'**
  String get breedPickerNoneSelected;

  /// No description provided for @colorPickerColorLabel.
  ///
  /// In ar, this message translates to:
  /// **'لون الحيوان'**
  String get colorPickerColorLabel;

  /// No description provided for @tagColorLabel.
  ///
  /// In ar, this message translates to:
  /// **'لون الوسم (لون بطاقة التعريف)'**
  String get tagColorLabel;

  /// No description provided for @tagNumberLabel.
  ///
  /// In ar, this message translates to:
  /// **'رقم الوسم (0–500)'**
  String get tagNumberLabel;

  /// No description provided for @breedingDeliveryOn.
  ///
  /// In ar, this message translates to:
  /// **'ولادة — {date}'**
  String breedingDeliveryOn(String date);

  /// No description provided for @breedingActivePregnancy.
  ///
  /// In ar, this message translates to:
  /// **'حمل نشط'**
  String get breedingActivePregnancy;

  /// No description provided for @breedingExpectedDeliveryIn.
  ///
  /// In ar, this message translates to:
  /// **'الولادة المتوقعة بعد {days} يوم'**
  String breedingExpectedDeliveryIn(int days);

  /// No description provided for @upcomingBirthLabel.
  ///
  /// In ar, this message translates to:
  /// **'ولادة متوقعة'**
  String get upcomingBirthLabel;

  /// No description provided for @statusActive.
  ///
  /// In ar, this message translates to:
  /// **'نشط'**
  String get statusActive;

  /// No description provided for @statusForSale.
  ///
  /// In ar, this message translates to:
  /// **'للبيع'**
  String get statusForSale;

  /// No description provided for @statusReserved.
  ///
  /// In ar, this message translates to:
  /// **'محجوز'**
  String get statusReserved;

  /// No description provided for @statusCharity.
  ///
  /// In ar, this message translates to:
  /// **'صدقة'**
  String get statusCharity;

  /// No description provided for @statusLoaned.
  ///
  /// In ar, this message translates to:
  /// **'معار'**
  String get statusLoaned;

  /// No description provided for @statusSold.
  ///
  /// In ar, this message translates to:
  /// **'مباع'**
  String get statusSold;

  /// No description provided for @statusDeceased.
  ///
  /// In ar, this message translates to:
  /// **'نافق'**
  String get statusDeceased;

  /// No description provided for @statusMissing.
  ///
  /// In ar, this message translates to:
  /// **'مفقود'**
  String get statusMissing;

  /// No description provided for @animalPenLabel.
  ///
  /// In ar, this message translates to:
  /// **'الحظيرة'**
  String get animalPenLabel;

  /// No description provided for @animalPenHint.
  ///
  /// In ar, this message translates to:
  /// **'اختر الحظيرة'**
  String get animalPenHint;

  /// No description provided for @animalPenNone.
  ///
  /// In ar, this message translates to:
  /// **'بدون حظيرة'**
  String get animalPenNone;

  /// No description provided for @animalAgeClassLabel.
  ///
  /// In ar, this message translates to:
  /// **'الفئة العمرية (السن)'**
  String get animalAgeClassLabel;

  /// No description provided for @animalAgeClassHint.
  ///
  /// In ar, this message translates to:
  /// **'تُحسب تلقائيًا من تاريخ الميلاد'**
  String get animalAgeClassHint;

  /// No description provided for @ageClassBahm.
  ///
  /// In ar, this message translates to:
  /// **'بهم (أقل من سنة)'**
  String get ageClassBahm;

  /// No description provided for @ageClassJadh.
  ///
  /// In ar, this message translates to:
  /// **'جذع (1–2 سنة)'**
  String get ageClassJadh;

  /// No description provided for @ageClassThani.
  ///
  /// In ar, this message translates to:
  /// **'ثني (2–3 سنوات)'**
  String get ageClassThani;

  /// No description provided for @ageClassRubaa.
  ///
  /// In ar, this message translates to:
  /// **'رباع (3–4 سنوات)'**
  String get ageClassRubaa;

  /// No description provided for @ageClassSudas.
  ///
  /// In ar, this message translates to:
  /// **'سديس (4–5 سنوات)'**
  String get ageClassSudas;

  /// No description provided for @ageClassTam.
  ///
  /// In ar, this message translates to:
  /// **'تام (5 سنوات فأكثر)'**
  String get ageClassTam;

  /// No description provided for @animalPurposeLabel.
  ///
  /// In ar, this message translates to:
  /// **'الغرض'**
  String get animalPurposeLabel;

  /// No description provided for @animalPurposeBreeding.
  ///
  /// In ar, this message translates to:
  /// **'تربية'**
  String get animalPurposeBreeding;

  /// No description provided for @animalPurposeFattening.
  ///
  /// In ar, this message translates to:
  /// **'تسمين'**
  String get animalPurposeFattening;

  /// No description provided for @animalWeaningLabel.
  ///
  /// In ar, this message translates to:
  /// **'نافذة الفطام (بالأيام)'**
  String get animalWeaningLabel;

  /// No description provided for @animalWeaningFrom.
  ///
  /// In ar, this message translates to:
  /// **'من'**
  String get animalWeaningFrom;

  /// No description provided for @animalWeaningTo.
  ///
  /// In ar, this message translates to:
  /// **'إلى'**
  String get animalWeaningTo;

  /// No description provided for @animalWeaningHint.
  ///
  /// In ar, this message translates to:
  /// **'مثال: من 40 إلى 60 يوم'**
  String get animalWeaningHint;

  /// No description provided for @animalWeaningBadge.
  ///
  /// In ar, this message translates to:
  /// **'موعد فطام'**
  String get animalWeaningBadge;

  /// No description provided for @animalOfficialTag.
  ///
  /// In ar, this message translates to:
  /// **'رقم الوسم الرسمي'**
  String get animalOfficialTag;

  /// No description provided for @animalOfficialTagHint.
  ///
  /// In ar, this message translates to:
  /// **'الرقم الحكومي (اختياري)'**
  String get animalOfficialTagHint;

  /// No description provided for @animalPriceLabel.
  ///
  /// In ar, this message translates to:
  /// **'السعر (ريال سعودي)'**
  String get animalPriceLabel;

  /// No description provided for @animalPriceHint.
  ///
  /// In ar, this message translates to:
  /// **'مثال: 1500'**
  String get animalPriceHint;

  /// No description provided for @udhiyaSection.
  ///
  /// In ar, this message translates to:
  /// **'الأضحية'**
  String get udhiyaSection;

  /// No description provided for @udhiyaEligible.
  ///
  /// In ar, this message translates to:
  /// **'مؤهل للأضحية'**
  String get udhiyaEligible;

  /// No description provided for @udhiyaNotEligible.
  ///
  /// In ar, this message translates to:
  /// **'غير مؤهل للأضحية'**
  String get udhiyaNotEligible;

  /// No description provided for @udhiyaMinAgeRequired.
  ///
  /// In ar, this message translates to:
  /// **'الحد الأدنى للسن: {age}'**
  String udhiyaMinAgeRequired(String age);

  /// No description provided for @udhiyaCurrentAge.
  ///
  /// In ar, this message translates to:
  /// **'العمر الحالي: {age}'**
  String udhiyaCurrentAge(String age);

  /// No description provided for @udhiyaStatusIneligible.
  ///
  /// In ar, this message translates to:
  /// **'الحالة: {status}'**
  String udhiyaStatusIneligible(String status);

  /// No description provided for @udhiyaSpeciesIneligible.
  ///
  /// In ar, this message translates to:
  /// **'هذا النوع غير مؤهل للأضحية'**
  String get udhiyaSpeciesIneligible;

  /// No description provided for @udhiyaShortcutLabel.
  ///
  /// In ar, this message translates to:
  /// **'الأضحية'**
  String get udhiyaShortcutLabel;

  /// No description provided for @settingsHijriCalendar.
  ///
  /// In ar, this message translates to:
  /// **'التاريخ الهجري'**
  String get settingsHijriCalendar;

  /// No description provided for @settingsHijriCalendarDesc.
  ///
  /// In ar, this message translates to:
  /// **'عرض التواريخ بالتقويم الهجري'**
  String get settingsHijriCalendarDesc;

  /// No description provided for @settingsUdhiyaIndicator.
  ///
  /// In ar, this message translates to:
  /// **'عرض مؤشر الأضحية'**
  String get settingsUdhiyaIndicator;

  /// No description provided for @settingsUdhiyaIndicatorDesc.
  ///
  /// In ar, this message translates to:
  /// **'عرض أهلية الأضحية على بطاقات الحيوانات'**
  String get settingsUdhiyaIndicatorDesc;

  /// No description provided for @settingsPens.
  ///
  /// In ar, this message translates to:
  /// **'الحظائر'**
  String get settingsPens;

  /// No description provided for @settingsPensDesc.
  ///
  /// In ar, this message translates to:
  /// **'إدارة مجموعات الحظائر'**
  String get settingsPensDesc;

  /// No description provided for @settingsFieldLabels.
  ///
  /// In ar, this message translates to:
  /// **'تخصيص التسميات'**
  String get settingsFieldLabels;

  /// No description provided for @settingsFieldLabelsDesc.
  ///
  /// In ar, this message translates to:
  /// **'تغيير أسماء الحقول في النماذج'**
  String get settingsFieldLabelsDesc;

  /// No description provided for @fieldLabelsPageTitle.
  ///
  /// In ar, this message translates to:
  /// **'تخصيص التسميات'**
  String get fieldLabelsPageTitle;

  /// No description provided for @fieldLabelsPageSubtitle.
  ///
  /// In ar, this message translates to:
  /// **'يمكنك تغيير أسماء الحقول التي تظهر في نماذج الإضافة والتعديل.'**
  String get fieldLabelsPageSubtitle;

  /// No description provided for @fieldLabelsTagLabel.
  ///
  /// In ar, this message translates to:
  /// **'وسم / رقم التعريف'**
  String get fieldLabelsTagLabel;

  /// No description provided for @fieldLabelsTagColorLabel.
  ///
  /// In ar, this message translates to:
  /// **'لون الوسم'**
  String get fieldLabelsTagColorLabel;

  /// No description provided for @fieldLabelsAnimalColorLabel.
  ///
  /// In ar, this message translates to:
  /// **'لون الحيوان'**
  String get fieldLabelsAnimalColorLabel;

  /// No description provided for @fieldLabelsBreedLabel.
  ///
  /// In ar, this message translates to:
  /// **'السلالة'**
  String get fieldLabelsBreedLabel;

  /// No description provided for @fieldLabelsPenLabel.
  ///
  /// In ar, this message translates to:
  /// **'الحظيرة'**
  String get fieldLabelsPenLabel;

  /// No description provided for @fieldLabelsArPlaceholder.
  ///
  /// In ar, this message translates to:
  /// **'اكتب التسمية بالعربية'**
  String get fieldLabelsArPlaceholder;

  /// No description provided for @fieldLabelsEnPlaceholder.
  ///
  /// In ar, this message translates to:
  /// **'English label'**
  String get fieldLabelsEnPlaceholder;

  /// No description provided for @fieldLabelsSaveBtn.
  ///
  /// In ar, this message translates to:
  /// **'حفظ التسميات'**
  String get fieldLabelsSaveBtn;

  /// No description provided for @fieldLabelsResetAll.
  ///
  /// In ar, this message translates to:
  /// **'إعادة الافتراضي'**
  String get fieldLabelsResetAll;

  /// No description provided for @fieldLabelsSaved.
  ///
  /// In ar, this message translates to:
  /// **'تم الحفظ'**
  String get fieldLabelsSaved;

  /// No description provided for @pensTitle.
  ///
  /// In ar, this message translates to:
  /// **'الحظائر'**
  String get pensTitle;

  /// No description provided for @pensEmpty.
  ///
  /// In ar, this message translates to:
  /// **'لا توجد حظائر بعد'**
  String get pensEmpty;

  /// No description provided for @pensAddBtn.
  ///
  /// In ar, this message translates to:
  /// **'إضافة حظيرة'**
  String get pensAddBtn;

  /// No description provided for @pensAddTitle.
  ///
  /// In ar, this message translates to:
  /// **'إضافة حظيرة'**
  String get pensAddTitle;

  /// No description provided for @pensEditTitle.
  ///
  /// In ar, this message translates to:
  /// **'تعديل الحظيرة'**
  String get pensEditTitle;

  /// No description provided for @pensNameLabel.
  ///
  /// In ar, this message translates to:
  /// **'اسم الحظيرة'**
  String get pensNameLabel;

  /// No description provided for @pensNameHint.
  ///
  /// In ar, this message translates to:
  /// **'مثال: حظيرة الأغنام الكبار'**
  String get pensNameHint;

  /// No description provided for @pensNameRequired.
  ///
  /// In ar, this message translates to:
  /// **'مطلوب'**
  String get pensNameRequired;

  /// No description provided for @pensDeleteTitle.
  ///
  /// In ar, this message translates to:
  /// **'حذف الحظيرة؟'**
  String get pensDeleteTitle;

  /// No description provided for @pensDeleteMsg.
  ///
  /// In ar, this message translates to:
  /// **'سيتم إزالة هذه الحظيرة. لن تتأثر الحيوانات المرتبطة بها.'**
  String get pensDeleteMsg;

  /// No description provided for @notificationSettingsTitle.
  ///
  /// In ar, this message translates to:
  /// **'إعدادات الإشعارات'**
  String get notificationSettingsTitle;

  /// No description provided for @notificationVaccination.
  ///
  /// In ar, this message translates to:
  /// **'تذكيرات التطعيم'**
  String get notificationVaccination;

  /// No description provided for @notificationVaccinationDesc.
  ///
  /// In ar, this message translates to:
  /// **'تنبيه قبل 3 أيام من موعد التطعيم'**
  String get notificationVaccinationDesc;

  /// No description provided for @notificationDeworming.
  ///
  /// In ar, this message translates to:
  /// **'تذكيرات التطفيل'**
  String get notificationDeworming;

  /// No description provided for @notificationDewormingDesc.
  ///
  /// In ar, this message translates to:
  /// **'تنبيه قبل 3 أيام من موعد التطفيل'**
  String get notificationDewormingDesc;

  /// No description provided for @notificationBirth.
  ///
  /// In ar, this message translates to:
  /// **'تذكيرات الولادة'**
  String get notificationBirth;

  /// No description provided for @notificationBirthDesc.
  ///
  /// In ar, this message translates to:
  /// **'تنبيه قبل 14 يومًا من الولادة المتوقعة'**
  String get notificationBirthDesc;

  /// No description provided for @notificationWeaning.
  ///
  /// In ar, this message translates to:
  /// **'تذكيرات الفطام'**
  String get notificationWeaning;

  /// No description provided for @notificationWeaningDesc.
  ///
  /// In ar, this message translates to:
  /// **'تنبيه عند اقتراب نافذة الفطام'**
  String get notificationWeaningDesc;

  /// No description provided for @dashboardShortcutBahm.
  ///
  /// In ar, this message translates to:
  /// **'البهم'**
  String get dashboardShortcutBahm;

  /// No description provided for @dashboardShortcutVaccination.
  ///
  /// In ar, this message translates to:
  /// **'التطعيم'**
  String get dashboardShortcutVaccination;

  /// No description provided for @dashboardShortcutNearBirth.
  ///
  /// In ar, this message translates to:
  /// **'قريب الولادة'**
  String get dashboardShortcutNearBirth;

  /// No description provided for @dashboardShortcutMales.
  ///
  /// In ar, this message translates to:
  /// **'الذكور'**
  String get dashboardShortcutMales;

  /// No description provided for @dashboardShortcutFemales.
  ///
  /// In ar, this message translates to:
  /// **'الإناث'**
  String get dashboardShortcutFemales;

  /// No description provided for @dashboardShortcutBreeding.
  ///
  /// In ar, this message translates to:
  /// **'المقرعات'**
  String get dashboardShortcutBreeding;

  /// No description provided for @dashboardShortcutDeceased.
  ///
  /// In ar, this message translates to:
  /// **'النفوق'**
  String get dashboardShortcutDeceased;

  /// No description provided for @dashboardShortcutFattening.
  ///
  /// In ar, this message translates to:
  /// **'تسمين'**
  String get dashboardShortcutFattening;

  /// No description provided for @dashboardShortcutCheckups.
  ///
  /// In ar, this message translates to:
  /// **'الفحوصات'**
  String get dashboardShortcutCheckups;

  /// No description provided for @dashboardShortcutUdhiya.
  ///
  /// In ar, this message translates to:
  /// **'الأضحية'**
  String get dashboardShortcutUdhiya;

  /// No description provided for @animalIdentity.
  ///
  /// In ar, this message translates to:
  /// **'{tag} {color}'**
  String animalIdentity(String tag, String color);

  /// No description provided for @pedigreeTitle.
  ///
  /// In ar, this message translates to:
  /// **'شجرة النسب'**
  String get pedigreeTitle;

  /// No description provided for @pedigreeViewBtn.
  ///
  /// In ar, this message translates to:
  /// **'شجرة النسب'**
  String get pedigreeViewBtn;

  /// No description provided for @pedigreeSubject.
  ///
  /// In ar, this message translates to:
  /// **'الحيوان'**
  String get pedigreeSubject;

  /// No description provided for @pedigreeParents.
  ///
  /// In ar, this message translates to:
  /// **'الوالدان'**
  String get pedigreeParents;

  /// No description provided for @pedigreeGrandparents.
  ///
  /// In ar, this message translates to:
  /// **'الأجداد'**
  String get pedigreeGrandparents;

  /// No description provided for @pedigreeUnknown.
  ///
  /// In ar, this message translates to:
  /// **'غير معروف'**
  String get pedigreeUnknown;

  /// No description provided for @pedigreeDam.
  ///
  /// In ar, this message translates to:
  /// **'الأم'**
  String get pedigreeDam;

  /// No description provided for @pedigreeSire.
  ///
  /// In ar, this message translates to:
  /// **'الأب'**
  String get pedigreeSire;

  /// No description provided for @pedigreeMaternalDam.
  ///
  /// In ar, this message translates to:
  /// **'أم الأم'**
  String get pedigreeMaternalDam;

  /// No description provided for @pedigreeMaternalSire.
  ///
  /// In ar, this message translates to:
  /// **'أب الأم'**
  String get pedigreeMaternalSire;

  /// No description provided for @pedigreePaternaldDam.
  ///
  /// In ar, this message translates to:
  /// **'أم الأب'**
  String get pedigreePaternaldDam;

  /// No description provided for @pedigreePaternaldSire.
  ///
  /// In ar, this message translates to:
  /// **'أب الأب'**
  String get pedigreePaternaldSire;

  /// No description provided for @customFieldsTitle.
  ///
  /// In ar, this message translates to:
  /// **'حقول مخصصة'**
  String get customFieldsTitle;

  /// No description provided for @customFieldsEmpty.
  ///
  /// In ar, this message translates to:
  /// **'لا توجد حقول مخصصة مضافة بعد'**
  String get customFieldsEmpty;

  /// No description provided for @customFieldsAddBtn.
  ///
  /// In ar, this message translates to:
  /// **'إضافة حقل'**
  String get customFieldsAddBtn;

  /// No description provided for @customFieldLabel.
  ///
  /// In ar, this message translates to:
  /// **'عنوان الحقل'**
  String get customFieldLabel;

  /// No description provided for @customFieldValue.
  ///
  /// In ar, this message translates to:
  /// **'القيمة'**
  String get customFieldValue;

  /// No description provided for @customFieldRequired.
  ///
  /// In ar, this message translates to:
  /// **'مطلوب'**
  String get customFieldRequired;

  /// No description provided for @customFieldOptional.
  ///
  /// In ar, this message translates to:
  /// **'اختياري'**
  String get customFieldOptional;

  /// No description provided for @customFieldTypeText.
  ///
  /// In ar, this message translates to:
  /// **'نص'**
  String get customFieldTypeText;

  /// No description provided for @customFieldTypeNumber.
  ///
  /// In ar, this message translates to:
  /// **'رقم'**
  String get customFieldTypeNumber;

  /// No description provided for @customFieldTypeSelect.
  ///
  /// In ar, this message translates to:
  /// **'قائمة'**
  String get customFieldTypeSelect;

  /// No description provided for @customFieldTypeBoolean.
  ///
  /// In ar, this message translates to:
  /// **'نعم/لا'**
  String get customFieldTypeBoolean;

  /// No description provided for @countryTemplateRequired.
  ///
  /// In ar, this message translates to:
  /// **'مطلوب حسب متطلبات بلدك'**
  String get countryTemplateRequired;

  /// No description provided for @healthOptionBirth.
  ///
  /// In ar, this message translates to:
  /// **'تسجيل ولادة'**
  String get healthOptionBirth;

  /// No description provided for @healthOptionBirthDesc.
  ///
  /// In ar, this message translates to:
  /// **'تسجيل نتيجة الولادة وعدد المواليد'**
  String get healthOptionBirthDesc;

  /// No description provided for @registerBirthTitle.
  ///
  /// In ar, this message translates to:
  /// **'تسجيل ولادة'**
  String get registerBirthTitle;

  /// No description provided for @registerBirthSelectMother.
  ///
  /// In ar, this message translates to:
  /// **'اختر الأم'**
  String get registerBirthSelectMother;

  /// No description provided for @registerBirthMotherLabel.
  ///
  /// In ar, this message translates to:
  /// **'الأم'**
  String get registerBirthMotherLabel;

  /// No description provided for @registerBirthDate.
  ///
  /// In ar, this message translates to:
  /// **'تاريخ الولادة'**
  String get registerBirthDate;

  /// No description provided for @registerBirthTotal.
  ///
  /// In ar, this message translates to:
  /// **'إجمالي المواليد'**
  String get registerBirthTotal;

  /// No description provided for @registerBirthMales.
  ///
  /// In ar, this message translates to:
  /// **'ذكور'**
  String get registerBirthMales;

  /// No description provided for @registerBirthFemales.
  ///
  /// In ar, this message translates to:
  /// **'إناث'**
  String get registerBirthFemales;

  /// No description provided for @registerBirthSire.
  ///
  /// In ar, this message translates to:
  /// **'الأب (اختياري)'**
  String get registerBirthSire;

  /// No description provided for @registerBirthSireUnknown.
  ///
  /// In ar, this message translates to:
  /// **'غير معروف'**
  String get registerBirthSireUnknown;

  /// No description provided for @registerBirthSave.
  ///
  /// In ar, this message translates to:
  /// **'حفظ الولادة'**
  String get registerBirthSave;

  /// No description provided for @registerBirthDead.
  ///
  /// In ar, this message translates to:
  /// **'عدد النافق'**
  String get registerBirthDead;

  /// No description provided for @registerBirthWeanFrom.
  ///
  /// In ar, this message translates to:
  /// **'الفطام من عمر (يوم)'**
  String get registerBirthWeanFrom;

  /// No description provided for @registerBirthWeanTo.
  ///
  /// In ar, this message translates to:
  /// **'إلى عمر (يوم)'**
  String get registerBirthWeanTo;

  /// No description provided for @registerBirthNext.
  ///
  /// In ar, this message translates to:
  /// **'التالي'**
  String get registerBirthNext;

  /// No description provided for @registerBirthOffspringOf.
  ///
  /// In ar, this message translates to:
  /// **'مولود {current} من {total}'**
  String registerBirthOffspringOf(int current, int total);

  /// No description provided for @registerBirthOffspringGender.
  ///
  /// In ar, this message translates to:
  /// **'الجنس'**
  String get registerBirthOffspringGender;

  /// No description provided for @registerBirthOffspringColor.
  ///
  /// In ar, this message translates to:
  /// **'اللون'**
  String get registerBirthOffspringColor;

  /// No description provided for @registerBirthOffspringTagNumber.
  ///
  /// In ar, this message translates to:
  /// **'رقم العلامة'**
  String get registerBirthOffspringTagNumber;

  /// No description provided for @registerBirthOffspringPen.
  ///
  /// In ar, this message translates to:
  /// **'الحظيرة (اختياري)'**
  String get registerBirthOffspringPen;

  /// No description provided for @registerBirthSuccessTitle.
  ///
  /// In ar, this message translates to:
  /// **'تم تسجيل الولادة'**
  String get registerBirthSuccessTitle;

  /// No description provided for @registerBirthSuccessBody.
  ///
  /// In ar, this message translates to:
  /// **'ولادة {dam} — {count} مولود مسجل'**
  String registerBirthSuccessBody(String dam, int count);

  /// No description provided for @animalPickerTitle.
  ///
  /// In ar, this message translates to:
  /// **'اختر الحيوانات'**
  String get animalPickerTitle;

  /// No description provided for @animalPickerSearch.
  ///
  /// In ar, this message translates to:
  /// **'ابحث بالرقم أو اللون…'**
  String get animalPickerSearch;

  /// No description provided for @animalPickerNone.
  ///
  /// In ar, this message translates to:
  /// **'لا توجد حيوانات'**
  String get animalPickerNone;

  /// No description provided for @animalPickerApply.
  ///
  /// In ar, this message translates to:
  /// **'تطبيق ({count})'**
  String animalPickerApply(int count);

  /// No description provided for @animalPickerSelectedLabel.
  ///
  /// In ar, this message translates to:
  /// **'{count} حيوان مختار'**
  String animalPickerSelectedLabel(int count);

  /// No description provided for @animalPickerTap.
  ///
  /// In ar, this message translates to:
  /// **'اضغط لاختيار الحيوانات'**
  String get animalPickerTap;

  /// No description provided for @btnClear.
  ///
  /// In ar, this message translates to:
  /// **'مسح'**
  String get btnClear;

  /// No description provided for @healthSavedForAnimals.
  ///
  /// In ar, this message translates to:
  /// **'تم الحفظ لـ {count} حيوان'**
  String healthSavedForAnimals(int count);
}

class _AppLDelegate extends LocalizationsDelegate<AppL> {
  const _AppLDelegate();

  @override
  Future<AppL> load(Locale locale) {
    return SynchronousFuture<AppL>(lookupAppL(locale));
  }

  @override
  bool isSupported(Locale locale) =>
      <String>['ar', 'en'].contains(locale.languageCode);

  @override
  bool shouldReload(_AppLDelegate old) => false;
}

AppL lookupAppL(Locale locale) {
  // Lookup logic when only language code is specified.
  switch (locale.languageCode) {
    case 'ar':
      return AppLAr();
    case 'en':
      return AppLEn();
  }

  throw FlutterError(
    'AppL.delegate failed to load unsupported locale "$locale". This is likely '
    'an issue with the localizations generation tool. Please file an issue '
    'on GitHub with a reproducible sample app and the gen-l10n configuration '
    'that was used.',
  );
}
