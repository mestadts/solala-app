// ignore: unused_import
import 'package:intl/intl.dart' as intl;
import 'app_localizations.dart';

// ignore_for_file: type=lint

/// The translations for English (`en`).
class AppLEn extends AppL {
  AppLEn([String locale = 'en']) : super(locale);

  @override
  String get appTitle => 'Solala';

  @override
  String get appTagline => 'Your Livestock, Managed Smartly';

  @override
  String get btnContinue => 'Continue';

  @override
  String get btnSave => 'Save';

  @override
  String get btnCancel => 'Cancel';

  @override
  String get btnDelete => 'Delete';

  @override
  String get btnSkip => 'Skip';

  @override
  String get btnNext => 'Next';

  @override
  String get btnBack => 'Back';

  @override
  String get btnClose => 'Close';

  @override
  String get btnCopyId => 'Copy ID';

  @override
  String get navHome => 'Home';

  @override
  String get navAnimals => 'Animals';

  @override
  String get navHealth => 'Health';

  @override
  String get navSettings => 'Settings';

  @override
  String get loginTitle => 'Welcome Back';

  @override
  String get loginSubtitle => 'Sign in to your Solala account';

  @override
  String get loginPhone => 'Phone Number';

  @override
  String get loginPhoneHint => '5XX XXX XXX (no leading 0)';

  @override
  String get loginPhoneValidation => 'Please enter your phone number';

  @override
  String get loginPassword => 'Password';

  @override
  String get loginPasswordHint => 'Enter your password';

  @override
  String get loginPasswordValidation => 'Please enter your password';

  @override
  String get loginForgotPassword => 'Forgot password?';

  @override
  String get loginBtn => 'Sign In';

  @override
  String get loginOrWith => 'Or continue with';

  @override
  String get loginNoAccount => 'Don\'t have an account? ';

  @override
  String get loginRegisterLink => 'Register';

  @override
  String get selectCountry => 'Select Country';

  @override
  String get countrySearchHint => 'Search country';

  @override
  String get otpTitle => 'Verify Your Number';

  @override
  String get otpSubtitle => 'Enter the 6-digit code sent to ';

  @override
  String get otpYourNumber => 'your number';

  @override
  String otpResendIn(int seconds) {
    return 'Resend code in ${seconds}s';
  }

  @override
  String get otpResend => 'Resend code';

  @override
  String get otpVerifyBtn => 'Verify & Continue';

  @override
  String get forgotTitle => 'Forgot Password?';

  @override
  String get forgotSubtitle =>
      'Enter your phone number and we\'ll send you a verification code to reset your password.';

  @override
  String get forgotSendBtn => 'Send Verification Code';

  @override
  String get forgotRemember => 'Remember your password? ';

  @override
  String get forgotSignInLink => 'Sign In';

  @override
  String get resetTitle => 'Reset Password';

  @override
  String get resetSubtitle => 'Enter a new password for your account.';

  @override
  String get resetNewPassword => 'New Password';

  @override
  String get resetNewPasswordHint => 'At least 8 characters';

  @override
  String get resetPasswordMinLength => 'Password must be at least 8 characters';

  @override
  String get resetConfirmPassword => 'Confirm New Password';

  @override
  String get resetConfirmHint => 'Re-enter your new password';

  @override
  String get resetPasswordMismatch => 'Passwords do not match';

  @override
  String get resetBtn => 'Reset Password';

  @override
  String get resetSuccess => 'Password reset successfully. Please sign in.';

  @override
  String get registerStep0Title => 'Create Account';

  @override
  String get registerStep0Subtitle => 'Join Solala to manage your livestock';

  @override
  String get registerSendOtp => 'Send OTP';

  @override
  String get registerHaveAccount => 'Already have an account? ';

  @override
  String get registerSignInLink => 'Sign In';

  @override
  String get registerStep2Title => 'Complete Your Profile';

  @override
  String get registerStep2Subtitle =>
      'Almost there! Set your name and password.';

  @override
  String get registerFullName => 'Full Name';

  @override
  String get registerFullNameHint => 'Ahmed Al-Rashidi';

  @override
  String get registerFullNameValidation => 'Please enter your full name';

  @override
  String get registerPasswordHint => 'At least 8 characters';

  @override
  String get registerConfirmPassword => 'Confirm Password';

  @override
  String get registerConfirmHint => 'Re-enter your password';

  @override
  String get registerCreateBtn => 'Create Account';

  @override
  String get onboardingSlide1Title => 'Track Every Animal';

  @override
  String get onboardingSlide1Desc =>
      'Manage your entire herd in one place. Assign a unique Solala ID to each animal and never lose track.';

  @override
  String get onboardingSlide2Title => 'Stay on Top of Health';

  @override
  String get onboardingSlide2Desc =>
      'Log vaccinations, treatments, and weight records. Get reminders before vaccinations are due.';

  @override
  String get onboardingSlide3Title => 'Scan & Identify Instantly';

  @override
  String get onboardingSlide3Desc =>
      'Every animal gets a QR code. Scan it in the field to pull up the full profile instantly.';

  @override
  String get onboardingSlide4Title => 'Secure Ownership Records';

  @override
  String get onboardingSlide4Desc =>
      'Transfer ownership with a full immutable chain. Every transaction is permanent and tamper-proof.';

  @override
  String get onboardingGetStarted => 'Get Started';

  @override
  String get countryTitle => 'Select Country';

  @override
  String get countrySubtitle => 'Where is your farm or ranch located?';

  @override
  String get countrySearch => 'Search country…';

  @override
  String get orgTypeTitle => 'Organization Type';

  @override
  String get orgTypeSubtitle =>
      'Choose the type that best describes how you manage your livestock.';

  @override
  String get orgTypeIndividual => 'Individual / Personal';

  @override
  String get orgTypeIndividualDesc =>
      'You manage your own animals. Perfect for breeders and small herd owners.';

  @override
  String get orgTypeSmallFarm => 'Small Farm';

  @override
  String get orgTypeSmallFarmDesc =>
      'A family-run or small-scale farm with multiple livestock species.';

  @override
  String get orgTypeCommercial => 'Commercial Ranch';

  @override
  String get orgTypeCommercialDesc =>
      'Large-scale operation with workers, advanced reporting, and bulk transfers.';

  @override
  String get orgTypeGovt => 'Government / Regulatory';

  @override
  String get orgTypeGovtDesc =>
      'Official body overseeing livestock registration and compliance.';

  @override
  String get orgSetupTitle => 'Set Up Your Farm';

  @override
  String get orgSetupSubtitle =>
      'Tell us a bit about your operation so we can personalize Solala for you.';

  @override
  String get orgSetupName => 'Farm / Organization Name';

  @override
  String get orgSetupNameHint => 'e.g. Al-Rashidi Livestock';

  @override
  String get orgSetupNameValidation => 'Please enter a name for your farm';

  @override
  String get orgSetupLocation => 'Location / City';

  @override
  String get orgSetupLocationHint => 'e.g. Riyadh, Saudi Arabia';

  @override
  String get orgSetupLocationValidation => 'Please enter your farm location';

  @override
  String get orgSetupHerdSize => 'Approximate Herd Size (optional)';

  @override
  String get orgSetupHerdSizeHint => 'e.g. 50';

  @override
  String get orgSetupFinish => 'Finish Setup';

  @override
  String get orgSetupLegal =>
      'By continuing, you agree to our Terms of Service and Privacy Policy.';

  @override
  String get dashboardGreeting => 'Good morning,';

  @override
  String get dashboardDefaultFarmName => 'My Farm';

  @override
  String get dashboardUpcomingEvents => 'Upcoming Events';

  @override
  String get dashboardRecentActivity => 'Recent Activity';

  @override
  String get dashboardNoUpcoming => 'No upcoming events';

  @override
  String get dashboardNoActivity => 'No recent activity';

  @override
  String get dashboardOverdue => 'Overdue';

  @override
  String get dashboardDue => 'Due';

  @override
  String get dashboardTotalAnimals => 'Total Animals';

  @override
  String get dashboardAddAnimal => 'Add Animal';

  @override
  String get dashboardHerdOverview => 'Herd Overview';

  @override
  String get dashboardCategories => 'Categories';

  @override
  String get dashboardSpeciesBreakdown => 'Herd Statistics';

  @override
  String get dashboardSeeAll => 'See all';

  @override
  String get dashboardEventsThisWeek => 'Events This Week';

  @override
  String get animalsTitle => 'Animals';

  @override
  String animalsTotal(int count) {
    return '$count total';
  }

  @override
  String get animalsAdd => 'Add';

  @override
  String get animalsSearch => 'Search by name, ID, or tag…';

  @override
  String get animalsFilterAll => 'All';

  @override
  String get animalsEmpty => 'No animals yet';

  @override
  String get animalsEmptyHint => 'Tap + Add to register your first animal';

  @override
  String get animalsNoMatch => 'No animals match your search';

  @override
  String get animalsNoMatchHint => 'Try a different name or filter';

  @override
  String get addAnimalStep0Title => 'Select Species';

  @override
  String get addAnimalStep0Subtitle =>
      'What type of animal are you registering?';

  @override
  String get addAnimalStep1Title => 'Basic Information';

  @override
  String get addAnimalStep1Subtitle =>
      'Name is optional — you can use the system ID instead.';

  @override
  String get addAnimalNameLabel => 'Animal Name (optional)';

  @override
  String get addAnimalNameHint => 'e.g. Layla';

  @override
  String get addAnimalGenderLabel => 'Gender';

  @override
  String get addAnimalDobLabel => 'Date of Birth (optional)';

  @override
  String get addAnimalDobHint => 'YYYY-MM-DD';

  @override
  String get addAnimalStep2Title => 'Breed';

  @override
  String get addAnimalStep2Subtitle =>
      'Breed is required — select from the list or add a new one.';

  @override
  String get addAnimalBreedLabel => 'Breed';

  @override
  String get addAnimalBreedSkip => 'Skip for now';

  @override
  String get addAnimalStep3Title => 'Color & Tag';

  @override
  String get addAnimalStep3Subtitle =>
      'Standardized color and numeric tag for identification.';

  @override
  String get addAnimalColorLabel => 'Animal Color';

  @override
  String get addAnimalTagLabel => 'Tag Number (0–500)';

  @override
  String get addAnimalStep4Title => 'Add Photo';

  @override
  String get addAnimalStep4Subtitle =>
      'A photo helps identify your animal quickly.';

  @override
  String get addAnimalPhotoTap => 'Tap to add photo\n(optional)';

  @override
  String get addAnimalChoosePhoto => 'Choose Photo';

  @override
  String get addAnimalSaveBtn => 'Save Animal';

  @override
  String get addAnimalSuccessTitle => 'Animal Registered!';

  @override
  String get addAnimalSuccessMsg =>
      'Your animal has been added to the herd.\nHere is its unique System ID:';

  @override
  String get addAnimalSystemIdLabel => 'System ID';

  @override
  String get addAnimalIdPermanent =>
      'This ID is permanent and cannot be changed';

  @override
  String get addAnimalBackToList => 'Back to Animals';

  @override
  String get addAnimalPurposeLabel => 'Purpose';

  @override
  String get addAnimalAgeClassLabel => 'Age Class';

  @override
  String get addAnimalAgeClassAuto => 'Auto from DOB';

  @override
  String get addAnimalPenLabel => 'Pen / Group (optional)';

  @override
  String get addAnimalPenNone => 'No pen assigned';

  @override
  String get addAnimalWeightLabel => 'Weight (kg, optional)';

  @override
  String get addAnimalWeightHint => 'e.g. 45.5';

  @override
  String get addAnimalPriceLabel => 'Price (SAR, optional)';

  @override
  String get addAnimalPriceHint => 'e.g. 1200';

  @override
  String get addAnimalPhotoCamera => 'Take Photo';

  @override
  String get addAnimalPhotoGallery => 'Choose from Gallery';

  @override
  String get animalDuplicate => 'Duplicate Animal';

  @override
  String get animalDuplicateHint =>
      'Duplicating pre-fills the form — change only what’s different';

  @override
  String get animalActionEdit => 'Edit';

  @override
  String get animalActionSell => 'Mark as Sold';

  @override
  String get animalActionSlaughter => 'Mark as Slaughtered';

  @override
  String get animalActionMarkDead => 'Mark as Dead';

  @override
  String get animalActionSlaughterConfirm => 'Mark this animal as slaughtered?';

  @override
  String get animalActionDeadConfirm => 'Mark this animal as deceased?';

  @override
  String get btnConfirm => 'Confirm';

  @override
  String get animalDetailTabHealth => 'Health';

  @override
  String get animalDetailTabWeight => 'Weight';

  @override
  String get animalDetailTabOwnership => 'Ownership';

  @override
  String get animalDetailTabBreeding => 'Breeding';

  @override
  String get animalDetailNotFound => 'Animal not found';

  @override
  String get animalDetailGender => 'Gender';

  @override
  String get animalDetailBreed => 'Breed';

  @override
  String get animalDetailDob => 'DOB';

  @override
  String get animalDetailWeight => 'Weight';

  @override
  String get animalDetailTag => 'Tag: ';

  @override
  String get animalDetailCurrentOwner => 'Current Owner';

  @override
  String get animalDetailTransferOwnership => 'Transfer Ownership';

  @override
  String get animalDetailTransferHistory => 'Transfer History';

  @override
  String get animalDetailNoTransfers => 'No transfers yet';

  @override
  String get animalDetailNoHealth => 'No health records yet';

  @override
  String get animalDetailNoWeight => 'No weight records yet';

  @override
  String get animalDetailOfficial => 'Official';

  @override
  String get animalDetailQrTitle => 'QR Code';

  @override
  String animalDetailDeleteTitle(String name) {
    return 'Delete $name?';
  }

  @override
  String animalDetailDeleteMsg(String name) {
    return 'This will permanently remove $name from your records.';
  }

  @override
  String editAnimalTitle(String name) {
    return 'Edit $name';
  }

  @override
  String get editAnimalCannotChange => '(cannot change)';

  @override
  String get editAnimalNameLabel => 'Animal Name';

  @override
  String get editAnimalNameHint => 'e.g. Layla';

  @override
  String get editAnimalNameValidation => 'Name is required';

  @override
  String get editAnimalBreedLabel => 'Breed';

  @override
  String get editAnimalBreedHint => 'e.g. Najdi';

  @override
  String get editAnimalGenderLabel => 'Gender';

  @override
  String get editAnimalDobLabel => 'Date of Birth';

  @override
  String get editAnimalWeightLabel => 'Current Weight (kg)';

  @override
  String get editAnimalWeightHint => 'e.g. 45.5';

  @override
  String get editAnimalTagLabel => 'Breeder Tag';

  @override
  String get editAnimalTagHint => 'e.g. RED-001';

  @override
  String get editAnimalStatusLabel => 'Status';

  @override
  String get editAnimalSaveBtn => 'Save Changes';

  @override
  String get editAnimalNotFound => 'Animal not found';

  @override
  String get genderMale => 'Male';

  @override
  String get genderFemale => 'Female';

  @override
  String get qrScanTitle => 'Scan QR Code';

  @override
  String get qrScanInstruction => 'Point at a Solala QR code';

  @override
  String get qrScanDemo => 'Demo: Pick Animal';

  @override
  String get qrScanDemoSubtitle => 'Select animal to simulate scan';

  @override
  String get healthTitle => 'Health';

  @override
  String get healthUpcomingEvents => 'Upcoming Events';

  @override
  String get healthRecentRecords => 'Recent Records';

  @override
  String get healthNoUpcoming => 'No upcoming events';

  @override
  String get healthNoRecords => 'No health records yet';

  @override
  String get healthAddRecord => 'Add Record';

  @override
  String get healthDue => 'Due';

  @override
  String get healthOverdue => 'Overdue';

  @override
  String get healthOptionVaccination => 'Vaccination';

  @override
  String get healthOptionVaccinationDesc =>
      'Record a vaccine with next due date';

  @override
  String get healthOptionTreatment => 'Treatment';

  @override
  String get healthOptionTreatmentDesc =>
      'Record a medical treatment or checkup';

  @override
  String get healthOptionWeight => 'Weight';

  @override
  String get healthOptionWeightDesc => 'Log a weight measurement';

  @override
  String get healthOptionPregnancy => 'Pregnancy';

  @override
  String get healthOptionPregnancyDesc =>
      'Record mating date and expected delivery';

  @override
  String get healthOptionDeworming => 'Deworming';

  @override
  String get healthOptionDewormingDesc =>
      'Log deworming treatment with next due date';

  @override
  String get addVaccinationTitle => 'Add Vaccination';

  @override
  String get addVaccinationAnimal => 'Animal';

  @override
  String get addVaccinationSelectAnimal => 'Select animal';

  @override
  String get addVaccinationVaccineName => 'Vaccine Name';

  @override
  String get addVaccinationVaccineHint => 'e.g. FMD Vaccine';

  @override
  String get addVaccinationRequired => 'Required';

  @override
  String get addVaccinationDateGiven => 'Date Given';

  @override
  String get addVaccinationNextDue => 'Next Due Date (optional)';

  @override
  String get addVaccinationVet => 'Veterinarian';

  @override
  String get addVaccinationVetHint => 'e.g. Dr. Khalid Hassan';

  @override
  String get addVaccinationNotes => 'Notes (optional)';

  @override
  String get addVaccinationNotesHint => 'Any additional observations...';

  @override
  String get addVaccinationSaveBtn => 'Save Vaccination';

  @override
  String get addVaccinationSelectFirst => 'Please select an animal';

  @override
  String get dateHint => 'YYYY-MM-DD';

  @override
  String get addTreatmentTitle => 'Add Treatment';

  @override
  String get addTreatmentType => 'Treatment Type';

  @override
  String get addTreatmentTypeHint => 'e.g. Skin Treatment, Antibiotic';

  @override
  String get addTreatmentDate => 'Date';

  @override
  String get addTreatmentMeds => 'Medications (optional)';

  @override
  String get addTreatmentMedsHint => 'e.g. Oxytetracycline 20mg';

  @override
  String get addTreatmentVet => 'Veterinarian';

  @override
  String get addTreatmentVetHint => 'e.g. Dr. Sara Al-Mutairi';

  @override
  String get addTreatmentNotes => 'Notes (optional)';

  @override
  String get addTreatmentNotesHint => 'Observations, follow-up...';

  @override
  String get addTreatmentSaveBtn => 'Save Treatment';

  @override
  String get addTreatmentSelectFirst => 'Please select an animal';

  @override
  String get addWeightTitle => 'Record Weight';

  @override
  String get addWeightLabel => 'Weight';

  @override
  String get addWeightHint => 'e.g. 45.5';

  @override
  String get addWeightRequired => 'Required';

  @override
  String get addWeightInvalid => 'Invalid number';

  @override
  String get addWeightUnit => 'Unit';

  @override
  String get addWeightDateLabel => 'Date Recorded';

  @override
  String get addWeightOfficial => 'Official Measurement';

  @override
  String get addWeightOfficialDesc => 'Verified by vet or official scale';

  @override
  String get addWeightSaveBtn => 'Save Weight';

  @override
  String get addWeightSelectFirst => 'Please select an animal';

  @override
  String get addPregnancyTitle => 'Record Pregnancy';

  @override
  String get addPregnancyInfo =>
      'Gestation: Sheep/Goat ~5mo · Cow ~9mo · Camel ~13mo · Horse ~11mo';

  @override
  String get addPregnancyDamLabel => 'Mother (Dam)';

  @override
  String get addPregnancyDamHint => 'Select female animal';

  @override
  String get addPregnancyMatingDate => 'Mating Date';

  @override
  String get addPregnancyExpected => 'Expected Delivery (auto-calculated)';

  @override
  String get addPregnancySireLabel => 'Sire (optional)';

  @override
  String get addPregnancySireHint => 'Name or System ID of the father';

  @override
  String get addPregnancyNotes => 'Notes (optional)';

  @override
  String get addPregnancyNotesHint => 'Any additional observations';

  @override
  String get addPregnancySaveBtn => 'Save Pregnancy Record';

  @override
  String get addDewormingTitle => 'Record Deworming';

  @override
  String get addDewormingAnimal => 'Animal';

  @override
  String get addDewormingSelectAnimal => 'Select animal';

  @override
  String get addDewormingProduct => 'Product';

  @override
  String get addDewormingDateGiven => 'Date Given';

  @override
  String get addDewormingNextDue => 'Next Due Date (auto: +3 months)';

  @override
  String get addDewormingDose => 'Dose (optional)';

  @override
  String get addDewormingDoseHint => 'e.g. 5ml, 2 tablets';

  @override
  String get addDewormingNotes => 'Notes (optional)';

  @override
  String get addDewormingNotesHint => 'Any additional observations';

  @override
  String get addDewormingSaveBtn => 'Save Deworming Record';

  @override
  String get healthHistoryWeightTrend => 'Weight Trend';

  @override
  String get healthHistoryTimeline => 'Health Timeline';

  @override
  String get healthHistoryNoRecords => 'No health records for this animal';

  @override
  String get breedingAddRecord => 'Add Breeding Record';

  @override
  String get breedingRecordsTitle => 'Breeding Records';

  @override
  String get breedingNoRecords => 'No breeding records yet';

  @override
  String get breedingNoRecordsHint =>
      'Record dam/sire links and offspring deliveries';

  @override
  String get breedingDam => '♀ Dam (Mother)';

  @override
  String get breedingSire => '♂ Sire (Father)';

  @override
  String get breedingUnknown => 'Unknown';

  @override
  String breedingOffspringInfo(int born, int surviving) {
    return '$born born, $surviving surviving';
  }

  @override
  String get breedingWizardStep0Title => 'Confirm Mother (Dam)';

  @override
  String get breedingWizardStep0Subtitle =>
      'We will record this breeding for the animal below.';

  @override
  String get breedingWizardStep0ConfirmBtn => 'Confirm — Continue';

  @override
  String get breedingWizardUnnamed => 'Unnamed';

  @override
  String get breedingWizardFemale => 'Female';

  @override
  String get breedingWizardStep1Title => 'Select Sire (Father)';

  @override
  String get breedingWizardStep1Subtitle =>
      'Choose from your herd or mark as unknown.';

  @override
  String get breedingWizardSireUnknown => 'Sire is unknown / external';

  @override
  String get breedingWizardSelectMale => 'Select from your males';

  @override
  String get breedingWizardSelectMaleHint => 'Select male animal';

  @override
  String get breedingWizardOrManual => 'Or enter name manually';

  @override
  String get breedingWizardSireHint => 'Sire name / ID (optional)';

  @override
  String get breedingWizardStep2Title => 'Mating & Expected Delivery';

  @override
  String get breedingWizardStep2Subtitle =>
      'Expected delivery is auto-calculated by species.';

  @override
  String get breedingWizardMatingDate => 'Mating Date';

  @override
  String get breedingWizardExpectedDelivery =>
      'Expected Delivery (auto-calculated)';

  @override
  String get breedingWizardStep3Title => 'Birth Outcome';

  @override
  String get breedingWizardStep3Subtitle =>
      'Record the results of the delivery.';

  @override
  String get breedingWizardTotalOffspring => 'Total Offspring';

  @override
  String get breedingWizardSurviving => 'Surviving';

  @override
  String get breedingWizardMalesBorn => 'Males Born';

  @override
  String get breedingWizardFemalesBorn => 'Females Born';

  @override
  String get breedingWizardNotes => 'Notes (optional)';

  @override
  String get breedingWizardNotesHint => 'e.g. Twin lambs, both healthy...';

  @override
  String get breedingWizardStep4Title => 'Review & Confirm';

  @override
  String get breedingWizardStep4Subtitle =>
      'Please review before saving. This record will be permanent.';

  @override
  String get breedingWizardMother => 'Mother (Dam)';

  @override
  String get breedingWizardFather => 'Father (Sire)';

  @override
  String get breedingWizardGenderSplit => 'Gender Split';

  @override
  String get breedingWizardSaveBtn => 'Save Breeding Record';

  @override
  String stepLabel(int step, int total) {
    return 'Step $step of $total';
  }

  @override
  String get transferTitle => 'Transfer Ownership';

  @override
  String get transferTypeTitle => 'Transfer Type';

  @override
  String get transferTypeSubtitle => 'How is this animal being transferred?';

  @override
  String get transferTypeSale => 'Sale';

  @override
  String get transferTypeSaleDesc => 'Transfer for a price';

  @override
  String get transferTypeGift => 'Gift';

  @override
  String get transferTypeGiftDesc => 'Transfer without payment';

  @override
  String get transferTypeInternal => 'Internal';

  @override
  String get transferTypeInternalDesc => 'Move within organization';

  @override
  String get transferPriceTitle => 'Sale Price';

  @override
  String get transferPriceSubtitle => 'Enter the agreed sale price';

  @override
  String get transferPriceLabel => 'Price';

  @override
  String get transferPriceHint => 'e.g. 5000';

  @override
  String get transferCurrencyLabel => 'Currency';

  @override
  String get transferNewOwnerTitle => 'New Owner';

  @override
  String get transferNewOwnerSubtitle =>
      'Search by phone number or select from contacts';

  @override
  String get transferPhoneLabel => 'Phone Number';

  @override
  String get transferPhoneHint => '+966 5XX XXX XXXX';

  @override
  String get transferPickContact => 'Pick from Contacts';

  @override
  String get orLabel => 'or';

  @override
  String get permissionContactsDenied => 'Contacts permission was denied';

  @override
  String get transferOrPick => 'Or pick from demo contacts:';

  @override
  String get transferDocTitle => 'Attach Document';

  @override
  String get transferDocSubtitle =>
      'Optional: attach a sale agreement or transfer certificate';

  @override
  String get transferDocTap => 'Tap to attach document';

  @override
  String get transferDocAttached => 'Document attached';

  @override
  String get transferDocTypes => 'PDF, JPG, or PNG';

  @override
  String get transferDocSkip => 'Continue without document';

  @override
  String get transferReviewTitle => 'Review Transfer';

  @override
  String get transferReviewSubtitle =>
      'Please review before confirming. This action is immutable.';

  @override
  String get transferAnimalLabel => 'Animal';

  @override
  String get transferTypeLabel => 'Transfer Type';

  @override
  String get transferFromLabel => 'From';

  @override
  String get transferToLabel => 'To';

  @override
  String get transferPriceReview => 'Price';

  @override
  String get transferDocLabel => 'Document';

  @override
  String get transferDocAttachedVal => 'Attached';

  @override
  String get transferDocNone => 'None';

  @override
  String get transferDateLabel => 'Date';

  @override
  String get transferWarning =>
      'This transfer is immutable and cannot be undone. The record will be permanently stored.';

  @override
  String get transferConfirmBtn => 'Confirm Transfer';

  @override
  String get settingsTitle => 'Settings';

  @override
  String get settingsSectionOrg => 'Organization';

  @override
  String get settingsOrgSettings => 'Organization Settings';

  @override
  String get settingsWorkerMgmt => 'Worker Management';

  @override
  String get settingsWorkerMgmtDesc => 'Manage team members and roles';

  @override
  String get settingsSectionData => 'Data';

  @override
  String get settingsImport => 'Import Animals';

  @override
  String get settingsImportDesc => 'Import from CSV or Excel spreadsheet';

  @override
  String get settingsImportBadge => 'New';

  @override
  String get settingsExport => 'Export Data';

  @override
  String get settingsExportDesc => 'Export animal list to CSV';

  @override
  String get settingsSectionPref => 'Preferences';

  @override
  String get settingsNotifications => 'Notifications';

  @override
  String get settingsNotificationsDesc => 'Vaccination reminders and alerts';

  @override
  String get settingsLanguage => 'Language';

  @override
  String get settingsSectionAccount => 'Account';

  @override
  String get settingsHelp => 'Help & Support';

  @override
  String get settingsHelpDesc => 'FAQs and contact';

  @override
  String get settingsLogout => 'Log Out';

  @override
  String get settingsLogoutDesc => 'Sign out of your account';

  @override
  String get settingsLogoutTitle => 'Log Out?';

  @override
  String get settingsLogoutMsg =>
      'You will need to log back in to access your herd.';

  @override
  String get profileEditTitle => 'Edit Profile';

  @override
  String get profileFullName => 'Full Name';

  @override
  String get profilePhone => 'Phone Number';

  @override
  String get profileSaveBtn => 'Save Changes';

  @override
  String get profileUnnamed => 'User';

  @override
  String get roleOwner => 'Owner';

  @override
  String get settingsOrgSettingsDesc => 'Organization settings';

  @override
  String get orgSettingsTitle => 'Organization Settings';

  @override
  String get orgSettingsNameLabel => 'Farm / Organization Name';

  @override
  String get orgSettingsNameRequired => 'Required';

  @override
  String get orgSettingsTypeLabel => 'Organization Type';

  @override
  String get orgSettingsCountryLabel => 'Country';

  @override
  String get orgSettingsSaveBtn => 'Save Changes';

  @override
  String get orgTypeOptionIndividual => 'Individual';

  @override
  String get orgTypeOptionSmall => 'Small Farm';

  @override
  String get orgTypeOptionCommercial => 'Commercial Farm';

  @override
  String get orgTypeOptionGovt => 'Government';

  @override
  String get workersTitle => 'Workers';

  @override
  String workersCount(int count) {
    return '$count team members';
  }

  @override
  String get workersInviteBtn => 'Invite Worker';

  @override
  String get workersRoleWorker => 'Worker';

  @override
  String get workersRoleSupervisor => 'Supervisor';

  @override
  String get workersInviteTitle => 'Invite Worker';

  @override
  String get workersInviteNameLabel => 'Name';

  @override
  String get workersInviteNameHint => 'e.g. Faisal Al-Dosari';

  @override
  String get workersInvitePhoneLabel => 'Phone Number';

  @override
  String get workersInvitePhoneHint => '+966 5XX XXX XXXX';

  @override
  String get workersInviteRoleLabel => 'Role';

  @override
  String get workersInviteSendBtn => 'Send Invite';

  @override
  String get importTitle => 'Import Animals';

  @override
  String get importStep0 => 'Pick File';

  @override
  String get importStep1 => 'Map Columns';

  @override
  String get importStep2 => 'Preview';

  @override
  String get importStep3 => 'Import';

  @override
  String get importPickTitle => 'Pick Your File';

  @override
  String get importPickSubtitle =>
      'Select a CSV or Excel file containing your animal data.';

  @override
  String get importPickTap => 'Tap to pick file';

  @override
  String get importPickTypes => 'Supports .csv and .xlsx';

  @override
  String importRowsDetected(int count) {
    return '$count rows detected';
  }

  @override
  String importAutoMapped(int count) {
    return '$count columns auto-mapped';
  }

  @override
  String get importDetectedColumns => 'Detected Columns';

  @override
  String get importMoreRows => 'more rows';

  @override
  String get importDownloadTemplate => 'Download sample CSV template';

  @override
  String get importPickBtn => 'Pick File';

  @override
  String get importMapTitle => 'Map Columns';

  @override
  String get importMapSubtitle =>
      'Match your spreadsheet columns to Solala fields.';

  @override
  String get importCsvColumn => 'CSV Column';

  @override
  String get importMapContinue => 'Continue to Preview';

  @override
  String get importPreviewTitle => 'Preview Data';

  @override
  String importPreviewReady(int count) {
    return '$count rows ready';
  }

  @override
  String get importNoErrors => '0 errors';

  @override
  String get importStartBtn => 'Start Import';

  @override
  String get importProgressTitle => 'Importing…';

  @override
  String importProgress(int done, int total) {
    return '$done / $total animals';
  }

  @override
  String importBtn(int count) {
    return 'Import $count Animals';
  }

  @override
  String get importSuccessTitle => 'Import Complete!';

  @override
  String importSuccessMsg(int count) {
    return '$count animals added to your herd';
  }

  @override
  String get importSuccessNote => 'Each animal was assigned a unique Solala ID';

  @override
  String get importViewAnimals => 'View Animals';

  @override
  String get languageArabic => 'العربية';

  @override
  String get languageEnglish => 'English';

  @override
  String get languageToggleTitle => 'اللغة / Language';

  @override
  String get languageSelect => 'Select Language';

  @override
  String get breedPickerTitle => 'Select Breed';

  @override
  String get breedPickerSearch => 'Search breeds…';

  @override
  String get breedPickerAddCustom => 'Add Custom Breed';

  @override
  String get breedPickerCustomHint => 'Enter breed name';

  @override
  String get breedPickerCustomSave => 'Add';

  @override
  String get breedPickerNoneSelected => 'None selected';

  @override
  String get colorPickerColorLabel => 'Animal Color';

  @override
  String get tagColorLabel => 'Tag Color (ID Tag Color)';

  @override
  String get tagNumberLabel => 'Tag Number (0–500)';

  @override
  String breedingDeliveryOn(String date) {
    return 'Delivery — $date';
  }

  @override
  String get breedingActivePregnancy => 'Active Pregnancy';

  @override
  String breedingExpectedDeliveryIn(int days) {
    return 'Expected delivery in $days days';
  }

  @override
  String get upcomingBirthLabel => 'Expected Birth';

  @override
  String get statusActive => 'Active';

  @override
  String get statusForSale => 'For Sale';

  @override
  String get statusReserved => 'Reserved';

  @override
  String get statusCharity => 'Charity';

  @override
  String get statusLoaned => 'Loaned';

  @override
  String get statusSold => 'Sold';

  @override
  String get statusDeceased => 'Deceased';

  @override
  String get statusMissing => 'Missing';

  @override
  String get animalPenLabel => 'Pen / Group';

  @override
  String get animalPenHint => 'Select pen';

  @override
  String get animalPenNone => 'No pen';

  @override
  String get animalAgeClassLabel => 'Age Class';

  @override
  String get animalAgeClassHint => 'Auto-calculated from date of birth';

  @override
  String get ageClassBahm => 'Bahm (under 1 year)';

  @override
  String get ageClassJadh => 'Jadh (1–2 years)';

  @override
  String get ageClassThani => 'Thani (2–3 years)';

  @override
  String get ageClassRubaa => 'Rubaa (3–4 years)';

  @override
  String get ageClassSudas => 'Sudas (4–5 years)';

  @override
  String get ageClassTam => 'Tam (5+ years)';

  @override
  String get animalPurposeLabel => 'Purpose';

  @override
  String get animalPurposeBreeding => 'Breeding';

  @override
  String get animalPurposeFattening => 'Fattening';

  @override
  String get animalWeaningLabel => 'Weaning Window (days)';

  @override
  String get animalWeaningFrom => 'From';

  @override
  String get animalWeaningTo => 'To';

  @override
  String get animalWeaningHint => 'e.g., from 40 to 60 days';

  @override
  String get animalWeaningBadge => 'Weaning Due';

  @override
  String get animalOfficialTag => 'Official Tag Number';

  @override
  String get animalOfficialTagHint => 'Government/regulatory number (optional)';

  @override
  String get animalPriceLabel => 'Price (SAR)';

  @override
  String get animalPriceHint => 'e.g., 1500';

  @override
  String get udhiyaSection => 'Udhiya (Sacrifice)';

  @override
  String get udhiyaEligible => 'Eligible for Udhiya';

  @override
  String get udhiyaNotEligible => 'Not Eligible for Udhiya';

  @override
  String udhiyaMinAgeRequired(String age) {
    return 'Minimum age: $age';
  }

  @override
  String udhiyaCurrentAge(String age) {
    return 'Current age: $age';
  }

  @override
  String udhiyaStatusIneligible(String status) {
    return 'Status: $status';
  }

  @override
  String get udhiyaSpeciesIneligible =>
      'This species is not eligible for Udhiya';

  @override
  String get udhiyaShortcutLabel => 'Udhiya';

  @override
  String get settingsHijriCalendar => 'Hijri Calendar';

  @override
  String get settingsHijriCalendarDesc => 'Show dates in Hijri format';

  @override
  String get settingsUdhiyaIndicator => 'Udhiya Indicator';

  @override
  String get settingsUdhiyaIndicatorDesc =>
      'Show Udhiya eligibility on animal cards';

  @override
  String get settingsPens => 'Pens';

  @override
  String get settingsPensDesc => 'Manage pen groups';

  @override
  String get settingsFieldLabels => 'Customize Labels';

  @override
  String get settingsFieldLabelsDesc => 'Rename form field labels';

  @override
  String get fieldLabelsPageTitle => 'Customize Labels';

  @override
  String get fieldLabelsPageSubtitle =>
      'Change the names of fields shown in add/edit forms.';

  @override
  String get fieldLabelsTagLabel => 'Tag / ID Number';

  @override
  String get fieldLabelsTagColorLabel => 'Tag Color';

  @override
  String get fieldLabelsAnimalColorLabel => 'Animal Color';

  @override
  String get fieldLabelsBreedLabel => 'Breed';

  @override
  String get fieldLabelsPenLabel => 'Pen';

  @override
  String get fieldLabelsArPlaceholder => 'Arabic label';

  @override
  String get fieldLabelsEnPlaceholder => 'English label';

  @override
  String get fieldLabelsSaveBtn => 'Save Labels';

  @override
  String get fieldLabelsResetAll => 'Reset to Defaults';

  @override
  String get fieldLabelsSaved => 'Saved';

  @override
  String get pensTitle => 'Pens';

  @override
  String get pensEmpty => 'No pens yet';

  @override
  String get pensAddBtn => 'Add Pen';

  @override
  String get pensAddTitle => 'Add Pen';

  @override
  String get pensEditTitle => 'Edit Pen';

  @override
  String get pensNameLabel => 'Pen Name';

  @override
  String get pensNameHint => 'e.g., Adult Sheep Pen';

  @override
  String get pensNameRequired => 'Required';

  @override
  String get pensDeleteTitle => 'Delete Pen?';

  @override
  String get pensDeleteMsg =>
      'This pen will be removed. Assigned animals will not be affected.';

  @override
  String get notificationSettingsTitle => 'Notification Settings';

  @override
  String get notificationVaccination => 'Vaccination Reminders';

  @override
  String get notificationVaccinationDesc =>
      'Alert 3 days before vaccination due';

  @override
  String get notificationDeworming => 'Deworming Reminders';

  @override
  String get notificationDewormingDesc => 'Alert 3 days before deworming due';

  @override
  String get notificationBirth => 'Birth Reminders';

  @override
  String get notificationBirthDesc => 'Alert 14 days before expected delivery';

  @override
  String get notificationWeaning => 'Weaning Reminders';

  @override
  String get notificationWeaningDesc =>
      'Alert when weaning window is approaching';

  @override
  String get dashboardShortcutBahm => 'Young';

  @override
  String get dashboardShortcutVaccination => 'Vaccination';

  @override
  String get dashboardShortcutNearBirth => 'Near Birth';

  @override
  String get dashboardShortcutMales => 'Males';

  @override
  String get dashboardShortcutFemales => 'Females';

  @override
  String get dashboardShortcutBreeding => 'Breeding';

  @override
  String get dashboardShortcutDeceased => 'Deaths';

  @override
  String get dashboardShortcutFattening => 'Fattening';

  @override
  String get dashboardShortcutCheckups => 'Check-ups';

  @override
  String get dashboardShortcutUdhiya => 'Udhiya';

  @override
  String animalIdentity(String tag, String color) {
    return '$tag $color';
  }

  @override
  String get pedigreeTitle => 'Pedigree Tree';

  @override
  String get pedigreeViewBtn => 'Pedigree';

  @override
  String get pedigreeSubject => 'Animal';

  @override
  String get pedigreeParents => 'Parents';

  @override
  String get pedigreeGrandparents => 'Grandparents';

  @override
  String get pedigreeUnknown => 'Unknown';

  @override
  String get pedigreeDam => 'Dam (Mother)';

  @override
  String get pedigreeSire => 'Sire (Father)';

  @override
  String get pedigreeMaternalDam => 'Maternal Dam';

  @override
  String get pedigreeMaternalSire => 'Maternal Sire';

  @override
  String get pedigreePaternaldDam => 'Paternal Dam';

  @override
  String get pedigreePaternaldSire => 'Paternal Sire';

  @override
  String get customFieldsTitle => 'Custom Fields';

  @override
  String get customFieldsEmpty => 'No custom fields added yet';

  @override
  String get customFieldsAddBtn => 'Add Field';

  @override
  String get customFieldLabel => 'Field Label';

  @override
  String get customFieldValue => 'Value';

  @override
  String get customFieldRequired => 'Required';

  @override
  String get customFieldOptional => 'Optional';

  @override
  String get customFieldTypeText => 'Text';

  @override
  String get customFieldTypeNumber => 'Number';

  @override
  String get customFieldTypeSelect => 'Select';

  @override
  String get customFieldTypeBoolean => 'Yes/No';

  @override
  String get countryTemplateRequired => 'Required by your country regulations';

  @override
  String get healthOptionBirth => 'Register Birth';

  @override
  String get healthOptionBirthDesc =>
      'Record birth outcome and number of offspring';

  @override
  String get registerBirthTitle => 'Register Birth';

  @override
  String get registerBirthSelectMother => 'Select Mother';

  @override
  String get registerBirthMotherLabel => 'Mother';

  @override
  String get registerBirthDate => 'Birth Date';

  @override
  String get registerBirthTotal => 'Total Offspring';

  @override
  String get registerBirthMales => 'Males';

  @override
  String get registerBirthFemales => 'Females';

  @override
  String get registerBirthSire => 'Father (optional)';

  @override
  String get registerBirthSireUnknown => 'Unknown';

  @override
  String get registerBirthSave => 'Save Birth Record';

  @override
  String get registerBirthDead => 'Dead / Stillborn';

  @override
  String get registerBirthWeanFrom => 'Wean from age (days)';

  @override
  String get registerBirthWeanTo => 'to age (days)';

  @override
  String get registerBirthNext => 'Next';

  @override
  String registerBirthOffspringOf(int current, int total) {
    return 'Offspring $current of $total';
  }

  @override
  String get registerBirthOffspringGender => 'Gender';

  @override
  String get registerBirthOffspringColor => 'Color';

  @override
  String get registerBirthOffspringTagNumber => 'Tag Number';

  @override
  String get registerBirthOffspringPen => 'Pen (optional)';

  @override
  String get registerBirthSuccessTitle => 'Birth Recorded';

  @override
  String registerBirthSuccessBody(String dam, int count) {
    return '$dam\'s birth — $count offspring recorded';
  }

  @override
  String get animalPickerTitle => 'Select Animals';

  @override
  String get animalPickerSearch => 'Search by tag number or color…';

  @override
  String get animalPickerNone => 'No animals found';

  @override
  String animalPickerApply(int count) {
    return 'Apply ($count)';
  }

  @override
  String animalPickerSelectedLabel(int count) {
    return '$count animal(s) selected';
  }

  @override
  String get animalPickerTap => 'Tap to select animals';

  @override
  String get btnClear => 'Clear';

  @override
  String healthSavedForAnimals(int count) {
    return 'Saved for $count animal(s)';
  }
}
