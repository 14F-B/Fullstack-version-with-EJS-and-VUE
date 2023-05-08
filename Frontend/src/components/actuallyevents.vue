<template>
     <section id="actually" class="actually">
          <div class="container" data-aos="fade-up">
            <div class="section-title">
              <h2>Inspirálódj eseményeink közül</h2>
              <p>Aktuális programok</p>
               <label v-for="(item, index) in categories" :key="index">
                <input type="checkbox" v-model="selectedCategories" :value="item">{{ item }}
              </label>
            </div>
            <div class="container-fluid text-dark">
                <div class="row row-cols-1 row-cols-md-2 row-cols-lg-3">
                  <div v-for="event in filteredEvents" :key="event.id" class="col mb-4">
                    <div class="card h-100 aos-init aos-animate eventcard" data-aos="fade-down">
                      <img style="height: 200px;" :src="event.url_link" class="card-img-top" alt="...">
                      <div class="card-body" data-aos="fade-up">
                        <h3>  {{ event.name }}
                           <img v-if="event.agelimit === 0" src="../assets/pictures/age0.png" alt="(Korhatár nélküli)" style="width: 30px; height: 30px;">
                           <img v-if="event.agelimit === 12" src="../assets/pictures/age12.png" alt="(12+)" style="width: 30px; height: 30px;">
                           <img v-if="event.agelimit === 16" src="../assets/pictures/age16.png" alt="(16+)" style="width: 30px; height: 30px;">
                           <img v-if="event.agelimit === 18" src="../assets/pictures/age18.png" alt="(18+)" style="width: 30px; height: 30px;">
                         </h3>
                         <!-- <h3> {{ event.name }}
                          <img v-bind:src="'../assets/pictures/age' + event.agelimit + '.png'" v-bind:alt="'age' + event.agelimit" style="width: 30px; height: 30px;" v-if="event.agelimit >= 0 && event.agelimit <= 18">
                        </h3> -->
                        <i class="bi bi-calendar2-week event-icons">{{ event.formatted_date }}</i><br>
                        <i class="bi bi-pin-map event-icons"><td>{{ event.city }}, {{ event.street }} {{ event.house_number ? event.house_number + '.' : '' }}</td></i><br>
                        <i class="bi bi-person-lines-fill event-icons">{{ event.performer_name }}</i>
                        <p style="font-size: 12px;" class="event-description">{{event.description}}</p>
                      </div>
                      <div v-if="isLoggedIn" class="container d-flex m-2 justify-content-end align-self-baseline">
                        <form  @submit.prevent="applyToLocation(event.loc_id+';'+event.id+';'+event.date+';'+event.agelimit)">
                         <button type="submit" id="applyButton" class="btn btn-outline-goevent m-1">Jelentkezem! <i class="bi bi-arrow-right-circle-fill"></i></button>
                        </form>
                    </div>
                    </div>
                </div>
                </div>
            </div>
        </div>
    </section>
</template>

<script>
import axios from 'axios';
import { mapGetters } from 'vuex'

export default {
    data() {
        return {
            events: [],
            categories: ['Zene (koncert)','Film','Sport','Kultúra','Irodalom','Fesztivál,tematikus napok','Konferencia','Egyéb kategória'], 
            selectedCategories: []
        };
    },
    mounted() {
        axios.get("/allevents")
  .then(response => {
    this.events = response.data;
  })
  .catch(error => {
    console.log(error);
  })
},
  methods:{
    async applyToLocation(datablock) {
    const [location, event, date, ageLimit] = datablock.split(';');

    const data = {
      locationId:location,
      eventDate: date,
      eventId: event,
      agelimit: ageLimit,
      userId: this.getID,
      userBirthday: this.getBirthday,
      userEmail: this.getEmail,
    };
    await axios.post('/applyToLocation', data)
      .then(response => {
        console.log(response.data);
        const successMsg = document.createElement('div');
        successMsg.innerHTML = '<i class="bi bi-check-lg"></i> ' + response.data.message;
        successMsg.style.position = 'fixed';
        successMsg.style.bottom = '10px';
        successMsg.style.left = '10px';
        successMsg.style.padding = '10px 40px';
        successMsg.style.backgroundColor = 'rgba(0, 0, 0, 0.6)';
        successMsg.style.color = '#0FF';
        successMsg.style.border = '1px solid #0FF';
        successMsg.style.borderRadius = '10px';
        successMsg.style.boxShadow = '0px 2px 5px rgba(0, 0, 0, 0.3)';
        successMsg.setAttribute('data-aos', 'fade-up');
        document.body.appendChild(successMsg);
        setTimeout(function(){
          successMsg.remove();
        }, 5000);

        })
     .catch(error => {
      console.log(error);
      const errorDiv = document.createElement('div');
      errorDiv.innerHTML = '<i class="bi bi-exclamation-circle-fill"></i> ' + '  '+error.response.data.message;
      errorDiv.style.position = 'fixed';
      errorDiv.style.bottom = '10px';
      errorDiv.style.left = '10px';
      errorDiv.style.padding = '10px';
      errorDiv.style.backgroundColor = 'red';
      errorDiv.style.color = '#FFF';
      errorDiv.style.borderRadius = '10px';
      errorDiv.setAttribute('data-aos', 'fade-up');

      document.body.appendChild(errorDiv);
      setTimeout(function(){
        errorDiv.remove();
      }, 5000);
    });
  }
  },
  
  computed: {
    ...mapGetters([
      'getEmail',
      'getID',
      'getBirthday'
    ]),
    isLoggedIn() {
      return this.getEmail !== ''
    },
     filteredEvents() {
      // Szűrjük az eseményeket a kiválasztott kategóriák alapján
      if (this.selectedCategories.length > 0) {
        return this.events.filter(event => this.selectedCategories.includes(event.category));
      } else {
        // Ha nincs kiválasztott kategória, akkor az összes eseményt megjelenítjük
        return this.events;
      }
    },
  },
};
</script>
<style>

</style>