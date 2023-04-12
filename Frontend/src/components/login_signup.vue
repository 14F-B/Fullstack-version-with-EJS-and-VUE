<template class="overflow-hidden">
  <div>
     <div class="rt-container">
        <div class="col-rt-12">
           <div class="Scriptcontent">
              <input id="modal-toggle" type="checkbox">
              <label class="modal-backdrop" for="modal-toggle"></label>
              <div class="modal-content">
                 <label class="modal-close-btn" for="modal-toggle">
                    <svg width="30" height="30">
                       <line x1="5" y1="5" x2="20" y2="20"/>
                       <line x1="20" y1="5" x2="5" y2="20"/>
                    </svg>
                 </label>
                 <div class="tabs">
                    <!--  BEJELENTKEZÉSI RÉSZ  -->
                    <!-- <div class="border border-danger text-danger p-2">
                       <i class="bi bi-exclamation-octagon-fill"></i>
                       <strong>  FIGYELMEZTETŐ SZÖVEG </strong>
                    </div> -->
                    <input class="radio" id="tab-login" name="tabs-name" type="radio" checked>
                    <label for="tab-login" class="table"><span>Bejelentkezés</span></label>
                    <div class="tabs-content">
                       <form @submit.prevent="login">
                          <input type="email" v-model="email" placeholder="Email cím" required>
                          <input type="password" v-model="password" placeholder="Jelszó" required>
                          <input type="submit" value="Bejelentkezés">
                       </form>
                       <!-- ELFELEJTETT JELSZÓ -->
                       <form class="forgot-password"  @submit.prevent="forgotpassword">
                          <input id="forgot-password-toggle" type="checkbox">
                          <label for="forgot-password-toggle">Elfelejtetted jelszavad?</label>
                          <div class="forgot-password-content">
                             <input type="email" name="email" v-model="email" placeholder="Add meg az e-mail címed, amivel regisztráltál" required>
                             <input type="submit" value="Küldés">
                          </div>
                       </form>
                    </div>
                    <!-- REGISZTRÁCIÓS RÉSZ  -->
                    <input class="radio" id="tab-signup" name="tabs-name" type="radio">
                    <label for="tab-signup" class="table"><span>Regisztráció</span></label>
                    <div class="tabs-content">
                       <form @submit.prevent="signup">
                          <input type="text" name="name" v-model="name" placeholder="Név" required>
                          <input type="email" name="email" v-model="email" placeholder="Email cím" required>
                          <input  type="password" name="password" v-model="password" minlength="8" data-rule="minlen:8" data-msg="A jelszónak 8 karakternek kell lennie!" placeholder="Jelszó" required>
                          <input  type="password" name="password_match" v-model="password_match" minlength="8" data-rule="minlen:8" data-msg="A jelszónak 8 karakternek kell lennie!" placeholder="Jelszó mégegyszer" required>
                          <select class="form-control" id="citizenship" name="citizenship" value="text" v-model="citizenship" required>
                             <option selected disabled>Válassza ki az állampolgársága</option>
                             <option v-for="nat in nationality" :key="nat">{{ nat }}</option>
                          </select>
                          <div style="text-align: left;">
                             <input type="radio" id="gender_M" name="gender" v-model="gender" value="Férfi" required />
                             <label for="Sex">Férfi</label>
                             <input type="radio" id="gender_F" name="gender" v-model="gender"  value="Nő" />
                             <label for="Sex">Nő</label>
                             <input type="radio" id="gender_O" name="gender" v-model="gender" value="Nem adom meg" />
                             <label for="Sex">Nem adom meg</label>
                          </div>
                          <div class="row">
                             <div class="col-sm-6">
                                <div style="text-align: left;">
                                   <label class="lbl_date">Születési idő: </label>
                                   <input type="date" name="birthday" v-model="birthday" class="form-control" id="date" placeholder="Születési idő" min="1910-01-01" max="2015-01-01" required>
                                   <div class="validate"></div>
                                </div>
                             </div>
                             <div class="col-sm-6"><input type="submit" value="Regisztrálás"></div>
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
import axios from 'axios';


export default {
  data() {
    return {
      email: '',
      password: '',
      nationality:['Magyar','Afganisztáni','Albán','Algériai','Amerikai','Amerikai Csendes-Óceáni-Szigeteki','Andorrai','Angolai','Anguillai','Antarktiszi','Antigua És Barbudai','Argentin','Arubai','Ausztrál','Azerbajdzsáni','Bahama-Szigeteki','Bahreini','Bangladesi','Barbadosi','Belgiumi','Belizei','Belorusz','Benini','Bermudai','Bhutáni','Bolgár','Bolíviai','Boszniai','Botswanai','Bouvet-Szigeti','Brazil','Brit','BritIndiai-ÓceániTerületi','BritVirgin-Szigeteki','BurkinaFasoi','Burmai','Burundi','CapeVerdei','Chilei','Ciprusi','CostaRicai','Csádi','Cseh','Dán','Dél-AfrikaiKöztársasági','Dél-Koreai','Dominikai','DominikaiKözösségi','Dubai','Dzsibuti','Eci','Ecuadori','EgyenlítoiGuineai','EgyesültArabEmirátusi','Egyiptomi','Elefántcsontparti','Eritreai','Észak-Koreai','Észt','Etiópiai','Falkland-Szigeteki','Faroe-Szigeteki','Fidzsi-Szigeteki','Finn','Francia','FranciaDéliTerületeki','FranciaGuyanai','FranciaPolinéziai','Fülöp-Szigeteki','Gaboni','Gambiai','Ghánai','Gibraltári','Görög','Grenadai','Grönlandi','Grúziai','Guatemalai','GuineaBissaui','Guineai','Guyanai','Haiti','Heart-Szigeti','Holland','HollandAntilláki','Hondurasi','HongKongi','Horvá','Indiai','Indonesiai','Ír','Iraki','Iráni','Ismeretlen','Izlandi','Izraeli','Jamaicai','Japán','Jemeni','Jordán','Jugoszláv','Kajmán-Szigeteki','Kambodzsai','Kameruni','Kanadai','Karácsony-Szigeti','Katari','Kazahsztáni','Kenyai','Kínai','Kirgíziai','Kiribati','Kókusz-Szigeteki','Kolumbiai','Komorosi','Kongói','Koszovói','Közép-AfrikaiKöztársasági','Kubai','Kuvaiti','Laoszi','Lengyel','Lesothoi','Lett','Libanoni','Libériai','Líbiai','Liechtensteini','Litván','Luxemburgi','Madagaszkári','Makaói','Makedóniai','Malawi','Malaysiai','Maldiv-Szigeteki','Mali','Máltai','Marokkói','Marschall-Szigeteki','Martiniquei','Mauritániai','Mauritiusi','Mayottei','Mexikói','Moldáviai','Monacoi','Mongól','Montenegroi','Mozambiki','Myanamari','Namibiai','Naraui','Német','Nepáli','Nicaraguai','Nigeri','Nigériai','Niuei','Norfolk-Szigeti','Norvég','Nyugat-Afrikai','Nyugat-Szaharai','Nyugat-Szamoai','Olasz','Omani','Orosz','Osztrák','OtherCountries','Örmény','Pakisztáni','Palaui','Panamai','PápuaÚj-Guineai','Paraguayi','Perui','Pitcairn-Szigeteki','Portugál','PuertoRicoi','Réunioni','Román','Ruandai','SaintLuciai','SaintVincenti','Salamon-Szigeteki','Salvadori','SanMarinoi','SaoToméi','Seychelle-Szigeteki','SierraLeonei','Spanyol','SríLankai','St-PierreÉsMiqueloni','Surinamei','Svájci','Svalbardi','Svéd','Szaud-Arábiai','Szenegáli','SzentIlonai','Szerb','Szingapúri','Szíriai','Szlovák','Szlovén','Szomáliai','Szudani','Szváziföldi','Tadzsikisztáni','Tajvani','Tanzániai','Thaiföldi','Togoi','Tokelau-Szigeteki','Tongai','Török','Trinidadi','Tunéziai','TurksÉsCaicos-Szigeteki','Tuvalui','Türkmenisztáni','Ugandai','Új-Kaledóniai','Új-Zélandi','Ukrán','Unoi','Uruguayi','Üzbegisztáni','Vanuatui','Vatikáni','Venezuelai','Vietnami','WallisÉsFutunai','Zairei','Zambiai','Zimbabwei',]
    
    };
  },
  methods: {
    async login() {
  try {
    await this.$store.dispatch('login', {
      email: this.email,
      password: this.password,
      gender: this.gender,
      citizenship: this.citizenship,
      birthday: this.birthday,
      id: this.id,
      name: this.name,
    });
  } catch (error) {
    console.error(error);
  }
},
    async signup() {
      try {
        const response = await axios.post('/signup', {
          name: this.name,
          email: this.email,
          password: this.password,
          password_match: this.password_match,
          citizenship: this.citizenship,
          gender: this.gender,
          birthday: this.birthday
        });
        console.log(response.data);

      } catch (error) {
        console.error(error);
      }
    },

    async forgotpassword() {
      try {
        const response = await axios.put('/forgotpassword', {
          email: this.email,
        });
        console.log(response.data);

      } catch (error) {
        console.error(error);
      }
    },
  },

  
  mounted() {
    this.citizenship = this.nationality[0];
  }
};
</script>