import { createRouter, createWebHistory } from "vue-router";
import HomeView from "./views/HomeView.vue";
import AdminView  from "./views/AdminPage.vue"
import UserView  from "./views/UserPage.vue"
import Adatvedelem from "./views/Adatvedelem.vue"
import AccessDenied from "./views/AccessDenied.vue"
import PageNotFound from "./views/PageNotFound.vue"
import Docs from "./views/Docs.vue"
import store from './store'



const router = createRouter({
  history: createWebHistory(import.meta.env.BASE_URL),
  routes: [
    {
      path: "/",
      name: "home",
      component: HomeView,
    },
    {
      path: '/adminpage',
      name: 'adminpage',
      component: AdminView,
      beforeEnter: (to, from, next) => {
        if (store.getters.getPermission === 'admin') {
          next();
        } else {
          next('/accessdenied');
        }
      }
    },

    {
      path: "/accessdenied",
      name: "Nincs jogosultsága megtekinteni az oldalt!",
      component: AccessDenied,
    },

    {
      path: '/userpage',
      name: 'userpage',
      component: UserView,
      beforeEnter: (to, from, next) => {
        if (store.getters.getPermission === 'admin' || store.getters.getPermission === 'user' ) {
          next();
        } else {
          next('/');
        }
      }
    },

    {
      path: "/adatvedelem",
      name: "adatvedelem",
      component: Adatvedelem,
    },

    {
      path: "/docs",
      name: "API Service",
      component: Docs,
    },

    {
      path: '/:catchAll(.*)',
      name: 'PageNotFound',
      component: PageNotFound,
    },
  ],
});

export default router;
