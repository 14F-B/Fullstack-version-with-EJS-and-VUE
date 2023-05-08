<template>
    <div class="mt-5 col col-sm-12 col-md-8" >
    <h3 class="text-start text-uppercase">Eseményeim</h3>

    <div  style="overflow-y: auto;">
    <table class="table table-striped text-white text-start"> 
      <thead>
        <tr>
          <th scope="col">#</th>
          <th scope="col text-uppercase">Esemény neve</th>
          <th scope="col text-uppercase">Helyszín</th>
          <th scope="col text-uppercase">Dátum</th>
          <th scope="col text-uppercase">Lemondás</th>
        </tr>
      </thead>
      <tbody v-if="eventsbyId && eventsbyId.length">
        <tr class="align-middle" v-for="(eventsbyId, index) in eventsbyId" :key="eventsbyId.id">
          <th scope="row" class="text-white">{{ index + 1 }}</th>
          <td class="text-white">{{ eventsbyId.name }}</td>
          <td class="text-white">{{ eventsbyId.city }}, {{ eventsbyId.street }} {{ eventsbyId.house_number  ? eventsbyId.house_number + '.' : '' }}</td>
          <td class="text-white">{{ eventsbyId.formatted_date }}</td>
          <td class="text-white ">
            <div class="d-flex align-items-center ">
            <form @submit.prevent="generateqrcode(eventsbyId.event_pass_code)">
              <button type="submit" id="qrcode" class="btn btn-transparent btn-sm d-flex flex-wrap w-auto align-middle ">
                <i class="bi bi-qr-code d-flex h3 text-white m-0"></i>
              </button>
            </form>
            <form @submit.prevent="cancelApplication(eventsbyId.loc_id, eventsbyId.id,eventsbyId.name)">
              <button type="submit" id="cancelButton" class="btn btn-danger btn-sm d-flex flex-wrap w-auto m-1">
                <i class="bi bi-x-circle d-flex align-items-center"><span class="p-1" style="flex-shrink: 0;">Lemondom</span></i>
              </button>
            </form>
            </div>
          </td>
        </tr>
      </tbody>
      <tbody v-else>
        <tr>
          <td colspan="5" class="text-white text-center">Nincsenek jelentkezett események</td>
        </tr>
      </tbody>
    </table>
  </div>
  </div>
</template>


<script>
import axios from 'axios';
import { mapGetters } from 'vuex';
import qrcode from 'qrcode';

export default {
  data() {
        return {
            eventsbyId: [],
        };
    },

  methods: {
    async cancelApplication(locationId, eventId,eventname) {
    const data = {
        eventname:eventname,
        locationId: locationId,
        eventId: eventId,
        userID: this.getID,
        userEmail: this.getEmail
        };
    if (confirm('Biztosan le szeretné mondani a(z)'+ ' "'+ eventname  +'" ' +' eseményt?')) {
      await axios.post('/cancelApplication', data)
        .then(response => {
          // Válasz kezelése
          console.log(response);

        })
        .catch(error => {
          // Hiba kezelése
          console.error(error);
        });
        //
        this.$emit("cancel-application", locationId, eventId);
        }
        location.reload();
},
    // Dátum formázása magyar formátumra
    formatDate(dateString) {
      const date = new Date(dateString);
      const options = { year: 'numeric', month: '2-digit', day: '2-digit' };
      return new Intl.DateTimeFormat('hu-HU', options).format(date);
    },

async generateqrcode(passCode) {
  const qrCodeUrl = `https://api.qrserver.com/v1/create-qr-code/?size=200x200&data=${passCode}`;
  const newWindow = window.open(qrCodeUrl, '_blank', 'height=400,width=400');
  if (newWindow) {
    newWindow.focus();
  } else {
    alert('A QR kód megjelenítéséhez engedélyezni kell az ablakok megnyitását.');
  }
},

  },

  mounted() {
      axios.get("/userapplied/"+this.getID)
      .then(response => {
        this.eventsbyId = response.data;
        
      })
      .catch(error => {
        console.log(error);
      });
},

computed: {
    ...mapGetters([
      'getID',
      'getEmail',
    ])},
}
</script>