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
const String ADD_DEMISE = "Aggiungi decesso";
const String CANCEL = "Annulla";
const String ATTENTION = "Attenzione";
const String MY_PRODUCTS = "I miei prodotti";
const String DEATHS_INSERT= "Decessi inseriti";
const String NAME = "Nome";
const String PHONE_NUMBER = "Telefono";
const String CITY = "Città";
const String PRICE = "Prezzo";
const String DESCRIPTION = "Descrizione";
const String LAST_NAME = "Cognome";
const String EDIT_USER = "Modifica utente";
const String EDIT_PRODUCT = "Modifica prodotto";
const String EDIT_PROFILE = "Modifica profilo";
const String EDIT_DEMISE = "Modifica decesso";
const String EDIT_AGENCY = "Modifica agenzia";
const String SAVE = "Salva";
const String USER_DETAIL = "Dettaglio utente";
const String PRODUCT_DETAIL = "Dettaglio prodotto";
const String DEMISE_DETAIL = "Dettaglio decesso";
const String AGENCY_DETAIL = "Dettaglio azienda";
const String CHURCH_NAME = "Nome chiesa";
const String CHURCH_ADDRESS = "Indirizzo chiesa";
const String AGE = "Età";
const String WAKE_HOUR = "Orario veglia";
const String WAKE_DATE = "Data veglia";
const String WAKE_NOTE = "Note veglia";
const String FUNERAL_HOUR = "Orario funeral";
const String FUNERAL_DATE = "Data funeral";
const String FUNERAL_NOTE = "Note funeral";
const String ADDRESS = "Indirizzo";
const String RELATIVE_NUMBER = "Numero parente";
const String INSERT_PHOTO = "Tocca per caricare una foto";
const String MY_PROFILE = "Il mio profilo";
const String DELETE_ACCOUNT = "Elimina account";
const String SELECT_PRODUCTS = "Seleziona prodotti";
const String PHOTO = "Foto";


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
  ADD_DEMISE:'Aggiungi decesso',
  CANCEL:'Annulla',
  ATTENTION:'Attenzione',
  MY_PRODUCTS:'I miei prodotti',
  DEATHS_INSERT:'Decessi inseriti',
  NAME:"Nome",
  PHONE_NUMBER:"Telefono",
  EMAIL:"Email",
  CITY:"Città",
  DESCRIPTION:"Descrizione",
  PRICE:"Prezzo",
  LAST_NAME:"Cognome",
  EDIT_USER:"Modifica utente",
  EDIT_PRODUCT:"Modifica prodotto",
  EDIT_DEMISE:"Modifica decesso",
  EDIT_AGENCY:"Modifica agenzia",
  SAVE:"Salva",
  USER_DETAIL:"Dettaglio utente",
  DEMISE_DETAIL:"Dettaglio decesso",
  PRODUCT_DETAIL:"Dettaglio prodotto",
  AGENCY_DETAIL:"Dettaglio agenzia",
  CHURCH_ADDRESS:"Indirizzo chiesa",
  CHURCH_NAME:"Nome chiesa",
  AGE:"Età",
  WAKE_HOUR:"Orario veglia",
  WAKE_DATE:"Data veglia",
  WAKE_NOTE:"Note veglia",
  FUNERAL_HOUR:"Orario funerale",
  FUNERAL_DATE:"Data funerale",
  FUNERAL_NOTE:"Note funerale",
  ADDRESS:"Indirizzo",
  RELATIVE_NUMBER:"Numero parente",
  INSERT_PHOTO: "Tocca per caricare una foto",
  MY_PROFILE: "Il mio profilo",
  EDIT_PROFILE: "Modifica profilo",
  DELETE_ACCOUNT: "Elimina account",
  SELECT_PRODUCTS: "Seleziona prodotti",
  PHOTO: "Foto",

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


//TODO aggiunti per far funzionare la form di registrazione
const String FIRSTNAME = "Nome";
const String LASTNAME = "Cognome";
const String SIGNUP = "Registrati";
const String ALREDY_HAVE_ACCOUNT = "Hai già un account?";
const String SIGNIN = "Accedi";