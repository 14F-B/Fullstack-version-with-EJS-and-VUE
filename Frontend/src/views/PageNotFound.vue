<template>
  <div>
    <title>GO EVENT! - 404 Az oldal nem található!</title>
    <navigationmenu></navigationmenu>
    <main id="main" style="min-height: 100vh;">
      <section class="sub-page-notfound">
        <div class="container">
          <h1 style="font-size: 13vw;" class="text-center mt-5">404</h1>
          <h1 class="text-center mt-3">Az oldal nem található!</h1>
          <p class="text-center">Valószínűleg rossz URL címet adtál meg, vagy az oldalt töröltük, áthelyeztük más webcímre!</p>
          <div class="text-center">
            <button class="btn btn-info text-center mt-4" style="margin-bottom: 3%;">
              <a class="text-dark text-center" href="/">Visszalépés a kezdőlapra</a>
            </button>
          </div>
        </div>
      </section>
    </main>
  </div>
    <footerbar style="position: fixed; bottom: 0; width:100%"></footerbar>
    <LoginWindow></LoginWindow>
</template>

<script>
import navigationmenu from '../components/navigationbar.vue';
import LoginWindow from '../components/login_signup.vue';
import footerbar from '../components/footerbar.vue';

export default {
  components: {
    navigationmenu,
    LoginWindow,
    footerbar,
  },
};
</script>

<style>
.sub-page-notfound {
  height: 100%;
  display: flex;
  flex-direction: column;
  justify-content: center;
  align-items: center;
}
</style>
