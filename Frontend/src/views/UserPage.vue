<template>
  <title>GO EVENT! - Fiók</title>
  <navigationmenu></navigationmenu>
    <main id="main">
        <section class="sub-page-strip">
          <div class="container">
            <div class="d-flex justify-content-between align-items-center">
              <h2>Felhasználói adatok</h2>
              <ol><li><a href="/">Home</a></li><li>Fiók</li></ol>
            </div>
          </div>
        </section>
        <div class="container">
          <div class="text-center">
            <div class="row">
              <userDatafield></userDatafield>
              <userApplicant></userApplicant>
            </div>
          </div>
        </div>
      <div>
    <refreshpassword></refreshpassword>
  </div>
  <footerbar></footerbar>
  </main>
</template>
  



<script>
import navigationmenu from '../components/navigationbar.vue';
import userDatafield from '../components/user_datafields.vue'
import userApplicant from '../components/user_applicant.vue';
import refreshpassword from '../components/refreshpassword.vue'
import footerbar from '../components/footerbar.vue';

export default {components:{navigationmenu,userDatafield,userApplicant,refreshpassword,footerbar}}
</script>



