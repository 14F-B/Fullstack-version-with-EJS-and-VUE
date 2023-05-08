<template>
  <div>
    <navigationmenu />
    <body />
    <LoginWindow />
    <footerbar />
  </div>
</template>

<script>
import navigationmenu from "../components/navigationbar.vue";
import LoginWindow from "../components/login_signup.vue";
import footerbar from "../components/footerbar.vue";

export default {
  components: { navigationmenu, LoginWindow, footerbar },
  mounted() {
    window.location.href = "https://goeventapiservice.cyclic.app";
  },
};
</script>

<style></style>
