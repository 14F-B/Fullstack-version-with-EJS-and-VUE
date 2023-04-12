<template>
      <div class="rt-container">
        <div class="col-rt-12">
            <div class="Scriptcontent">
              <input id="modal-toggle" type="checkbox">
              <label class="modal-backdrop" for="modal-toggle"></label>
              <div class="modal-content">
              <label class="modal-close-btn" for="modal-toggle">
                <svg width="30" height="30"><line x1="5" y1="5" x2="20" y2="20"/><line x1="20" y1="5" x2="5" y2="20"/></svg>
              </label>
        <div class="tabs">
            <input class="radio " id="tab-addevent" name="tabs-name" type="radio" checked>
            <label for="tab-addevent" class="table d-none"></label>
                <div  class=" tabs-content">
                    <span>Új jelszó beállítása</span>
                        <form @submit.prevent="submitForm">
                          <input type="password" v-model="password_old" placeholder="Add meg a jelenlegi jelszót!" required>
                          <input type="password" v-model="password_new" placeholder="Add meg az új jelszót!" required>
                          <input type="password" v-model="password_new_match" placeholder="Add meg az új jelszót!" required>
                          <div class="col-sm-6 d-flex justify-content-end">
                            <input type="submit" value="Mentés">
                          </div>
                        </form>
                    </div>
                </div>
            </div>
        </div>
    </div>
</div>
</template>

<script>
import axios from 'axios';
import { mapGetters } from 'vuex';

export default {
    data() {
  return {
    id:'',
    password_old:'',
    password_new: '',
    password_new_match:'',
  }
},

  methods: {
    submitForm() {
      axios.put('/refreshPassword', {
        id:this.getID,
        password_old: this.password_old,
        password_new: this.password_new,
        password_new_match: this.password_new_match
      })
      .then(response => {
        // Ha a jelszóváltoztatás sikeres volt, akkor valamilyen felugró ablakban
        // értesíthetjük a felhasználót és/vagy visszairányíthatjuk a felhasználót
        // a felhasználói oldalra.
        console.log(response)
      })
      .catch(error => {
        console.log(error);
      });
      location.reload();
    }
  },
  computed: {
    ...mapGetters([
      'getID',
    ])},
}
</script>