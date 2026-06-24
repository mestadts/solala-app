// ignore: unused_import
import 'package:intl/intl.dart' as intl;
import 'app_localizations.dart';

// ignore_for_file: type=lint

/// The translations for Arabic (`ar`).
class AppLAr extends AppL {
  AppLAr([String locale = 'ar']) : super(locale);

  @override
  String get appTitle => 'سلالة';

  @override
  String get appTagline => 'ثروتك الحيوانية، تُدار بذكاء';

  @override
  String get btnContinue => 'متابعة';

  @override
  String get btnSave => 'حفظ';

  @override
  String get btnCancel => 'إلغاء';

  @override
  String get btnDelete => 'حذف';

  @override
  String get btnSkip => 'تخطي';

  @override
  String get btnNext => 'التالي';

  @override
  String get btnBack => 'رجوع';

  @override
  String get btnClose => 'إغلاق';

  @override
  String get btnCopyId => 'نسخ الرقم';

  @override
  String get navHome => 'الرئيسية';

  @override
  String get navAnimals => 'الحيوانات';

  @override
  String get navHealth => 'الصحة';

  @override
  String get navSettings => 'الإعدادات';

  @override
  String get loginTitle => 'مرحبًا بعودتك';

  @override
  String get loginSubtitle => 'تسجيل الدخول إلى حساب سلالة';

  @override
  String get loginPhone => 'رقم الهاتف';

  @override
  String get loginPhoneHint => '5XX XXX XXX (بدون صفر)';

  @override
  String get loginPhoneValidation => 'يرجى إدخال رقم الهاتف';

  @override
  String get loginPassword => 'كلمة المرور';

  @override
  String get loginPasswordHint => 'أدخل كلمة المرور';

  @override
  String get loginPasswordValidation => 'يرجى إدخال كلمة المرور';

  @override
  String get loginForgotPassword => 'نسيت كلمة المرور؟';

  @override
  String get loginBtn => 'تسجيل الدخول';

  @override
  String get loginOrWith => 'أو تابع باستخدام';

  @override
  String get loginNoAccount => 'ليس لديك حساب؟ ';

  @override
  String get loginRegisterLink => 'إنشاء حساب';

  @override
  String get selectCountry => 'اختر الدولة';

  @override
  String get countrySearchHint => 'ابحث عن الدولة';

  @override
  String get otpTitle => 'التحقق من الرقم';

  @override
  String get otpSubtitle => 'أدخل الرمز المكوّن من 6 أرقام المُرسَل إلى ';

  @override
  String get otpYourNumber => 'رقمك';

  @override
  String otpResendIn(int seconds) {
    return 'إعادة الإرسال بعد $seconds ثانية';
  }

  @override
  String get otpResend => 'إعادة إرسال الرمز';

  @override
  String get otpVerifyBtn => 'تحقق وتابع';

  @override
  String get forgotTitle => 'نسيت كلمة المرور؟';

  @override
  String get forgotSubtitle =>
      'أدخل رقم جوالك وسنرسل لك رمز التحقق لإعادة تعيين كلمة المرور.';

  @override
  String get forgotSendBtn => 'إرسال رمز التحقق';

  @override
  String get forgotRemember => 'تتذكر كلمة المرور؟ ';

  @override
  String get forgotSignInLink => 'تسجيل الدخول';

  @override
  String get resetTitle => 'إعادة تعيين كلمة المرور';

  @override
  String get resetSubtitle => 'أدخل كلمة مرور جديدة لحسابك.';

  @override
  String get resetNewPassword => 'كلمة المرور الجديدة';

  @override
  String get resetNewPasswordHint => '8 أحرف على الأقل';

  @override
  String get resetPasswordMinLength =>
      'يجب أن تتكون كلمة المرور من 8 أحرف على الأقل';

  @override
  String get resetConfirmPassword => 'تأكيد كلمة المرور الجديدة';

  @override
  String get resetConfirmHint => 'أعد إدخال كلمة المرور الجديدة';

  @override
  String get resetPasswordMismatch => 'كلمتا المرور غير متطابقتين';

  @override
  String get resetBtn => 'إعادة التعيين';

  @override
  String get resetSuccess => 'تمت إعادة تعيين كلمة المرور. يرجى تسجيل الدخول.';

  @override
  String get registerStep0Title => 'إنشاء حساب';

  @override
  String get registerStep0Subtitle => 'انضم إلى سلالة لإدارة ثروتك الحيوانية';

  @override
  String get registerSendOtp => 'إرسال الرمز';

  @override
  String get registerHaveAccount => 'لديك حساب بالفعل؟ ';

  @override
  String get registerSignInLink => 'تسجيل الدخول';

  @override
  String get registerStep2Title => 'أكمل ملفك الشخصي';

  @override
  String get registerStep2Subtitle =>
      'أوشكت على الانتهاء! أدخل اسمك وكلمة المرور.';

  @override
  String get registerFullName => 'الاسم الكامل';

  @override
  String get registerFullNameHint => 'أحمد الراشدي';

  @override
  String get registerFullNameValidation => 'يرجى إدخال اسمك الكامل';

  @override
  String get registerPasswordHint => '8 أحرف على الأقل';

  @override
  String get registerConfirmPassword => 'تأكيد كلمة المرور';

  @override
  String get registerConfirmHint => 'أعد إدخال كلمة المرور';

  @override
  String get registerCreateBtn => 'إنشاء الحساب';

  @override
  String get onboardingSlide1Title => 'تتبّع كل حيوان';

  @override
  String get onboardingSlide1Desc =>
      'أدر قطيعك بالكامل في مكان واحد. خصّص رقمًا فريدًا لكل حيوان ولا تفقد أثره أبدًا.';

  @override
  String get onboardingSlide2Title => 'متابعة صحة قطيعك';

  @override
  String get onboardingSlide2Desc =>
      'سجّل التطعيمات والعلاجات والأوزان. احصل على تذكيرات قبل موعد التطعيمات.';

  @override
  String get onboardingSlide3Title => 'مسح وتعريف فوري';

  @override
  String get onboardingSlide3Desc =>
      'كل حيوان يحصل على رمز QR. امسحه في الحقل لعرض الملف الكامل فورًا.';

  @override
  String get onboardingSlide4Title => 'سجلات ملكية آمنة';

  @override
  String get onboardingSlide4Desc =>
      'انقل الملكية مع سجل كامل غير قابل للتغيير. كل معاملة دائمة ومحمية.';

  @override
  String get onboardingGetStarted => 'ابدأ الآن';

  @override
  String get countryTitle => 'اختر الدولة';

  @override
  String get countrySubtitle => 'أين تقع مزرعتك؟';

  @override
  String get countrySearch => 'ابحث عن الدولة…';

  @override
  String get orgTypeTitle => 'نوع المنشأة';

  @override
  String get orgTypeSubtitle => 'اختر النوع الذي يصف إدارتك للثروة الحيوانية.';

  @override
  String get orgTypeIndividual => 'فردي / شخصي';

  @override
  String get orgTypeIndividualDesc =>
      'تُدير حيواناتك الخاصة. مثالي للمربّين وأصحاب القطعان الصغيرة.';

  @override
  String get orgTypeSmallFarm => 'مزرعة صغيرة';

  @override
  String get orgTypeSmallFarmDesc =>
      'مزرعة عائلية أو صغيرة بأنواع متعددة من الحيوانات.';

  @override
  String get orgTypeCommercial => 'مزرعة تجارية';

  @override
  String get orgTypeCommercialDesc =>
      'عملية واسعة النطاق مع عمال وتقارير متقدمة وتحويلات جماعية.';

  @override
  String get orgTypeGovt => 'حكومي / رقابي';

  @override
  String get orgTypeGovtDesc =>
      'جهة رسمية تشرف على تسجيل الثروة الحيوانية والامتثال.';

  @override
  String get orgSetupTitle => 'إعداد مزرعتك';

  @override
  String get orgSetupSubtitle => 'أخبرنا عن منشأتك لتخصيص سلالة لك.';

  @override
  String get orgSetupName => 'اسم المزرعة / المنشأة';

  @override
  String get orgSetupNameHint => 'مثال: مزرعة الراشدي';

  @override
  String get orgSetupNameValidation => 'يرجى إدخال اسم المزرعة';

  @override
  String get orgSetupLocation => 'الموقع / المدينة';

  @override
  String get orgSetupLocationHint => 'مثال: الرياض';

  @override
  String get orgSetupLocationValidation => 'يرجى إدخال موقع مزرعتك';

  @override
  String get orgSetupHerdSize => 'الحجم التقريبي للقطيع (اختياري)';

  @override
  String get orgSetupHerdSizeHint => 'مثال: 50';

  @override
  String get orgSetupFinish => 'إنهاء الإعداد';

  @override
  String get orgSetupLegal =>
      'بالمتابعة، فأنت توافق على شروط الخدمة وسياسة الخصوصية.';

  @override
  String get dashboardGreeting => 'صباح الخير،';

  @override
  String get dashboardDefaultFarmName => 'مزرعتي';

  @override
  String get dashboardUpcomingEvents => 'الأحداث القادمة';

  @override
  String get dashboardRecentActivity => 'النشاط الأخير';

  @override
  String get dashboardNoUpcoming => 'لا توجد أحداث قادمة';

  @override
  String get dashboardNoActivity => 'لا يوجد نشاط حديث';

  @override
  String get dashboardOverdue => 'متأخر';

  @override
  String get dashboardDue => 'مستحق';

  @override
  String get dashboardTotalAnimals => 'إجمالي الحيوانات';

  @override
  String get dashboardAddAnimal => 'إضافة حيوان';

  @override
  String get dashboardHerdOverview => 'نظرة عامة على القطيع';

  @override
  String get dashboardCategories => 'التصنيفات';

  @override
  String get dashboardSpeciesBreakdown => 'إحصائيات القطيع';

  @override
  String get dashboardSeeAll => 'عرض الكل';

  @override
  String get dashboardEventsThisWeek => 'أحداث هذا الأسبوع';

  @override
  String get animalsTitle => 'الحيوانات';

  @override
  String animalsTotal(int count) {
    return '$count إجمالي';
  }

  @override
  String get animalsAdd => 'إضافة';

  @override
  String get animalsSearch => 'ابحث بالاسم أو الرقم أو الوسم…';

  @override
  String get animalsFilterAll => 'الكل';

  @override
  String get animalsEmpty => 'لا توجد حيوانات بعد';

  @override
  String get animalsEmptyHint => 'اضغط + إضافة لتسجيل أول حيوان';

  @override
  String get animalsNoMatch => 'لا توجد حيوانات تطابق البحث';

  @override
  String get animalsNoMatchHint => 'جرّب اسمًا أو فلترًا آخر';

  @override
  String get addAnimalStep0Title => 'اختر النوع';

  @override
  String get addAnimalStep0Subtitle => 'ما نوع الحيوان الذي تسجّله؟';

  @override
  String get addAnimalStep1Title => 'المعلومات الأساسية';

  @override
  String get addAnimalStep1Subtitle =>
      'الاسم اختياري — يمكنك استخدام الرقم التعريفي بدلاً منه.';

  @override
  String get addAnimalNameLabel => 'اسم الحيوان (اختياري)';

  @override
  String get addAnimalNameHint => 'مثال: ليلى';

  @override
  String get addAnimalGenderLabel => 'الجنس';

  @override
  String get addAnimalDobLabel => 'تاريخ الميلاد (اختياري)';

  @override
  String get addAnimalDobHint => 'YYYY-MM-DD';

  @override
  String get addAnimalStep2Title => 'السلالة';

  @override
  String get addAnimalStep2Subtitle =>
      'السلالة حقل إلزامي — اختر من القائمة أو أضف سلالة جديدة.';

  @override
  String get addAnimalBreedLabel => 'السلالة';

  @override
  String get addAnimalBreedSkip => 'تخطي الآن';

  @override
  String get addAnimalStep3Title => 'اللون والوسم';

  @override
  String get addAnimalStep3Subtitle => 'لون موحّد ووسم رقمي للتعريف.';

  @override
  String get addAnimalColorLabel => 'لون الحيوان';

  @override
  String get addAnimalTagLabel => 'رقم الوسم (0–500)';

  @override
  String get addAnimalStep4Title => 'إضافة صورة';

  @override
  String get addAnimalStep4Subtitle => 'تساعد الصورة على تعريف الحيوان بسرعة.';

  @override
  String get addAnimalPhotoTap => 'اضغط لإضافة صورة\n(اختياري)';

  @override
  String get addAnimalChoosePhoto => 'اختر صورة';

  @override
  String get addAnimalSaveBtn => 'حفظ الحيوان';

  @override
  String get addAnimalSuccessTitle => 'تمّ تسجيل الحيوان!';

  @override
  String get addAnimalSuccessMsg =>
      'تمت إضافة الحيوان إلى القطيع.\nهذا هو رقمه التعريفي الفريد:';

  @override
  String get addAnimalSystemIdLabel => 'الرقم التعريفي';

  @override
  String get addAnimalIdPermanent => 'هذا الرقم دائم ولا يمكن تغييره';

  @override
  String get addAnimalBackToList => 'العودة إلى الحيوانات';

  @override
  String get addAnimalPurposeLabel => 'الغرض';

  @override
  String get addAnimalAgeClassLabel => 'السن';

  @override
  String get addAnimalAgeClassAuto => 'تلقائي من تاريخ الميلاد';

  @override
  String get addAnimalPenLabel => 'الحظيرة (اختياري)';

  @override
  String get addAnimalPenNone => 'بدون حظيرة';

  @override
  String get addAnimalWeightLabel => 'الوزن (كغ، اختياري)';

  @override
  String get addAnimalWeightHint => 'مثال: 45.5';

  @override
  String get addAnimalPriceLabel => 'السعر (ريال، اختياري)';

  @override
  String get addAnimalPriceHint => 'مثال: 1200';

  @override
  String get addAnimalPhotoCamera => 'التقاط صورة';

  @override
  String get addAnimalPhotoGallery => 'اختيار من المعرض';

  @override
  String get animalDuplicate => 'نسخ الحيوان';

  @override
  String get animalDuplicateHint =>
      'النسخ يملأ النموذج تلقائيًا — غيّر فقط ما يختلف';

  @override
  String get animalActionEdit => 'تعديل';

  @override
  String get animalActionSell => 'تسجيل كمباع';

  @override
  String get animalActionSlaughter => 'تسجيل كمذبوح';

  @override
  String get animalActionMarkDead => 'تسجيل كنافق';

  @override
  String get animalActionSlaughterConfirm => 'هل تريد تسجيل ذبح هذا الحيوان؟';

  @override
  String get animalActionDeadConfirm => 'هل تريد تسجيل نفوق هذا الحيوان؟';

  @override
  String get btnConfirm => 'تأكيد';

  @override
  String get animalDetailTabHealth => 'الصحة';

  @override
  String get animalDetailTabWeight => 'الوزن';

  @override
  String get animalDetailTabOwnership => 'الملكية';

  @override
  String get animalDetailTabBreeding => 'التكاثر';

  @override
  String get animalDetailNotFound => 'الحيوان غير موجود';

  @override
  String get animalDetailGender => 'الجنس';

  @override
  String get animalDetailBreed => 'السلالة';

  @override
  String get animalDetailDob => 'تاريخ الميلاد';

  @override
  String get animalDetailWeight => 'الوزن';

  @override
  String get animalDetailTag => 'الوسم: ';

  @override
  String get animalDetailCurrentOwner => 'المالك الحالي';

  @override
  String get animalDetailTransferOwnership => 'نقل الملكية';

  @override
  String get animalDetailTransferHistory => 'سجل الملكية';

  @override
  String get animalDetailNoTransfers => 'لا توجد عمليات نقل بعد';

  @override
  String get animalDetailNoHealth => 'لا توجد سجلات صحية بعد';

  @override
  String get animalDetailNoWeight => 'لا توجد سجلات وزن بعد';

  @override
  String get animalDetailOfficial => 'رسمي';

  @override
  String get animalDetailQrTitle => 'رمز QR';

  @override
  String animalDetailDeleteTitle(String name) {
    return 'حذف $name؟';
  }

  @override
  String animalDetailDeleteMsg(String name) {
    return 'سيتم إزالة $name نهائيًا من سجلاتك.';
  }

  @override
  String editAnimalTitle(String name) {
    return 'تعديل $name';
  }

  @override
  String get editAnimalCannotChange => '(لا يمكن تغييره)';

  @override
  String get editAnimalNameLabel => 'اسم الحيوان';

  @override
  String get editAnimalNameHint => 'مثال: ليلى';

  @override
  String get editAnimalNameValidation => 'الاسم مطلوب';

  @override
  String get editAnimalBreedLabel => 'السلالة';

  @override
  String get editAnimalBreedHint => 'مثال: نجدي';

  @override
  String get editAnimalGenderLabel => 'الجنس';

  @override
  String get editAnimalDobLabel => 'تاريخ الميلاد';

  @override
  String get editAnimalWeightLabel => 'الوزن الحالي (كغ)';

  @override
  String get editAnimalWeightHint => 'مثال: 45.5';

  @override
  String get editAnimalTagLabel => 'وسم المربّي';

  @override
  String get editAnimalTagHint => 'مثال: RED-001';

  @override
  String get editAnimalStatusLabel => 'الحالة';

  @override
  String get editAnimalSaveBtn => 'حفظ التعديلات';

  @override
  String get editAnimalNotFound => 'الحيوان غير موجود';

  @override
  String get genderMale => 'ذكر';

  @override
  String get genderFemale => 'أنثى';

  @override
  String get qrScanTitle => 'مسح رمز QR';

  @override
  String get qrScanInstruction => 'وجّه الكاميرا نحو رمز QR الخاص بـ سلالة';

  @override
  String get qrScanDemo => 'عرض تجريبي: اختر حيوانًا';

  @override
  String get qrScanDemoSubtitle => 'اختر حيوانًا لمحاكاة المسح';

  @override
  String get healthTitle => 'الصحة';

  @override
  String get healthUpcomingEvents => 'الأحداث القادمة';

  @override
  String get healthRecentRecords => 'السجلات الأخيرة';

  @override
  String get healthNoUpcoming => 'لا توجد أحداث قادمة';

  @override
  String get healthNoRecords => 'لا توجد سجلات صحية بعد';

  @override
  String get healthAddRecord => 'إضافة سجل';

  @override
  String get healthDue => 'مستحق';

  @override
  String get healthOverdue => 'متأخر';

  @override
  String get healthOptionVaccination => 'تطعيم';

  @override
  String get healthOptionVaccinationDesc =>
      'تسجيل لقاح مع تاريخ الاستحقاق التالي';

  @override
  String get healthOptionTreatment => 'علاج';

  @override
  String get healthOptionTreatmentDesc => 'تسجيل علاج طبي أو فحص';

  @override
  String get healthOptionWeight => 'وزن';

  @override
  String get healthOptionWeightDesc => 'تسجيل قياس وزن';

  @override
  String get healthOptionPregnancy => 'حمل';

  @override
  String get healthOptionPregnancyDesc =>
      'تسجيل تاريخ التلقيح والولادة المتوقعة';

  @override
  String get healthOptionDeworming => 'تطفيل';

  @override
  String get healthOptionDewormingDesc =>
      'تسجيل علاج التطفيل مع تاريخ الاستحقاق التالي';

  @override
  String get addVaccinationTitle => 'إضافة تطعيم';

  @override
  String get addVaccinationAnimal => 'الحيوان';

  @override
  String get addVaccinationSelectAnimal => 'اختر الحيوان';

  @override
  String get addVaccinationVaccineName => 'اسم اللقاح';

  @override
  String get addVaccinationVaccineHint => 'مثال: لقاح الحمى القلاعية';

  @override
  String get addVaccinationRequired => 'مطلوب';

  @override
  String get addVaccinationDateGiven => 'تاريخ التطعيم';

  @override
  String get addVaccinationNextDue => 'تاريخ الاستحقاق التالي (اختياري)';

  @override
  String get addVaccinationVet => 'الطبيب البيطري';

  @override
  String get addVaccinationVetHint => 'مثال: د. خالد حسن';

  @override
  String get addVaccinationNotes => 'ملاحظات (اختياري)';

  @override
  String get addVaccinationNotesHint => 'أي ملاحظات إضافية...';

  @override
  String get addVaccinationSaveBtn => 'حفظ التطعيم';

  @override
  String get addVaccinationSelectFirst => 'يرجى اختيار حيوان أولاً';

  @override
  String get dateHint => 'YYYY-MM-DD';

  @override
  String get addTreatmentTitle => 'إضافة علاج';

  @override
  String get addTreatmentType => 'نوع العلاج';

  @override
  String get addTreatmentTypeHint => 'مثال: علاج جلدي، مضاد حيوي';

  @override
  String get addTreatmentDate => 'التاريخ';

  @override
  String get addTreatmentMeds => 'الأدوية (اختياري)';

  @override
  String get addTreatmentMedsHint => 'مثال: أوكسيتتراسايكلين 20مج';

  @override
  String get addTreatmentVet => 'الطبيب البيطري';

  @override
  String get addTreatmentVetHint => 'مثال: د. سارة المطيري';

  @override
  String get addTreatmentNotes => 'ملاحظات (اختياري)';

  @override
  String get addTreatmentNotesHint => 'الملاحظات، المتابعة...';

  @override
  String get addTreatmentSaveBtn => 'حفظ العلاج';

  @override
  String get addTreatmentSelectFirst => 'يرجى اختيار حيوان أولاً';

  @override
  String get addWeightTitle => 'تسجيل الوزن';

  @override
  String get addWeightLabel => 'الوزن';

  @override
  String get addWeightHint => 'مثال: 45.5';

  @override
  String get addWeightRequired => 'مطلوب';

  @override
  String get addWeightInvalid => 'رقم غير صحيح';

  @override
  String get addWeightUnit => 'الوحدة';

  @override
  String get addWeightDateLabel => 'تاريخ القياس';

  @override
  String get addWeightOfficial => 'قياس رسمي';

  @override
  String get addWeightOfficialDesc => 'موثّق من بيطري أو ميزان رسمي';

  @override
  String get addWeightSaveBtn => 'حفظ الوزن';

  @override
  String get addWeightSelectFirst => 'يرجى اختيار حيوان أولاً';

  @override
  String get addPregnancyTitle => 'تسجيل الحمل';

  @override
  String get addPregnancyInfo =>
      'فترة الحمل: الأغنام/الماعز ~5 أشهر · الأبقار ~9 أشهر · الإبل ~13 شهرًا · الخيول ~11 شهرًا';

  @override
  String get addPregnancyDamLabel => 'الأم (الأم المرضعة)';

  @override
  String get addPregnancyDamHint => 'اختر أنثى';

  @override
  String get addPregnancyMatingDate => 'تاريخ التلقيح';

  @override
  String get addPregnancyExpected => 'الولادة المتوقعة (محسوبة تلقائيًا)';

  @override
  String get addPregnancySireLabel => 'الفحل (اختياري)';

  @override
  String get addPregnancySireHint => 'اسم أو رقم الفحل';

  @override
  String get addPregnancyNotes => 'ملاحظات (اختياري)';

  @override
  String get addPregnancyNotesHint => 'أي ملاحظات إضافية';

  @override
  String get addPregnancySaveBtn => 'حفظ سجل الحمل';

  @override
  String get addDewormingTitle => 'تسجيل التطفيل';

  @override
  String get addDewormingAnimal => 'الحيوان';

  @override
  String get addDewormingSelectAnimal => 'اختر الحيوان';

  @override
  String get addDewormingProduct => 'المنتج';

  @override
  String get addDewormingDateGiven => 'تاريخ العلاج';

  @override
  String get addDewormingNextDue => 'تاريخ الاستحقاق التالي (تلقائي: +3 أشهر)';

  @override
  String get addDewormingDose => 'الجرعة (اختياري)';

  @override
  String get addDewormingDoseHint => 'مثال: 5 مل، قرصان';

  @override
  String get addDewormingNotes => 'ملاحظات (اختياري)';

  @override
  String get addDewormingNotesHint => 'أي ملاحظات إضافية';

  @override
  String get addDewormingSaveBtn => 'حفظ سجل التطفيل';

  @override
  String get healthHistoryWeightTrend => 'اتجاه الوزن';

  @override
  String get healthHistoryTimeline => 'الجدول الزمني الصحي';

  @override
  String get healthHistoryNoRecords => 'لا توجد سجلات صحية لهذا الحيوان';

  @override
  String get breedingAddRecord => 'إضافة سجل تكاثر';

  @override
  String get breedingRecordsTitle => 'سجلات التكاثر';

  @override
  String get breedingNoRecords => 'لا توجد سجلات تكاثر بعد';

  @override
  String get breedingNoRecordsHint => 'سجّل روابط الأم والأب ونتائج الولادة';

  @override
  String get breedingDam => '♀ الأم';

  @override
  String get breedingSire => '♂ الأب';

  @override
  String get breedingUnknown => 'مجهول';

  @override
  String breedingOffspringInfo(int born, int surviving) {
    return '$born مولود، $surviving ناجٍ';
  }

  @override
  String get breedingWizardStep0Title => 'تأكيد الأم';

  @override
  String get breedingWizardStep0Subtitle =>
      'سيتم تسجيل التكاثر للحيوان التالي.';

  @override
  String get breedingWizardStep0ConfirmBtn => 'تأكيد — متابعة';

  @override
  String get breedingWizardUnnamed => 'بدون اسم';

  @override
  String get breedingWizardFemale => 'أنثى';

  @override
  String get breedingWizardStep1Title => 'اختر الفحل (الأب)';

  @override
  String get breedingWizardStep1Subtitle => 'اختر من قطيعك أو علّمه كمجهول.';

  @override
  String get breedingWizardSireUnknown => 'الفحل مجهول / خارجي';

  @override
  String get breedingWizardSelectMale => 'اختر من الذكور';

  @override
  String get breedingWizardSelectMaleHint => 'اختر حيوانًا ذكرًا';

  @override
  String get breedingWizardOrManual => 'أو أدخل الاسم يدويًا';

  @override
  String get breedingWizardSireHint => 'اسم الفحل / الرقم التعريفي (اختياري)';

  @override
  String get breedingWizardStep2Title => 'التلقيح والولادة المتوقعة';

  @override
  String get breedingWizardStep2Subtitle =>
      'تُحسب الولادة المتوقعة تلقائيًا حسب النوع.';

  @override
  String get breedingWizardMatingDate => 'تاريخ التلقيح';

  @override
  String get breedingWizardExpectedDelivery =>
      'الولادة المتوقعة (محسوبة تلقائيًا)';

  @override
  String get breedingWizardStep3Title => 'نتيجة الولادة';

  @override
  String get breedingWizardStep3Subtitle => 'سجّل نتائج الولادة.';

  @override
  String get breedingWizardTotalOffspring => 'إجمالي المواليد';

  @override
  String get breedingWizardSurviving => 'الناجون';

  @override
  String get breedingWizardMalesBorn => 'الذكور المولودون';

  @override
  String get breedingWizardFemalesBorn => 'الإناث المولودات';

  @override
  String get breedingWizardNotes => 'ملاحظات (اختياري)';

  @override
  String get breedingWizardNotesHint => 'مثال: توأم، كلاهما بصحة جيدة...';

  @override
  String get breedingWizardStep4Title => 'مراجعة وتأكيد';

  @override
  String get breedingWizardStep4Subtitle =>
      'يرجى المراجعة قبل الحفظ. هذا السجل دائم.';

  @override
  String get breedingWizardMother => 'الأم';

  @override
  String get breedingWizardFather => 'الأب';

  @override
  String get breedingWizardGenderSplit => 'توزيع الجنس';

  @override
  String get breedingWizardSaveBtn => 'حفظ سجل التكاثر';

  @override
  String stepLabel(int step, int total) {
    return 'خطوة $step من $total';
  }

  @override
  String get transferTitle => 'نقل الملكية';

  @override
  String get transferTypeTitle => 'نوع النقل';

  @override
  String get transferTypeSubtitle => 'كيف يتم نقل هذا الحيوان؟';

  @override
  String get transferTypeSale => 'بيع';

  @override
  String get transferTypeSaleDesc => 'نقل بمقابل مادي';

  @override
  String get transferTypeGift => 'هبة';

  @override
  String get transferTypeGiftDesc => 'نقل بدون مقابل';

  @override
  String get transferTypeInternal => 'داخلي';

  @override
  String get transferTypeInternalDesc => 'نقل داخل المنشأة';

  @override
  String get transferPriceTitle => 'سعر البيع';

  @override
  String get transferPriceSubtitle => 'أدخل السعر المتفق عليه';

  @override
  String get transferPriceLabel => 'السعر';

  @override
  String get transferPriceHint => 'مثال: 5000';

  @override
  String get transferCurrencyLabel => 'العملة';

  @override
  String get transferNewOwnerTitle => 'المالك الجديد';

  @override
  String get transferNewOwnerSubtitle =>
      'ابحث برقم الجوال أو اختر من جهات الاتصال';

  @override
  String get transferPhoneLabel => 'رقم الجوال';

  @override
  String get transferPhoneHint => '+966 5XX XXX XXXX';

  @override
  String get transferPickContact => 'اختيار من جهات الاتصال';

  @override
  String get orLabel => 'أو';

  @override
  String get permissionContactsDenied => 'لم يتم منح إذن جهات الاتصال';

  @override
  String get transferOrPick => 'أو اختر من جهات الاتصال التجريبية:';

  @override
  String get transferDocTitle => 'إرفاق وثيقة';

  @override
  String get transferDocSubtitle =>
      'اختياري: أرفق اتفاقية البيع أو شهادة النقل';

  @override
  String get transferDocTap => 'اضغط لإرفاق وثيقة';

  @override
  String get transferDocAttached => 'وثيقة مرفقة';

  @override
  String get transferDocTypes => 'PDF، JPG، أو PNG';

  @override
  String get transferDocSkip => 'متابعة بدون وثيقة';

  @override
  String get transferReviewTitle => 'مراجعة النقل';

  @override
  String get transferReviewSubtitle =>
      'يرجى المراجعة قبل التأكيد. هذا الإجراء لا يمكن التراجع عنه.';

  @override
  String get transferAnimalLabel => 'الحيوان';

  @override
  String get transferTypeLabel => 'نوع النقل';

  @override
  String get transferFromLabel => 'من';

  @override
  String get transferToLabel => 'إلى';

  @override
  String get transferPriceReview => 'السعر';

  @override
  String get transferDocLabel => 'الوثيقة';

  @override
  String get transferDocAttachedVal => 'مرفقة';

  @override
  String get transferDocNone => 'لا يوجد';

  @override
  String get transferDateLabel => 'التاريخ';

  @override
  String get transferWarning =>
      'هذا النقل دائم ولا يمكن التراجع عنه. سيتم حفظ السجل بشكل دائم.';

  @override
  String get transferConfirmBtn => 'تأكيد النقل';

  @override
  String get settingsTitle => 'الإعدادات';

  @override
  String get settingsSectionOrg => 'المنشأة';

  @override
  String get settingsOrgSettings => 'إعدادات المنشأة';

  @override
  String get settingsWorkerMgmt => 'إدارة العمال';

  @override
  String get settingsWorkerMgmtDesc => 'إدارة أعضاء الفريق والأدوار';

  @override
  String get settingsSectionData => 'البيانات';

  @override
  String get settingsImport => 'استيراد الحيوانات';

  @override
  String get settingsImportDesc => 'استيراد من ملف CSV أو Excel';

  @override
  String get settingsImportBadge => 'جديد';

  @override
  String get settingsExport => 'تصدير البيانات';

  @override
  String get settingsExportDesc => 'تصدير قائمة الحيوانات إلى CSV';

  @override
  String get settingsSectionPref => 'التفضيلات';

  @override
  String get settingsNotifications => 'الإشعارات';

  @override
  String get settingsNotificationsDesc => 'تذكيرات التطعيم والتنبيهات';

  @override
  String get settingsLanguage => 'اللغة';

  @override
  String get settingsSectionAccount => 'الحساب';

  @override
  String get settingsHelp => 'المساعدة والدعم';

  @override
  String get settingsHelpDesc => 'الأسئلة الشائعة والتواصل';

  @override
  String get settingsLogout => 'تسجيل الخروج';

  @override
  String get settingsLogoutDesc => 'تسجيل الخروج من حسابك';

  @override
  String get settingsLogoutTitle => 'تسجيل الخروج؟';

  @override
  String get settingsLogoutMsg =>
      'ستحتاج إلى تسجيل الدخول مجددًا للوصول إلى قطيعك.';

  @override
  String get profileEditTitle => 'تعديل الملف الشخصي';

  @override
  String get profileFullName => 'الاسم الكامل';

  @override
  String get profilePhone => 'رقم الجوال';

  @override
  String get profileSaveBtn => 'حفظ التعديلات';

  @override
  String get profileUnnamed => 'مستخدم';

  @override
  String get roleOwner => 'مالك';

  @override
  String get settingsOrgSettingsDesc => 'إعدادات المنشأة';

  @override
  String get orgSettingsTitle => 'إعدادات المنشأة';

  @override
  String get orgSettingsNameLabel => 'اسم المزرعة / المنشأة';

  @override
  String get orgSettingsNameRequired => 'مطلوب';

  @override
  String get orgSettingsTypeLabel => 'نوع المنشأة';

  @override
  String get orgSettingsCountryLabel => 'الدولة';

  @override
  String get orgSettingsSaveBtn => 'حفظ التعديلات';

  @override
  String get orgTypeOptionIndividual => 'فردي';

  @override
  String get orgTypeOptionSmall => 'مزرعة صغيرة';

  @override
  String get orgTypeOptionCommercial => 'مزرعة تجارية';

  @override
  String get orgTypeOptionGovt => 'حكومي';

  @override
  String get workersTitle => 'العمال';

  @override
  String workersCount(int count) {
    return '$count عضو في الفريق';
  }

  @override
  String get workersInviteBtn => 'دعوة عامل';

  @override
  String get workersRoleWorker => 'عامل';

  @override
  String get workersRoleSupervisor => 'مشرف';

  @override
  String get workersInviteTitle => 'دعوة عامل';

  @override
  String get workersInviteNameLabel => 'الاسم';

  @override
  String get workersInviteNameHint => 'مثال: فيصل الدوسري';

  @override
  String get workersInvitePhoneLabel => 'رقم الجوال';

  @override
  String get workersInvitePhoneHint => '+966 5XX XXX XXXX';

  @override
  String get workersInviteRoleLabel => 'الدور';

  @override
  String get workersInviteSendBtn => 'إرسال الدعوة';

  @override
  String get importTitle => 'استيراد الحيوانات';

  @override
  String get importStep0 => 'اختر الملف';

  @override
  String get importStep1 => 'تعيين الأعمدة';

  @override
  String get importStep2 => 'معاينة';

  @override
  String get importStep3 => 'استيراد';

  @override
  String get importPickTitle => 'اختر الملف';

  @override
  String get importPickSubtitle =>
      'اختر ملف CSV أو Excel يحتوي على بيانات حيواناتك.';

  @override
  String get importPickTap => 'اضغط لاختيار الملف';

  @override
  String get importPickTypes => 'يدعم .csv و .xlsx';

  @override
  String importRowsDetected(int count) {
    return '$count صف مكتشف';
  }

  @override
  String importAutoMapped(int count) {
    return '$count عمود تم ربطه تلقائياً';
  }

  @override
  String get importDetectedColumns => 'الأعمدة المكتشفة';

  @override
  String get importMoreRows => 'صف إضافي';

  @override
  String get importDownloadTemplate => 'تحميل نموذج CSV';

  @override
  String get importPickBtn => 'اختر الملف';

  @override
  String get importMapTitle => 'تعيين الأعمدة';

  @override
  String get importMapSubtitle => 'طابق أعمدة جدولك مع حقول سلالة.';

  @override
  String get importCsvColumn => 'عمود CSV';

  @override
  String get importMapContinue => 'متابعة إلى المعاينة';

  @override
  String get importPreviewTitle => 'معاينة البيانات';

  @override
  String importPreviewReady(int count) {
    return '$count صف جاهز';
  }

  @override
  String get importNoErrors => 'لا توجد أخطاء';

  @override
  String get importStartBtn => 'بدء الاستيراد';

  @override
  String get importProgressTitle => 'جارٍ الاستيراد…';

  @override
  String importProgress(int done, int total) {
    return '$done / $total حيوان';
  }

  @override
  String importBtn(int count) {
    return 'استيراد $count حيوان';
  }

  @override
  String get importSuccessTitle => 'اكتمل الاستيراد!';

  @override
  String importSuccessMsg(int count) {
    return 'تمت إضافة $count حيوان إلى قطيعك';
  }

  @override
  String get importSuccessNote => 'حصل كل حيوان على رقم سلالة فريد';

  @override
  String get importViewAnimals => 'عرض الحيوانات';

  @override
  String get languageArabic => 'العربية';

  @override
  String get languageEnglish => 'English';

  @override
  String get languageToggleTitle => 'اللغة / Language';

  @override
  String get languageSelect => 'اختر اللغة';

  @override
  String get breedPickerTitle => 'اختر السلالة';

  @override
  String get breedPickerSearch => 'ابحث عن سلالة…';

  @override
  String get breedPickerAddCustom => 'إضافة سلالة مخصصة';

  @override
  String get breedPickerCustomHint => 'أدخل اسم السلالة';

  @override
  String get breedPickerCustomSave => 'إضافة';

  @override
  String get breedPickerNoneSelected => 'لم يتم الاختيار';

  @override
  String get colorPickerColorLabel => 'لون الحيوان';

  @override
  String get tagColorLabel => 'لون الوسم (لون بطاقة التعريف)';

  @override
  String get tagNumberLabel => 'رقم الوسم (0–500)';

  @override
  String breedingDeliveryOn(String date) {
    return 'ولادة — $date';
  }

  @override
  String get breedingActivePregnancy => 'حمل نشط';

  @override
  String breedingExpectedDeliveryIn(int days) {
    return 'الولادة المتوقعة بعد $days يوم';
  }

  @override
  String get upcomingBirthLabel => 'ولادة متوقعة';

  @override
  String get statusActive => 'نشط';

  @override
  String get statusForSale => 'للبيع';

  @override
  String get statusReserved => 'محجوز';

  @override
  String get statusCharity => 'صدقة';

  @override
  String get statusLoaned => 'معار';

  @override
  String get statusSold => 'مباع';

  @override
  String get statusDeceased => 'نافق';

  @override
  String get statusMissing => 'مفقود';

  @override
  String get animalPenLabel => 'الحظيرة';

  @override
  String get animalPenHint => 'اختر الحظيرة';

  @override
  String get animalPenNone => 'بدون حظيرة';

  @override
  String get animalAgeClassLabel => 'الفئة العمرية (السن)';

  @override
  String get animalAgeClassHint => 'تُحسب تلقائيًا من تاريخ الميلاد';

  @override
  String get ageClassBahm => 'بهم (أقل من سنة)';

  @override
  String get ageClassJadh => 'جذع (1–2 سنة)';

  @override
  String get ageClassThani => 'ثني (2–3 سنوات)';

  @override
  String get ageClassRubaa => 'رباع (3–4 سنوات)';

  @override
  String get ageClassSudas => 'سديس (4–5 سنوات)';

  @override
  String get ageClassTam => 'تام (5 سنوات فأكثر)';

  @override
  String get animalPurposeLabel => 'الغرض';

  @override
  String get animalPurposeBreeding => 'تربية';

  @override
  String get animalPurposeFattening => 'تسمين';

  @override
  String get animalWeaningLabel => 'نافذة الفطام (بالأيام)';

  @override
  String get animalWeaningFrom => 'من';

  @override
  String get animalWeaningTo => 'إلى';

  @override
  String get animalWeaningHint => 'مثال: من 40 إلى 60 يوم';

  @override
  String get animalWeaningBadge => 'موعد فطام';

  @override
  String get animalOfficialTag => 'رقم الوسم الرسمي';

  @override
  String get animalOfficialTagHint => 'الرقم الحكومي (اختياري)';

  @override
  String get animalPriceLabel => 'السعر (ريال سعودي)';

  @override
  String get animalPriceHint => 'مثال: 1500';

  @override
  String get udhiyaSection => 'الأضحية';

  @override
  String get udhiyaEligible => 'مؤهل للأضحية';

  @override
  String get udhiyaNotEligible => 'غير مؤهل للأضحية';

  @override
  String udhiyaMinAgeRequired(String age) {
    return 'الحد الأدنى للسن: $age';
  }

  @override
  String udhiyaCurrentAge(String age) {
    return 'العمر الحالي: $age';
  }

  @override
  String udhiyaStatusIneligible(String status) {
    return 'الحالة: $status';
  }

  @override
  String get udhiyaSpeciesIneligible => 'هذا النوع غير مؤهل للأضحية';

  @override
  String get udhiyaShortcutLabel => 'الأضحية';

  @override
  String get settingsHijriCalendar => 'التاريخ الهجري';

  @override
  String get settingsHijriCalendarDesc => 'عرض التواريخ بالتقويم الهجري';

  @override
  String get settingsUdhiyaIndicator => 'عرض مؤشر الأضحية';

  @override
  String get settingsUdhiyaIndicatorDesc =>
      'عرض أهلية الأضحية على بطاقات الحيوانات';

  @override
  String get settingsPens => 'الحظائر';

  @override
  String get settingsPensDesc => 'إدارة مجموعات الحظائر';

  @override
  String get settingsFieldLabels => 'تخصيص التسميات';

  @override
  String get settingsFieldLabelsDesc => 'تغيير أسماء الحقول في النماذج';

  @override
  String get fieldLabelsPageTitle => 'تخصيص التسميات';

  @override
  String get fieldLabelsPageSubtitle =>
      'يمكنك تغيير أسماء الحقول التي تظهر في نماذج الإضافة والتعديل.';

  @override
  String get fieldLabelsTagLabel => 'وسم / رقم التعريف';

  @override
  String get fieldLabelsTagColorLabel => 'لون الوسم';

  @override
  String get fieldLabelsAnimalColorLabel => 'لون الحيوان';

  @override
  String get fieldLabelsBreedLabel => 'السلالة';

  @override
  String get fieldLabelsPenLabel => 'الحظيرة';

  @override
  String get fieldLabelsArPlaceholder => 'اكتب التسمية بالعربية';

  @override
  String get fieldLabelsEnPlaceholder => 'English label';

  @override
  String get fieldLabelsSaveBtn => 'حفظ التسميات';

  @override
  String get fieldLabelsResetAll => 'إعادة الافتراضي';

  @override
  String get fieldLabelsSaved => 'تم الحفظ';

  @override
  String get pensTitle => 'الحظائر';

  @override
  String get pensEmpty => 'لا توجد حظائر بعد';

  @override
  String get pensAddBtn => 'إضافة حظيرة';

  @override
  String get pensAddTitle => 'إضافة حظيرة';

  @override
  String get pensEditTitle => 'تعديل الحظيرة';

  @override
  String get pensNameLabel => 'اسم الحظيرة';

  @override
  String get pensNameHint => 'مثال: حظيرة الأغنام الكبار';

  @override
  String get pensNameRequired => 'مطلوب';

  @override
  String get pensDeleteTitle => 'حذف الحظيرة؟';

  @override
  String get pensDeleteMsg =>
      'سيتم إزالة هذه الحظيرة. لن تتأثر الحيوانات المرتبطة بها.';

  @override
  String get notificationSettingsTitle => 'إعدادات الإشعارات';

  @override
  String get notificationVaccination => 'تذكيرات التطعيم';

  @override
  String get notificationVaccinationDesc => 'تنبيه قبل 3 أيام من موعد التطعيم';

  @override
  String get notificationDeworming => 'تذكيرات التطفيل';

  @override
  String get notificationDewormingDesc => 'تنبيه قبل 3 أيام من موعد التطفيل';

  @override
  String get notificationBirth => 'تذكيرات الولادة';

  @override
  String get notificationBirthDesc => 'تنبيه قبل 14 يومًا من الولادة المتوقعة';

  @override
  String get notificationWeaning => 'تذكيرات الفطام';

  @override
  String get notificationWeaningDesc => 'تنبيه عند اقتراب نافذة الفطام';

  @override
  String get dashboardShortcutBahm => 'البهم';

  @override
  String get dashboardShortcutVaccination => 'التطعيم';

  @override
  String get dashboardShortcutNearBirth => 'قريب الولادة';

  @override
  String get dashboardShortcutMales => 'الذكور';

  @override
  String get dashboardShortcutFemales => 'الإناث';

  @override
  String get dashboardShortcutBreeding => 'المقرعات';

  @override
  String get dashboardShortcutDeceased => 'النفوق';

  @override
  String get dashboardShortcutFattening => 'تسمين';

  @override
  String get dashboardShortcutCheckups => 'الفحوصات';

  @override
  String get dashboardShortcutUdhiya => 'الأضحية';

  @override
  String animalIdentity(String tag, String color) {
    return '$tag $color';
  }

  @override
  String get pedigreeTitle => 'شجرة النسب';

  @override
  String get pedigreeViewBtn => 'شجرة النسب';

  @override
  String get pedigreeSubject => 'الحيوان';

  @override
  String get pedigreeParents => 'الوالدان';

  @override
  String get pedigreeGrandparents => 'الأجداد';

  @override
  String get pedigreeUnknown => 'غير معروف';

  @override
  String get pedigreeDam => 'الأم';

  @override
  String get pedigreeSire => 'الأب';

  @override
  String get pedigreeMaternalDam => 'أم الأم';

  @override
  String get pedigreeMaternalSire => 'أب الأم';

  @override
  String get pedigreePaternaldDam => 'أم الأب';

  @override
  String get pedigreePaternaldSire => 'أب الأب';

  @override
  String get customFieldsTitle => 'حقول مخصصة';

  @override
  String get customFieldsEmpty => 'لا توجد حقول مخصصة مضافة بعد';

  @override
  String get customFieldsAddBtn => 'إضافة حقل';

  @override
  String get customFieldLabel => 'عنوان الحقل';

  @override
  String get customFieldValue => 'القيمة';

  @override
  String get customFieldRequired => 'مطلوب';

  @override
  String get customFieldOptional => 'اختياري';

  @override
  String get customFieldTypeText => 'نص';

  @override
  String get customFieldTypeNumber => 'رقم';

  @override
  String get customFieldTypeSelect => 'قائمة';

  @override
  String get customFieldTypeBoolean => 'نعم/لا';

  @override
  String get countryTemplateRequired => 'مطلوب حسب متطلبات بلدك';

  @override
  String get healthOptionBirth => 'تسجيل ولادة';

  @override
  String get healthOptionBirthDesc => 'تسجيل نتيجة الولادة وعدد المواليد';

  @override
  String get registerBirthTitle => 'تسجيل ولادة';

  @override
  String get registerBirthSelectMother => 'اختر الأم';

  @override
  String get registerBirthMotherLabel => 'الأم';

  @override
  String get registerBirthDate => 'تاريخ الولادة';

  @override
  String get registerBirthTotal => 'إجمالي المواليد';

  @override
  String get registerBirthMales => 'ذكور';

  @override
  String get registerBirthFemales => 'إناث';

  @override
  String get registerBirthSire => 'الأب (اختياري)';

  @override
  String get registerBirthSireUnknown => 'غير معروف';

  @override
  String get registerBirthSave => 'حفظ الولادة';

  @override
  String get registerBirthDead => 'عدد النافق';

  @override
  String get registerBirthWeanFrom => 'الفطام من عمر (يوم)';

  @override
  String get registerBirthWeanTo => 'إلى عمر (يوم)';

  @override
  String get registerBirthNext => 'التالي';

  @override
  String registerBirthOffspringOf(int current, int total) {
    return 'مولود $current من $total';
  }

  @override
  String get registerBirthOffspringGender => 'الجنس';

  @override
  String get registerBirthOffspringColor => 'اللون';

  @override
  String get registerBirthOffspringTagNumber => 'رقم العلامة';

  @override
  String get registerBirthOffspringPen => 'الحظيرة (اختياري)';

  @override
  String get registerBirthSuccessTitle => 'تم تسجيل الولادة';

  @override
  String registerBirthSuccessBody(String dam, int count) {
    return 'ولادة $dam — $count مولود مسجل';
  }

  @override
  String get animalPickerTitle => 'اختر الحيوانات';

  @override
  String get animalPickerSearch => 'ابحث بالرقم أو اللون…';

  @override
  String get animalPickerNone => 'لا توجد حيوانات';

  @override
  String animalPickerApply(int count) {
    return 'تطبيق ($count)';
  }

  @override
  String animalPickerSelectedLabel(int count) {
    return '$count حيوان مختار';
  }

  @override
  String get animalPickerTap => 'اضغط لاختيار الحيوانات';

  @override
  String get btnClear => 'مسح';

  @override
  String healthSavedForAnimals(int count) {
    return 'تم الحفظ لـ $count حيوان';
  }
}
