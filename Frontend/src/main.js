import { createApp } from "vue";
import axios from 'axios';
import AOS from "aos";


import App from "./App.vue";
import router from "./routes.js";
import store from './store';

import "bootstrap/dist/css/bootstrap.min.css";
import 'bootstrap/dist/js/bootstrap.bundle.min.js';

import "aos/dist/aos.css";
import "./assets/css/style.css";
import "./assets/bootstrap-icons/bootstrap-icons.css";


axios.defaults.baseURL = 'http://localhost:5172/docs';


const app = createApp(App);

app.use(router);
app.use(store)
AOS.init();



app.mount("#app");

