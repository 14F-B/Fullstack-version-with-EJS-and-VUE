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
          <td class="text-white">
            <form @submit.prevent="cancelApplication(eventsbyId.loc_id, eventsbyId.id,eventsbyId.name)">
              <button type="submit" id="cancelButton" class="btn btn-danger btn-sm">
                <i class="bi bi-x-circle d-flex align-items-center"><span class="p-1">Lemondom</span></i>
              </button>
            </form>
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

export default {
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
      // itt kezelheted a választ a szerverről
      console.log(response);

    })
    .catch(error => {
      // itt kezelheted a hibát, ha a kérés nem sikerült
      console.error(error);
    });
    this.$emit("cancel-application", locationId, eventId);
    }
    location.reload();

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