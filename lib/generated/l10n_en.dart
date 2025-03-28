// ignore: unused_import
import 'package:intl/intl.dart' as intl;
import 'l10n.dart';

// ignore_for_file: type=lint

/// The translations for English (`en`).
class AppLocalizationsEn extends AppLocalizations {
  AppLocalizationsEn([String locale = 'en']) : super(locale);

  @override
  String get authenticateWithBiometrics => 'Authenticate using your biometrics';

  @override
  String get biometricsNotSupported => 'Your device does not support biometric authentication';

  @override
  String get biometricsNotConfigured => 'No biometrics configured on this device';

  @override
  String get biometricsError => 'Error while attempting biometric authentication';

  @override
  String get biometricsFailed => 'Biometric authentication failed';

  @override
  String get noSavedCredentials => 'No saved credentials found. Please log in manually first.';

  @override
  String get loginWithBiometrics => 'Login with biometrics';

  @override
  String get settings => 'Settings';

  @override
  String get darkMode => 'Dark Mode';

  @override
  String get language => 'Language';

  @override
  String get profile => 'Profile';

  @override
  String get editProfile => 'Edit name and photo';

  @override
  String get notifications => 'Notifications';

  @override
  String get configureAlerts => 'Configure alerts';

  @override
  String get about => 'About';

  @override
  String get version => 'Version 1.0.0';

  @override
  String get logout => 'Logout';

  @override
  String get reports => 'Reports';

  @override
  String get workDate => 'Work Date';

  @override
  String get selectDate => 'Select a date';

  @override
  String get serviceDescription => 'Service Description';

  @override
  String get enterDescription => 'Enter a description';

  @override
  String get issuesFoundOptional => 'Issues Found (optional)';

  @override
  String get enterEmail => 'Enter an email';

  @override
  String get invalidEmail => 'Please enter a valid email';

  @override
  String get enterPassword => 'Enter a password';

  @override
  String get passwordTooShort => 'Password must be at least 6 characters';

  @override
  String get loginFailed => 'Login failed';

  @override
  String get loginButton => 'Log In';

  @override
  String get noAccountRegister => 'Don\'t have an account? Register';

  @override
  String get status => 'Status';

  @override
  String get completed => 'Positive';

  @override
  String get pending => 'Neutral';

  @override
  String get inProgress => 'Negative';

  @override
  String get selectStatus => 'Select a status';

  @override
  String get submitReport => 'Submit Report';

  @override
  String get reportSubmittedSuccess => 'Report submitted successfully!';

  @override
  String get reportSubmissionError => 'Error submitting report';

  @override
  String get register => 'Register';

  @override
  String get name => 'Name';

  @override
  String get enterName => 'Enter a name';

  @override
  String get email => 'Email';

  @override
  String get password => 'Password';

  @override
  String get registerButton => 'Register';

  @override
  String get alreadyHaveAccount => 'Already have an account? Log in';

  @override
  String get registrationSuccess => 'Registration successful! Please log in.';

  @override
  String get registrationFailed => 'Registration failed';

  @override
  String get viewItems => 'View Items';

  @override
  String get calendar => 'Calendar';

  @override
  String get add => 'Add';

  @override
  String get manageItems => 'Manage Items';

  @override
  String get addItem => 'Add Item';

  @override
  String get noItems => 'No items found';

  @override
  String get errorLoading => 'Error loading items';

  @override
  String get retry => 'Retry';

  @override
  String get deleteSuccess => 'Item deleted successfully';

  @override
  String get deleteError => 'Error deleting item';

  @override
  String scheduleFor(Object date) {
    return 'Schedule for $date';
  }

  @override
  String get personName => 'Person\'s Name';

  @override
  String get cancel => 'Cancel';

  @override
  String get scheduleToday => 'Today\'s Schedule';

  @override
  String get editItem => 'Edit Item';

  @override
  String get equipmentUpdatedSuccess => 'Equipment updated successfully';

  @override
  String get updateEquipment => 'Update Equipment';

  @override
  String equipmentAddError(Object error) {
    return 'Error adding equipment: $error';
  }

  @override
  String scheduleNotificationMessage(Object person) {
    return 'Hello, $person! You are scheduled today.';
  }

  @override
  String scheduledFor(Object date) {
    return 'Scheduled for $date';
  }

  @override
  String get addItems => 'Add Items';

  @override
  String get title => 'Title';

  @override
  String get enterTitle => 'Enter a title';

  @override
  String get subtitle => 'Subtitle';

  @override
  String get enterSubtitle => 'Enter a subtitle';

  @override
  String get price => 'Price (R\$)';

  @override
  String get enterPrice => 'Enter a price';

  @override
  String get enterValidPrice => 'Enter a valid price';

  @override
  String get imageUrlOptional => 'Image URL (optional)';

  @override
  String get linkOptional => 'Link (optional)';

  @override
  String get urgency => 'Urgency';

  @override
  String get high => 'High';

  @override
  String get medium => 'Medium';

  @override
  String get low => 'Low';

  @override
  String get selectUrgency => 'Select urgency';

  @override
  String get mostUrgent => 'Most Urgent';

  @override
  String get addEquipment => 'Add Equipment';

  @override
  String get equipmentAddedSuccess => 'Equipment added successfully!';

  @override
  String get login => 'Login';
}
