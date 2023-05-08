
<script>
import jwt_decode from 'jwt-decode';

export default {
  mounted() {
    // Stílusváltás eseménykezelő
    document.addEventListener('keydown', (event) => {
      if (event.ctrlKey && event.code === 'KeyI') {
        let currentStyle = document.getElementById('main-style').getAttribute('href');
        let newStyle = currentStyle.includes('light') ? '../src/assets/css/style.css' : '../src/assets/css/style_light.css';
        document.getElementById('main-style').setAttribute('href', newStyle);
        document.cookie = `style=${newStyle}`;
      }
    });

    // Stílus betöltése a cookie-ból
    let styleCookie = document.cookie.match('(^|;) ?style=([^;]*)(;|$)');
    if (styleCookie) {
      document.getElementById('main-style').setAttribute('href', styleCookie[2]);
    }
  },
  created() {
  const token = localStorage.getItem('token');
  if (token) {
    const decodedToken = jwt_decode(token);
    const currentTime = Date.now() / 1000;
    if (decodedToken.exp < currentTime) {
      this.$store.dispatch('logout');
    }
  }
},

};
</script>

<template>
    <link rel="stylesheet" href="../src/assets/css/style.css" id="main-style">
    <RouterView />
</template>

<style>
.form-control:disabled, .form-control:read-only {
    background-color: #1b1b1b !important;
    opacity: 1 !important;
}
</style>
