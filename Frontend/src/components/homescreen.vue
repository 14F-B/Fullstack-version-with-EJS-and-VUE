<template>
 <section id="welcome-screen" class="d-flex align-items-center">
    <div class="container position-relative text-center text-lg-start" data-aos="zoom-out-down" data-aos-delay="100">
      <div class="row text-center">

        <div class="col-sm-12 d-flex align-items-center mb-5 mt-5 justify-content-center position-relative" data-aos="zoom-in" data-aos-delay="200">
          <a href="https://www.youtube.com/watch?v=TnbxtNWcGnw" class="glightbox play-btn"></a>
        </div>

        <div class="col-sm-4"></div>

        <div class="carousel-content animate__animated animate__fadeInUp col-sm-4  mt-5" data-aos="fade-up">
          <p class="next-event-text">A következő esemény:</p>
          <h4>{{ events.length > 0 ? events[0].name : 'Nincs közelgő esemény' }}</h4>
 
          <i class="bi bi-pin-map event-icons"><span v-if="events.length > 0">{{ events[0].city }}, {{ events[0].street }}{{ events[0].house_number ? ' ' + events[0].house_number + '.' : '' }}</span></i>
          <div class="d-flex flex-nowrap text-center">
<div class="countdown d-inline-flex text-center col-12 p-2" :data-count="events.length > 0 ? events[0].date : ''">
  <div class="countdown-block" style="width: 25%"><h3>%d</h3><h4 class="countdown-text">Nap</h4></div>
  <div class="countdown-block" style="width: 25%"><h3>%h</h3><h4 class="countdown-text">Óra</h4></div>
  <div class="countdown-block" style="width: 25%"><h3>%m</h3><h4 class="countdown-text">Perc</h4></div>
  <div class="countdown-block" style="width: 25%"><h3>%s</h3><h4 class="countdown-text">MP</h4></div>
</div>
          <div class="col-sm-4"></div>
        </div>
        </div>
      </div>
    </div>
  </section>
</template>

<script>
import axios from 'axios';

export default {
    data() {
        return {
            events: [],
            countDownInterval: null,
        };
    },
    mounted() {
      axios.get("/allevents")
      .then(response => {
        this.events = response.data;
        const countdown = document.querySelector('.countdown');
        const output = countdown.innerHTML;
        const countDownDate = function() {
          let timeleft = new Date(countdown.getAttribute('data-count')).getTime() - new Date().getTime();
          timeleft -= 7200000; // Korrekció az időzóna miatt
          let days = Math.floor(timeleft / (1000 * 60 * 60 * 24));
          let hours = Math.floor((timeleft % (1000 * 60 * 60 * 24)) / (1000 * 60 * 60));
          let minutes = Math.floor((timeleft % (1000 * 60 * 60)) / (1000 * 60));
          let seconds = Math.floor((timeleft % (1000 * 60)) / 1000);
          if (timeleft < 0) {
            countdown.innerHTML = "Az esemény tart";
            clearInterval(this.countDownInterval);
            return;
          }
          countdown.innerHTML = output.replace('%d', days).replace('%h', hours).replace('%m', minutes).replace('%s', seconds);
        }
        this.countDownInterval = setInterval(countDownDate.bind(this), 1000);
      })
      .catch(error => {
        console.log(error);
      });
  },

};
</script>