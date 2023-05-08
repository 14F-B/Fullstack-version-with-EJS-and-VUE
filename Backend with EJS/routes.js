const router = require('express').Router();
const passport = require("passport");
const bcrypt = require('bcrypt')


// Config
const connection = require('./Config/database');


// Middlewares
const checkAuthenticated = require('./Middlewares/checkAuthenticated');
const checkNotAuthenticated = require('./Middlewares/checkNotAuthenticated');


// Controllers
// API hívások
const { AllEvents, getUsers, getAppliedEvents} = require('./Controllers/queryController');

//Bejelentkezés és regisztrációs folyamatok
const {signUp,forgotPassword,changePassword } = require("./Controllers/authController"); 

//Adminisztrációs folyamatok
const {AddNewEvent,AddNewAdmin,deleteEvent } = require("./Controllers/adminController");

//Felhasználói folyamatok
const { deleteUserById,applyToLocation, cancelApplication, contactForm } = require('./Controllers/userController');

//Callback
const { callbackPromise } = require("nodemailer/lib/shared");


/****************************************************************************
************************* G e t   r e q u e s t s ***************************
****************************************************************************/

// Homepage
router.get("/",async(req, res) => {
  try {
      const eventArray = await AllEvents();
      res.render("pages/HomeView", {islogin: req.isAuthenticated(),eventArray}, 
      );

  } catch (error) {
    console.log(error);
    res.send('Hiba az adatok letöltése során! (Adatbázis hiba)');
  }
 });
// Adminisztrációs felület
router.get("/adminpage", checkAuthenticated, async (req, res) => {
  try {
    const eventArray = await AllEvents();
    const usersArray = await getUsers();
    res.render("pages/AdminPage", {
      title: "Adminisztráció",
      islogin: req.isAuthenticated(),
      isAdmin: req.user.permission,
      eventArray, usersArray
      
    });
  } catch (error) {
    console.log(error);
    res.send('Hiba az adatok letöltése során! (Adatbázis hiba)');
  }
});


// Felhasználói fiók
router.get("/userpage",checkAuthenticated,async (req, res) => {
  const formattedDate = new Intl.DateTimeFormat('hu-HU', { dateStyle: 'short' }).format(new Date(req.user.birthdate)); // Dátum formázása magyar formátumra
  const appliedEvents =await getAppliedEvents(req.user.id)
  res.render("pages/UserPage", {
    id: req.user.id,
    name: req.user.name,
    email: req.user.email,
    citizenship: req.user.nationality,
    birthday: formattedDate,
    gender: req.user.gender,
    isAdmin: req.user.permission,
    islogin: req.isAuthenticated(),
    appliedEvents,
  });
});

// Adatvédelmi oldal
router.get("/adatvedelem", (req, res) => {
  res.render("pages/Adatvedelem", { title: "Adatvédelem", islogin: req.isAuthenticated()});
});

// API Dokumentáció 
router.get("/docs", (req, res) => {
  res.render("pages/api_docs", { title: "GO EVENT! - API Service" });
});



// Bejelentkezéshez szükséges aloldalak
router.get("/signup", checkNotAuthenticated, (req, res) => {
  res.render("pages/HomeView", { title: "GO EVENT! - Home" ,islogin: req.isAuthenticated()});
});


// Új adminisztrátor rögzítése
router.get("/newadmin", checkAuthenticated, (req, res) => {
  res.render("pages/AdminPage", { title: "GO EVENT! - Adminisztráció",islogin: req.isAuthenticated() });
});

/****************************************************************************
************************ P o s t   r e q u e s t s **************************
****************************************************************************/

// Bejelentkezés
router.post("/login",checkNotAuthenticated,
  passport.authenticate("local", {
    successRedirect: "/",
    failureRedirect: "/",
    failureFlash: true,
  })
);

router.post("/signup", checkNotAuthenticated, signUp(connection));   // Általános hozzáférésű regisztráció  (POST)
router.post("/newadmin", checkAuthenticated,  AddNewAdmin(connection));  // Adminisztráció: Új admin hozzáadása  (POST)
router.post("/addevent",   checkAuthenticated, AddNewEvent(connection)); // Adminisztráció: Esemény létrehozása  (POST)

// Kapcsolati űrlap tartalmának továbbítása emailben
router.post("/", (req, res, ) => { 
  contactForm(req.body.senderName, req.body.senderEmail, req.body.subject, req.body.message);
  res.redirect("/#contact")
});


// Események és felhasználók törlése adatbázisból
router.post('/eventdelete',checkAuthenticated, (req, res) => { 
  deleteEvent(req.body.id)

  res.redirect('/AdminPage');
});

// Fiók törlése admin felületről
router.post('/deleteuser',checkAuthenticated, (req, res) => {
  deleteUserById(req.body.id);

  res.redirect('/AdminPage');
});

// Fiók törlése UserPage oldalon (Csak user joggal rendelkezőknek!)
router.post('/deleteAccount', checkAuthenticated, (req, res) => {
  deleteUserById(req.body.id);
  req.logout(req.user, (err) => {
    if (err) return next(err);
  
  res.redirect('/');
  
});
})

// Jelszó frissítése
router.post('/refreshPassword',checkAuthenticated, (req, res) => {
  changePassword(req.user.id, req.body.password_old, req.body.password_new, req.body.password_new_match,callbackPromise);
  res.redirect('/UserPage'); 
});

// Elfelejtett jelszó (Új jelszó igénylése)
router.post('/forgotPassword', (req, res) => {
  forgotPassword(req.body.email); 
  res.redirect('/'); 
});

// Jelentkezés egy eseményre
router.post('/applyToLocation',checkAuthenticated, (req, res) => {
  const mergedata = req.body.locationId.split(";");;
  const locationId = parseInt(mergedata[0])
  const userAge= Math.round((new Date(mergedata[2])-new Date(req.user.birthdate)) / (1000 * 60 * 60 * 24 * 365.25));
  const eventAge= parseInt(mergedata[3]);
  const eventId= parseInt(mergedata[1])

  applyToLocation(locationId,req.user.id,eventId,userAge,eventAge,req.user.email); 
  res.redirect('/#actually');
  
});

// Jelentkezés visszamondása
router.post('/cancelApplication',checkAuthenticated, (req, res) => {
  const mergedata = req.body.locationId.split(";");;
  const locationId = parseInt(mergedata[0])
  const eventId= parseInt(mergedata[1])

  cancelApplication(locationId,req.user.id,eventId,req.user.email); 
  res.redirect('/userpage'); 
});


/****************************************************************************
********************** D e l e t e   r e q u e s t s ************************
****************************************************************************/

// Kijelentkezés  (DELETE)
router.delete("/logout",checkAuthenticated, (req, res) => {
  req.logout(req.user, (err) => {
    if (err) return next(err);
    res.redirect("/");
  });
});



module.exports = router;