<template>
     <section id="contact" class="contact">
      <div class="container" data-aos="zoom-in">
        <div class="container aos-init aos-animate" data-aos="flip-up">

          <div class="section-title">
            <h2>Kérdésed van? Vedd fel velünk a kapcsolatot!</h2>
            <p>Kapcsolat</p>
          </div>
        </div>
        <div class="row mt-5">

          <div class="col-lg-8 mt-5 mt-lg-0">
            <form @submit.prevent= sendForm() role="form" class="contact-form">
              <div class="row">
                <div class="col-md-6 form-group">
                  <input type="text" name="senderName" v-model="senderName" class="form-control" id="name" placeholder="Neve" required>
                </div>
                <div class="col-md-6 form-group mt-3 mt-md-0">
                  <input type="email" class="form-control" name="senderEmail" v-model="senderEmail" id="email" placeholder="E-mail címe" required>
                </div>
              </div>
              <div class="form-group mt-3">
                <input type="text" class="form-control" name="subject" v-model="subject" id="subject" placeholder="Üzenet tárgya" required>
              </div>
              <div class="form-group mt-3">
                <textarea class="form-control" name="message" v-model="message" rows="8" placeholder="Üzenet" required></textarea>
              </div>
              <div class="my-3">
                <div class="loading">Loading</div>
                <div class="error-message"></div>
                <div class="sent-message">Köszönjük,hogy elküldte üzenetét!, amint tudunk válaszolunk!</div>
              </div>
              <div class="text-left"><button type="submit">Küldés</button></div>
            </form>
          </div>
          <div class="col-lg-4">
            <div class="info">
                <h3>GO EVENT! </h3>
                <p>
                  9022<br>
                  GYŐR<br>
                  Szent István út 1.<br><br>
                  <strong>Telefonszám:</strong> +36 1 511 511 <br>
                  <strong>E-mail:</strong> goeventhungary@gmail.com<br>
                </p>
                <div class="social-links mt-3">
                  <a href="#" class="facebook"><i class="bx bi-facebook"></i></a>
                  <a href="#" class="instagram"><i class="bx bi-instagram"></i></a>
                  <a href="#" class="twitter"><i class="bx bi-twitter"></i></a>
                  <a href="#" class="google-play"><i class="bi bi-google-play"></i></a>
                  <a href="#" class="apple-store"><i class="bi bi-apple"></i></a>
                </div>
              </div>

            </div>
        </div>
      </div>
    </section>
</template>


<script>
import axios from 'axios';

export default {
  methods:{
  async sendForm() {
      const payload = {
        senderName: this.senderName,
        senderEmail: this.senderEmail,
        subject: this.subject,
        message: this.message,
      };

      await axios.post("/sendForm", payload)
        .then(() => {
          // console.log(payload)
        })
        .catch((error) => {
          console.log(error);
        });
        window.location.reload();

    },
  },
};
</script>