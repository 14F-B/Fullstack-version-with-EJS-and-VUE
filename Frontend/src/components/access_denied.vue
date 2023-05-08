<template>
  <section class="sub-page-strip-access m-0">
    <div class="container text-center" style="overflow-y: hidden;">
      <img src="../assets/pictures/acces_denied.png"  class="img-fluid m-lg-3 pt-5" height="15%" width="15%">
      <h1 class="text-center mt-1 pt-3">Önnek nincs hozzáférése ennek </h1>
      <h1 class="text-center mt-2">az oldalnak a megnyitásához</h1>
      <p class="text-center ">A weboldal hamarosan átirányítja az Ön felhasználói szintjének megfelelő oldalra! </p>
      <div class="text-center">
        <button class="btn btn-info text-center"><a class="text-dark text-center" href="/userpage">Profil megtekintése</a></button>
      </div>
    </div>
  </section>
</template>

<style>
.sub-page-strip-access {
  height: 84vh;
  display: flex;
  flex-direction: column;
  justify-content: center;
  align-items: center;
}
</style>

<script>
export default {
  mounted() {
    setTimeout(() => {
      window.location.href = '/userpage';
    }, 5000); // 5 másodperc után átirányít a /userpage oldalra
  },
};
</script>
