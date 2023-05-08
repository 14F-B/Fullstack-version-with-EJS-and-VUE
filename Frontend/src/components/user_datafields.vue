<template>
    <div class="col col-sm-12 col-md-auto mb-5">
    <div class="m-1 text-start user_datapage" style="max-width: 300px;">
        <img v-if="getPermission === 'admin'" src="../assets/pictures/profile_admin.png" class="img-fluid m-lg-3  " >
        <img v-else-if="getPermission === 'user' && getGender === 'Férfi'" src="../assets/pictures/profile_male.png" class="img-fluid m-lg-3 ">
        <img v-else-if="getPermission === 'user' && getGender === 'Nő'" src="../assets/pictures/profile_female.png" class="img-fluid m-lg-3 ">
        <img v-else-if="getPermission === 'user' && getGender === 'Nem adom meg'" src="../assets/pictures/profile_gender_neutral.png" class="img-fluid m-lg-3">
        <hr>
          <div class="mt-2">Név: <span class="mt-2 col-md-auto">{{ getName }}</span></div>
          <div class="mt-2">E-mail: <span class="mt-2 col-md-auto" id="email">{{ getEmail }}</span></div>
          <div class="mt-2">Állampolgárság: <span class="mt-2 col-md-auto">{{ getCitizenship }}</span></div>
          <div class="mt-2">Születési idő: <span class="mt-2 col-md-auto">{{formatDate(getBirthday) }}</span></div>
          <div class="mt-2">Nem:<span class="mt-2 col-md-auto">{{ getGender }}</span ></div>
          <label class="btn btn-info mt-3 w-100" for="modal-toggle">Jelszó módosítása</label>
           
          <div v-if="getPermission === 'user'">
            <form @submit.prevent="deleteUser(getID)">
              <input type="hidden" name="id" :value="id">
              <button type="submit" class="btn btn-danger mt-3 w-100">Fiók törlése</button>
            </form>
          </div>

          <div v-if="getPermission === 'admin'">
            <button class="btn btn-light mt-3 w-100"><a class="text-dark" ref="adminButton">Adminisztráció</a></button>
          </div>
        </div>
    </div>
</template>


<script>
import axios from 'axios';
import { mapGetters } from 'vuex';

export default {
  methods: {
    deleteUser(getID) {
      if (confirm('Biztosan törölni szeretné a GO EVENT! profilját?')) {
      axios.delete('/deleteUser/' + getID)
        .then(response => {
          // Sikeres törlés esetén a felhasználói tömb frissítése
          this.users = response.data;
        })
        .catch(error => {
          console.log(error);
        });
        console.log(getID)
    }
  },
    formatDate(dateString) {
      const date = new Date(dateString);
      const options = { year: 'numeric', month: '2-digit', day: '2-digit' };
      return new Intl.DateTimeFormat('hu-HU', options).format(date);
    },
  },


computed: {
    ...mapGetters([
      'getID',
      'getEmail',
      'getPassword',
      'getName',
      'getCitizenship',
      'getGender',
      'getBirthday',
      'getPermission'
    ])},
   mounted() {
    // Gomb elérése a DOM-ban a ref segítségével
    const adminButton = this.$refs.adminButton;

    // Eseménykezelő hozzáadása a gombhoz
    adminButton.addEventListener("click", () => {
      window.location.href = "/adminpage";       // Átirányítás az "/adminpage" oldalra
    });
    
    }
}
</script>

<style>
.form-control:disabled, .form-control:read-only {
    background-color: #1a1a1a;
    opacity: 1;
}
</style>