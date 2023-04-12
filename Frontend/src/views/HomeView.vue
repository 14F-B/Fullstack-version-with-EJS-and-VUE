<template>
  <title>GO EVENT! - Home</title>
  <navigationmenu></navigationmenu> 
  <main id="main">
    <homescreen></homescreen>
    <about></about>
    <actuallyevents></actuallyevents>
    <gallery></gallery>
    <googlemap></googlemap>
    <contactform></contactform>
    <footerbar></footerbar>
  </main>
  <LoginWindow></LoginWindow>
</template>

<script>
import navigationmenu from '../components/navigationbar.vue';
import homescreen from '../components/homescreen.vue'
import about from '../components/about.vue'
import actuallyevents from '../components/actuallyevents.vue'
import gallery from '../components/gallery.vue'
import googlemap from '../components/map.vue'
import contactform from '../components/contactform.vue'
import LoginWindow from '../components/login_signup.vue';
import footerbar from '../components/footerbar.vue';

export default {
  components: {
    navigationmenu,
    homescreen,
    about,
    actuallyevents,
    gallery,
    googlemap,
    contactform,
    LoginWindow,
    footerbar
    }
};
</script>