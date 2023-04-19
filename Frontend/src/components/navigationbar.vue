<template>

    <div id="header" class="fixed-top d-flex align-items-cente">
      <div class="container-fluid container-xl d-flex flex-row">
        <a href="/" class="logo me-auto me-lg-0"><img id="logo" src="../assets/pictures/logo.png" alt="" class=""></a>

        <nav id="navbar" class="navbar order-last order-lg-0">
          <ul>
            <li><a class="nav-link scrollto active" href="/#welcome-screen" >Home</a></li>
            <li><a class="nav-link scrollto" href="/#about" >Ismertető</a></li>
            <li><a class="nav-link scrollto" href="/#actually" >Programok</a></li>
            <li><a class="nav-link scrollto" href="/#media">Média</a></li>
            <li><a class="nav-link scrollto" href="/#map">Helyszín</a></li>
            <li><a class="nav-link scrollto" href="/#contact">Kapcsolat</a></li>
        
            <div v-if="!isLoggedIn" class="navbar-buttons m-3">
                <label class="modal-btn" for="modal-toggle">Bejelentkezés/<br>Regisztráció</label>
            </div>
            <div v-if="isLoggedIn" class="navbar-buttons m-3 ">
            <form action="/userpage">
              <button class="logoutbtn navbar-buttons" type="submit">Fiók</button>
            </form> 
            </div>
            <div v-if="isLoggedIn" class="navbar-buttons m-3">
            <form @click="logout">
              <button class="logoutbtn navbar-buttons" type="submit">Kijelentkezés</button>
            </form> 
            </div>
          </ul>
          <i class="bi bi-list mobile-nav-toggle"></i>
        </nav>
      </div>
    </div>

    
</template>

<script>
import { mapGetters, mapActions } from 'vuex'

export default {
  computed: {
    ...mapGetters([
      'getEmail'
    ]),
    isLoggedIn() {
      return this.getEmail !== ''
    }
  },
  methods: {
    ...mapActions([
      'logout'
    ])
  }
}
</script>


