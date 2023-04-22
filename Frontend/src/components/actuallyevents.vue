<template>
     <section id="actually" class="actually">
          <div class="container" data-aos="fade-up">
            <div class="section-title">
              <h2>Inspirálódj eseményeink közül</h2>
              <p>Aktuális programok</p>
               <label v-for="(item, index) in items" :key="index">
                <input type="checkbox" v-model="selectedItems" :value="item">{{ item }}
              </label>
            </div>
            <div class="container-fluid text-dark">
                <div class="row row-cols-1 row-cols-md-2 row-cols-lg-3">
                  <div v-for="event in filteredEvents" :key="event.id" class="col mb-4">
                    <div class="card h-100 aos-init aos-animate eventcard" data-aos="fade-down">
                      <img style="height: 200px;" :src="event.url_link" class="card-img-top" alt="...">
                      <div class="card-body" data-aos="fade-up">
                        <h3>{{ event.name }} {{ event.agelimit > 0 ? '(' + event.agelimit + '+ )' : '' }}</h3>
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
            countDownInterval: null,
            items: ['Zene (koncert)','Film','Sport','Kultúra','Irodalom','Fesztivál,tematikus napok','Konferencia','Egyéb kategória'], 
            selectedItems: []
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
    async applyToLocation(locationId) {
    const [location, event, date, ageLimit] = locationId.split(';');

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
        successMsg.textContent = 'Sikeres jelentkezés!';
        successMsg.style.position = 'fixed';
        successMsg.style.bottom = '10px';
        successMsg.style.left = '10px';
        successMsg.style.padding = '10px 40px 10px 40px';
        successMsg.style.backgroundColor = '#0FF';
        successMsg.style.color = '#000';
        document.body.appendChild(successMsg);
        setTimeout(function(){
          successMsg.remove();
        }, 5000);

      })
      .catch(error => {
        console.log(error);
        const successMsg = document.createElement('div');
        successMsg.textContent = 'Sikertelen jelentkezés, próbáld újra!';
        successMsg.style.position = 'fixed';
        successMsg.style.bottom = '10px';
        successMsg.style.left = '10px';
        successMsg.style.padding = '10px';
        successMsg.style.backgroundColor = 'red';
        successMsg.style.color = '#FFF';
        document.body.appendChild(successMsg);
        setTimeout(function(){
          successMsg.remove();
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
      if (this.selectedItems.length > 0) {
        return this.events.filter(event => this.selectedItems.includes(event.category));
      } else {
        // Ha nincs kiválasztott kategória, akkor az összes eseményt megjelenítjük
        return this.events;
      }
    },
  },
};
</script>
