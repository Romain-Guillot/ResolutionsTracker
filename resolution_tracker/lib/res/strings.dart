
/// All strings used in the app
/// TODO : internationalization
class Strings {

  static const APP_NAME = "Resolution tracker";


  static const LOADING_PAGE_INDICATOR = "Please wait, we checked your profile.";

  static const WELCOME_TITLE = "Hi !";
  static const WELCOME_INTRO1 = "You have some new resolutions ?";
  static const WELCOME_INTRO2 = "Great !";
  static const WELCOME_INTRO3 = "Keep track of them with this app !";

  static const PROVIDER_AUTH_BTN = "Continue with";
  static const ALTERNATIVE_AUTH = "Or, sign up or sign in with an";

  static const GOOGLE_PROVIDER = "Google";
  static const MAIL_PROVIDER = "email address";

  static const ADD_RESOLUTION_TITLE_LABEL = "Resolution title";
  static const ADD_RESOLUTION_FREQUENCY_LABEL = "Frequency";
  static const ADD_RESOLTUION_ICON_LABEL = "Add an icon";
  static const ADD_RESOLUTION_SUBMIT = "Save my resolution";
  static const ADD_RESOLUTION_TITLE_EMPTY_ERROR = "Please enter the title of your resolution.";
  static const ADD_RESOLUTION_ERROR = "An error occured, please try again";
  static ADD_RESOLUTION_SUCCESS(String e) => "Resolution $e successfully added";

  static const DELETE_RESOLUTION_TITLE = "Are you sure ?";
  static const DELETE_RESOLUTION_INFO = "Your resolution and all the progress associated with it will be permanently erased.";

  static const DELETE_ACCOUNT_TITLE = "Are you sure ?";
  static const DELETE_ACCOUNT_INFO = "Your account and all associated data will be permanently deleted. You will never be able to recover your resolutions again.";

  static STREAK_RESOLUTION(int quantity) => (quantity <= 1 ? "week" : "weeks") + "without break";


  

}