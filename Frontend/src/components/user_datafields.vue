<template>
              <div class="col col-sm-12 col-md-3 mb-5">
            <div class="m-1 text-start user_datapage" >
              <img v-if="getPermission === 'admin'" src="../assets/img/profile_admin.png" class="img-fluid m-lg-3  " >
              <img v-else-if="getPermission === 'user' && getGender === 'Férfi'" src="../assets/img/profile_male.png" class="img-fluid m-lg-3 ">
              <img v-else-if="getPermission === 'user' && getGender === 'Nő'" src="../assets/img/profile_female.png" class="img-fluid m-lg-3 ">
              <img v-else-if="getPermission === 'user' && getGender === 'Nem adom meg'" src="../assets/img/profile_gender_neutral.png" class="img-fluid m-lg-3">
              <hr>
              <div class="mt-2">Név: <span class=" mt-2">{{ getName }}</span></div>
              <div class="mt-2">E-mail: <span id="email">{{ getEmail }}</span></div>
              <div class="mt-2">Állampolgárság: <span>{{ getCitizenship }}</span></div>
              <div class="mt-2">Születési idő: <span>{{formatDate(getBirthday) }}</span></div>
              <div class="mt-2">Nem:<span>{{ getGender }}</span ></div>
              <label class="btn btn-info mt-3 w-100" for="modal-toggle">Jelszó módosítása</label>
              <template v-if="getPermission === 'user'">
                <form @submit.prevent="deleteUser(getID)">
                  <input type="hidden" name="id" :value="id">
                  <button type="submit" class="btn btn-danger mt-3 w-100" onclick="return confirm('Biztosan törölni szeretné a GO EVENT! profilját?')">Fiók törlése</button>
                </form>
              </template>
              <template v-if="getPermission === 'admin'">
                <button class="btn btn-light mt-3 w-100"><a class="text-dark" href="/adminpage">Adminisztráció</a></button>
              </template>
            </div>
          </div>
</template>


<script>
import axios from 'axios';
import { mapGetters } from 'vuex';

export default {
  methods: {
    deleteUser(getID) {
      axios.delete('/deleteUser/' + getID)
        .then(response => {
          // Sikeres törlés esetén a felhasználói tömb frissítése
          this.users = response.data;
        })
        .catch(error => {
          console.log(error);
        });
        console.log(getID)
    },

    formatDate(dateString) {
      const date = new Date(dateString);
      const options = { year: 'numeric', month: '2-digit', day: '2-digit' };
      return new Intl.DateTimeFormat('hu-HU', options).format(date);
    },
  },

  data() {
        return {
            eventsbyId: [],
        };
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
}
</script>