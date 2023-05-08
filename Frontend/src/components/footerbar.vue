<template>
  <footer id="footer">
    <div class="container">
      <div class="row">
        <div class="col-6">
          <div class="copyright">
            &copy;<strong><span> GO EVENT!  </span> </strong> Hungary<span class="mx-2">   {{currentYear}}</span>
          </div>
          <div class="credits">
            <a href="/adatvedelem">Adatvédelmi tájékoztató</a>
            <a class="mx-4" href="/docs">Fejlesztői dokumentáció</a>
          </div>
        </div>
        <div class="col-6 copyright">
          <div id="google_translate_element2" class="text-end"></div>
        </div>
      </div>
    </div>
  </footer>
</template>
<script>
export default {
  data() {
    return {
      currentYear: new Date().getFullYear()
    };
  },
  mounted() {
    // Google fordító script inicializálása
    function googleTranslateElementInit2() {
      new google.translate.TranslateElement({
        pageLanguage: 'hu',
        autoDisplay: false
      }, 'google_translate_element2');
    }

    // Google fordító script betöltése
    const script = document.createElement('script')
    script.src = '//translate.google.com/translate_a/element.js?cb=googleTranslateElementInit2';
    document.head.appendChild(script);
  },
};
</script>