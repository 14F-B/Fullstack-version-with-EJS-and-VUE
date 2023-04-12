<template>
  <title>GO EVENT! - Adminisztráció</title>
  <navigationmenu></navigationmenu>
    <main id="main">
      <section class="sub-page-strip">
        <div class="container">    
          <div class="d-flex justify-content-between align-items-center">
            <h2>Adminisztráció</h2>
              <AdminMenu></AdminMenu>
              <ol><li><a href="/">Home</a></li><li>Adminisztrációs felület</li></ol>
          </div>
        </div>
      </section>
    <AdminTables></AdminTables>
    <footerbar></footerbar>
  </main>
</template>
  


<script>
import navigationmenu from '../components/navigationbar.vue';
import AdminMenu from '../components/admin_menu.vue';
import AdminTables from '../components/admin_tables.vue'
import footerbar from '../components/footerbar.vue';

export default {components: { navigationmenu,AdminMenu,AdminTables,footerbar }};

</script>