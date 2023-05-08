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
                       <div ref="errorDiv"></div>
                        <form @submit.prevent="refreshpassword">
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
      id: '',
      password_old: '',
      password_new: '',
      password_new_match: '',
      errorDiv: null
    }
  },
  methods: {
    refreshpassword() {
      return new Promise((resolve, reject) => {
        axios.put('/refreshPassword', {
          id: this.getID,
          password_old: this.password_old,
          password_new: this.password_new,
          password_new_match: this.password_new_match
        })
       .then(response => {
          console.log(response.data);
          this.responseData = response.data;
          // Sikeres válasz esetén kiírjuk a sikeres üzenetet a nextTick használatával
          this.$nextTick(() => {
            // Az osztályok törlése az errorDiv elemről
            this.errorDiv.classList.remove('border-danger', 'border-info','text-danger','text-info');
            this.errorDiv.innerHTML = '<i class="bi bi-check-circle-fill"></i>'+response.data.message;
            this.errorDiv.classList.add('border', 'border-info', 'text-info', 'p-2', 'col-8', 'text-start');
          });
          resolve(response);
        })
        .catch(error => {
          console.error(error);
          // Sikertelen válasz esetén kiírjuk a sikertelen üzenetet a nextTick használatával
          this.$nextTick(() => {
            // Az osztályok törlése az errorDiv elemről
            this.errorDiv.classList.remove('border-info', 'border-info','text-danger','text-info');
            this.errorDiv.innerHTML = '<i class="bi bi-exclamation-octagon-fill"></i>' + '  '+error.response.data.message;
            this.errorDiv.classList.add('border', 'border-danger', 'text-danger', 'p-2', 'col-8', 'text-start');
          });
          reject(error);
        });
      });
    }
  },
  computed: {
    ...mapGetters([
      'getID',
    ])
  },
  mounted() {
    // Az errorDiv referenciájának beállítása a mounted (életciklus) metódusban
    this.errorDiv = this.$refs.errorDiv;
  }
}
</script>