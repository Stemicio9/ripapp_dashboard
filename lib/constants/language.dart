String? getCurrentLanguageValue(String field) {
  // una cosa per capire in che lingua è il telefono
  // cerca la stringa in base a quella lingua
  return LANG_IT[field];
}

const String USERS_MANAGE = "Gestisci utenti";
const String AGENCIES_MANAGE = "Gestisci agenzie";
const String PRODUCTS_MANAGE = "Gestisci prodotti";
const String BACK = "Totna indietro";
const String EMAIL = "Email";
const String PASSWORD_RECOVERY = "Recupera password";
const String LOGIN= "Login";
const String FORGOT_PASSWORD = "Hai dimenticato la password?";
const String CONFIRM = "Conferma";
const String PASSWORD = "Password";
const String ADMIN = "AMMINISTRAZIONE";
const String ADD_USER = "Aggiungi utente";
const String ADD_AGENCY = "Aggiungi agenzia";
const String ADD_PRODUCT = "Aggiungi prodotto";
const String CANCEL = "Annulla";
const String ATTENTION = "Attenzione";



final Map<String, String> LANG_IT = {
  BACK:'Torna indietro',
  PASSWORD_RECOVERY:'Recupera password',
  FORGOT_PASSWORD:'Hai dimenticato la password?',
  CONFIRM:'Conferma',
  LOGIN:"Login",
  EMAIL:'Email',
  PASSWORD:'Password',
  ADMIN:'AMMINISTRAZIONE',
  ADD_USER:'Aggiungi utente',
  ADD_AGENCY:'Aggiungi agenzia',
  ADD_PRODUCT:'Aggiungi prodotto',
  CANCEL:'Annulla',
  ATTENTION:'Attenzione',

  //navbar title
  USERS_MANAGE: "Gestisci utenti",
  PRODUCTS_MANAGE: "Gestisci prodotti",
  AGENCIES_MANAGE: "Gestisci agenzie",

};


final Map<String, String> LANG_EN = {
  LOGIN:"Login",
  EMAIL:'Email',

};


// image constants
const String LOGO_IMAGE_NAME = "logo-white.png";