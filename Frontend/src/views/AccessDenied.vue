<template>
    <title>GO EVENT! - Nincs jogosultsága!</title>
    <navigationmenu></navigationmenu>
    <main id="main">
      <accessdenied></accessdenied>
      <footerbar></footerbar>
    </main>
</template>
  
<script>
import navigationmenu from '../components/navigationbar.vue';
import accessdenied from '../components/access_denied.vue';
import footerbar from '../components/footerbar.vue';
export default {components:{navigationmenu,accessdenied,footerbar}}
</script>