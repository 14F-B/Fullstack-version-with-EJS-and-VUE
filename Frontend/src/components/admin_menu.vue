<template>
  <div class="mb-3">
     <button class="btn btn-light m-1" @click="downloadPdf('tbl_events')" title="Események exportálása: ctrl+Y">
     <i class="bi bi-calendar-date-fill"></i> <i class="bi bi-filetype-pdf"></i>
     </button>
     <button class="btn btn-light m-1" @click="downloadPdf('tbl_users')" title="Felhasználók exportálása: ctrl+M">
     <i class="bi bi-person"></i> <i class="bi bi-filetype-pdf"></i>
     </button>
     <button id="btn_refresh" type="button" class="btn btn-light m-1" @click="refreshsite()" title="Frissítés: F5">
     <i class="bi bi-arrow-clockwise"></i>
     </button>
     <button id="btn_changeTable" type="button" class="btn btn-light" @click="showcontent()" title="Táblázat váltása: ctrl+B">
     Felhasználók listája
     </button>
     <label class="button btn btn-light m-1" for="modal-toggle">+Új esemény/admin</label>
      <router-link to="/adminpage/scan">
        <button type="button" class="btn btn-light" title="QR Kód olvasó">QR Kód olvasó</button>
      </router-link>  
</div>

  <div>
     <div class="rt-container">
        <div class="col-rt-12">
           <div class="Scriptcontent">
              <input id="modal-toggle" type="checkbox" />
              <label class="modal-backdrop" for="modal-toggle"></label>
              <div class="modal-content">
                 <label class="modal-close-btn" for="modal-toggle">
                    <svg width="30" height="30">
                       <line x1="5" y1="5" x2="20" y2="20" />
                       <line x1="20" y1="5" x2="5" y2="20" />
                    </svg>
                 </label>
                 <div class="tabs">
                    <!--  ESEMÉNY LÉTREHOZÁS  -->
                    <input class="radio" id="tab-addevent" name="tabs-name" type="radio" checked />
                    <label for="tab-addevent" class="table p-2 font-weight-bold">Új esemény létrehozása</label>
                    <div class="tabs-content">
                       <form @submit.prevent="newevent">
                          <input type="text" name="eventName" v-model="eventName" placeholder="Esemény neve" required/>
                          <div class="row">
                             <input class="col-4 d-flex m-2" type="text" name="eventCity" v-model="eventCity" placeholder=" Város" required/>
                             <input class="col-6 d-flex m-2" type="text" name="eventStreet" v-model="eventStreet" placeholder="Utca / hely neve" required/>
                             <input class="col-1 d-flex m-2" type="text" name="eventHno" v-model="eventHno" maxlength="5" placeholder="Hsz."/>
                          </div>
                          <input type="number" name="eventCapacity" v-model="eventCapacity" placeholder="Maximális létszám" min="0" max="50000" required/>
                          <input type="text" name="eventPerformers" v-model="eventPerformers" placeholder="Fellépők nevei vesszővel tagolva" required/>
                          <textarea type="text" name="eventDescription" v-model="eventDescription" placeholder="Esemény leírása" maxlength="255" class="addevent_textarea" required></textarea>
                          <input type="text" name="eventImgURL" v-model="eventImgURL" placeholder="Adja meg az URL címét az illusztrációs képnek" required/>
                          <div class="row">
                             <select class="form-control col d-flex m-2" id="eventCategory" name="eventCategory" v-model="eventCategory" required>
                              <option selected disabled>KATEGÓRIA</option>
                             <option v-for="cat in categoryList" :key="cat">{{ cat }}</option>
                             </select>
                             <select class="form-control col d-flex m-2" id="eventAgelimit" name="eventAgelimit" v-model="eventAgelimit" required>
                              <option selected disabled>KORHATÁR</option>
                              <option v-for="age in ageList" :key="age">{{ age }}</option>
                             </select>
                          </div>
                          <div class="row">
                             <div class="col-sm-6">
                                <div style="text-align: left">
                                   <label class="lbl_date">Esemény ideje:</label>
                                   <input type="datetime-local" name="eventDay" v-model="eventDay" class="form-control" id="evebtdate" placeholder="Születési idő" required/>
                                   <div class="validate"></div>
                                </div>
                             </div>
                             <div class="col-sm-6"><input type="submit" value="Rögzítés" /></div>
                          </div>
                       </form>
                    </div>
                    <!-- ADMIN HOZZÁADÁS  -->
                    <input class="radio" id="tab-newAdmin" name="tabs-name" type="radio" />
                    <label for="tab-newAdmin" class="table p-1 font-weight-bold"
                       >Új Adminisztrátor hozzáadása</label
                       >
                    <div class="tabs-content">
                       <form @submit.prevent="newadmin" >
                          <input type="text" name="name" v-model="name" placeholder="Név" required />
                          <input type="email" name="email" v-model="email" placeholder="Email cím" required />
                          <input type="password" name="password" v-model="password" minlength="8" data-rule="minlen:8" data-msg="A jelszónak 8 karakternek kell lennie!" placeholder="Jelszó" required/>
                          <input type="password" name="password_match" v-model="password_match" minlength="8" data-rule="minlen:8" data-msg="A jelszónak 8 karakternek kell lennie!" placeholder="Jelszó mégegyszer" required/>
                          <select class="form-control" id="citizenship" name="citizenship" value="text" v-model="citizenship" required>
                             <option selected disabled>Válassza ki az állampolgárságát</option>
                             <option v-for="nat in nationalityList" :key="nat">{{ nat }}</option>
                          </select>
                          <div style="text-align: left; color: white">
                             <input type="radio" id="gender_M"  name="gender" v-model="gender" value="Férfi"/>
                             <label for="Sex">Férfi</label>
                             <input type="radio" id="gender_F" name="gender" v-model="gender" value="Nő" />
                             <label for="Sex">Nő</label>
                             <input type="radio" id="gender_O" name="gender" v-model="gender" value="Nem adom meg"/>
                             <label for="Sex">Nem adom meg</label>
                          </div>
                          <div class="row">
                             <div class="col-sm-6">
                                <div style="text-align: left">
                                   <label class="lbl_date">Születési idő: </label>
                                   <input type="date" name="birthday" v-model="birthday" class="form-control" id="date" placeholder="Születési idő" min="1910-01-01"  :max="maxDate" required>
                                   <div class="validate"></div>
                                </div>
                             </div>
                             <div class="col-sm-6">
                                <input type="submit" value="Admin felvétele" />
                             </div>
                          </div>
                       </form>
                    </div>
                 </div>
              </div>
           </div>
        </div>
     </div>
  </div>
</template>

<script>
import axios from "axios";
import jsPDF from 'jspdf';
import 'jspdf-autotable';


export default {
  data(){
    return{
    // Inicializálás
    citizenship: "Magyar",
    eventCategory: null,
    eventAgelimit: null,


    nationalityList:['Magyar','Afganisztáni','Albán','Algériai','Amerikai','Amerikai Csendes-Óceáni-Szigeteki','Andorrai','Angolai','Anguillai','Antarktiszi','AntiguaÉsBarbudai','Argentin','Arubai','Ausztrál','Azerbajdzsáni','Bahama-Szigeteki','Bahreini','Bangladesi','Barbadosi','Belgiumi','Belizei','Belorusz','Benini','Bermudai','Bhutáni','Bolgár','Bolíviai','Boszniai','Botswanai','Bouvet-Szigeti','Brazil','Brit','BritIndiai-ÓceániTerületi','BritVirgin-Szigeteki','BurkinaFasoi','Burmai','Burundi','CapeVerdei','Chilei','Ciprusi','CostaRicai','Csádi','Cseh','Dán','Dél-AfrikaiKöztársasági','Dél-Koreai','Dominikai','DominikaiKözösségi','Dubai','Dzsibuti','Eci','Ecuadori','EgyenlítoiGuineai','EgyesültArabEmirátusi','Egyiptomi','Elefántcsontparti','Eritreai','Észak-Koreai','Észt','Etiópiai','Falkland-Szigeteki','Faroe-Szigeteki','Fidzsi-Szigeteki','Finn','Francia','FranciaDéliTerületeki','FranciaGuyanai','FranciaPolinéziai','Fülöp-Szigeteki','Gaboni','Gambiai','Ghánai','Gibraltári','Görög','Grenadai','Grönlandi','Grúziai','Guatemalai','GuineaBissaui','Guineai','Guyanai','Haiti','Heart-Szigeti','Holland','HollandAntilláki','Hondurasi','HongKongi','Horvá','Indiai','Indonesiai','Ír','Iraki','Iráni','Ismeretlen','Izlandi','Izraeli','Jamaicai','Japán','Jemeni','Jordán','Jugoszláv','Kajmán-Szigeteki','Kambodzsai','Kameruni','Kanadai','Karácsony-Szigeti','Katari','Kazahsztáni','Kenyai','Kínai','Kirgíziai','Kiribati','Kókusz-Szigeteki','Kolumbiai','Komorosi','Kongói','Koszovói','Közép-AfrikaiKöztársasági','Kubai','Kuvaiti','Laoszi','Lengyel','Lesothoi','Lett','Libanoni','Libériai','Líbiai','Liechtensteini','Litván','Luxemburgi','Madagaszkári','Makaói','Makedóniai','Malawi','Malaysiai','Maldiv-Szigeteki','Mali','Máltai','Marokkói','Marschall-Szigeteki','Martiniquei','Mauritániai','Mauritiusi','Mayottei','Mexikói','Moldáviai','Monacoi','Mongól','Montenegroi','Mozambiki','Myanamari','Namibiai','Naraui','Német','Nepáli','Nicaraguai','Nigeri','Nigériai','Niuei','Norfolk-Szigeti','Norvég','Nyugat-Afrikai','Nyugat-Szaharai','Nyugat-Szamoai','Olasz','Omani','Orosz','Osztrák','OtherCountries','Örmény','Pakisztáni','Palaui','Panamai','PápuaÚj-Guineai','Paraguayi','Perui','Pitcairn-Szigeteki','Portugál','PuertoRicoi','Réunioni','Román','Ruandai','SaintLuciai','SaintVincenti','Salamon-Szigeteki','Salvadori','SanMarinoi','SaoToméi','Seychelle-Szigeteki','SierraLeonei','Spanyol','SríLankai','St-PierreÉsMiqueloni','Surinamei','Svájci','Svalbardi','Svéd','Szaud-Arábiai','Szenegáli','SzentIlonai','Szerb','Szingapúri','Szíriai','Szlovák','Szlovén','Szomáliai','Szudani','Szváziföldi','Tadzsikisztáni','Tajvani','Tanzániai','Thaiföldi','Togoi','Tokelau-Szigeteki','Tongai','Török','Trinidadi','Tunéziai','TurksÉsCaicos-Szigeteki','Tuvalui','Türkmenisztáni','Ugandai','Új-Kaledóniai','Új-Zélandi','Ukrán','Unoi','Uruguayi','Üzbegisztáni','Vanuatui','Vatikáni','Venezuelai','Vietnami','WallisÉsFutunai','Zairei','Zambiai','Zimbabwei'],
    categoryList:['Zene (koncert)','Film','Sport','Kultúra','Irodalom','Fesztivál,tematikus napok','Konferencia','Egyéb kategória'],
    ageList:['Korhatár nélküli','12+','16+','18+'],

    // 16 Évnél idősebb regisztrálhat
    maxDate: new Date(new Date().getFullYear() - 16, new Date().getMonth(), new Date().getDate()).toISOString().substr(0, 10)

    };
  },

  created() {
    // Alapértelmezett <option> mezők beállítása
    this.citizenship = this.nationalityList[0];
    this.eventCategory = this.categoryList[0];
    this.eventAgelimit = this.ageList[0];

  },

  methods: {
    async newevent() {
      try {
        const response = await axios.post("/newevent", {
          eventName: this.eventName,
          eventCity: this.eventCity,
          eventStreet: this.eventStreet,
          eventHno: this.eventHno,
          eventCapacity: this.eventCapacity,
          eventPerformers: this.eventPerformers,
          eventDescription: this.eventDescription,
          eventImgURL: this.eventImgURL,
          eventCategory: this.eventCategory,
          eventAgelimit: this.eventAgelimit,
          eventDay: this.eventDay,
        });

        console.log(response.data);
      } catch (error) {
        console.error(error);
      }
      location.reload();

    },

    async newadmin() {
      try {
        const response = await axios.post("/newadmin", {
          name:this.name,
          email: this.email,
          password: this.password,
          password_match:this.password_match,
          citizenship:this.citizenship,
          gender: this.gender,
          birthday:this.birthday
        });

        console.log(response.data);
      } catch (error) {
        console.error(error);
      }
      location.reload();
    },

    // Tartalom blokk váltása
    showcontent() {
      var eventsShow = document.getElementById('eventTable');
      var usersShow = document.getElementById('usersTable');

      // Tartalom elrejtése / Megjelenítése
      if (eventsShow.style.display === 'none') {
        eventsShow.style.display = 'block';
        usersShow.style.display ='none';
      } else {
        eventsShow.style.display = 'none';
        usersShow.style.display ='block';
      }
      // Gomb szövegének megváltoztatása
      var button = document.getElementById("btn_changeTable");
      if (button.textContent === "Események listája") {
        button.textContent = "Felhasználók listája";
      }
      else {
        button.textContent = "Események listája";
      }
    },
    // Exportálás billentyűkombinációkkal
    handleKeyDown(event) {
        if (event.ctrlKey && event.key === 'y') {
          this.downloadPdf('tbl_events');
        } else if (event.ctrlKey && event.key === 'm') {
          this.downloadPdf('tbl_users');
      } else if (event.ctrlKey && event.key === 'b') {
          this.showcontent();
        }
      },
    refreshsite() {
      // Frissítés ikonra kattintás után, weboldal újratöltés
      const refreshButton = document.getElementById("btn_refresh");
      refreshButton.addEventListener("click", function () {
        window.location.reload(true);
      });
    },
    downloadPdf(tableName) {
      // Fekvő tájolás
      const doc = new jsPDF('landscape');
      const tableId = `#${tableName}`;
      doc.autoTable({ html: tableId ,});

      // Fájl neve: Táblanév_ÉÉÉÉ_HH_NN.pdf
      const currentDate = new Date();
      const year = currentDate.getFullYear();
      const month = (currentDate.getMonth() + 1).toString().padStart(2, '0');
      const day = currentDate.getDate().toString().padStart(2, '0');
      const fileName = `${tableName}_${year}_${month}_${day}.pdf`;

      // Mentés
      doc.save(fileName);
    },

    beforeDestroy() {
    document.removeEventListener('keydown', this.handleKeyDown);
    }
  },

  
   mounted() {
     document.addEventListener('keydown', this.handleKeyDown);
   },


};
</script>
