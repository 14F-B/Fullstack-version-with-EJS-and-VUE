import { createStore } from 'vuex';
import createPersistedState from 'vuex-persistedstate';
import axios from 'axios';
import router from './routes';
import jwt_decode from 'jwt-decode';


const store = createStore({
  state: {
    id:'',
    email: '',
    password: '',
    permission: '',
    name:'',
    birthday:'',
    gender:'',
    citizenship:'',
    token:null
  },
  plugins: [
    createPersistedState({
      // Az időlimit beállítása 'expires' kulcs alatt (1 hét)
      expires: 7 * 24 * 60 * 60 * 1000,
    })
  ],
  mutations: {
    setID(state, id) {
        state.id = id;
      },
    setName(state, name) {
        state.name = name;
      },
    setPassword(state, password) {
        state.password = password;
      },
    setEmail(state, email) {
      state.email = email;
    },
    setBirthday(state, birthdate) {
      state.birthday = birthdate;
    },
    setCitizenship(state, nationality) {
        state.citizenship = nationality;
      },
    setGender(state, gender) {
        state.gender = gender;
    },
    setPermission(state, permission) {
      state.permission = permission;
    },
    setToken(state, token) {
      state.token = token;
      localStorage.setItem('token', token);
    },
    clearToken(state) {
      state.token = null;
      localStorage.removeItem('token');
    },
    // Felhasználói adatok törlése kijelentkezés után
    clearUserData(state) {
      state.id = '';
      state.name = '';
      state.email = '';
      state.permission = '';
      state.birthday='';
      state.citizenship='';
      state.gender="";
    }
  },
  actions: {
    async login({ commit }, {id,name, email,password, gender,birthdate, nationality, permission }) {
      try {
        const response = await axios.post('login', {
          id: id,
          name: name,
          email: email,
          gender: gender,
          citizenship: nationality,
          birthday: birthdate,
          permission: permission,
          password: password
        });

        // Mutációk beállítása a kapott adatokkal
        commit('setID', response.data.user.id);
        commit('setName', response.data.user.name);
        commit('setEmail', response.data.user.email);
        commit('setBirthday', response.data.user.birthdate);
        commit('setCitizenship', response.data.user.nationality);
        commit('setGender', response.data.user.gender);
        commit('setPermission', response.data.user.permission);
        commit('setPassword', response.data.user.password);
        commit('setToken', response.data.token); // Token elmentése

        // Weboldal újratöltés
        location.reload();

      } catch (error) {

        // Hibakezelés, ha nem megfelelő jelszó, vagy ha nincs jogosultsága az oldalnak a bejelentkeztetésre
        const errorDiv = document.getElementById('errorDiv'); 

        if (error.response && error.response.status === 401) {
          errorDiv.innerHTML = '<i class="bi bi-exclamation-octagon-fill"></i>  Hibás felhasználónév vagy jelszó!';
          errorDiv.classList.add('border', 'border-danger', 'text-danger', 'p-2','col-8','text-start'); 

        } else {
          errorDiv.innerHTML = '<i class="bi bi-exclamation-octagon-fill"></i>  Hiba történt a bejelentkezés során.';
          errorDiv.classList.add('border', 'border-warning', 'text-warning', 'p-2','col-8','text-start'); 
        }
    
        errorDiv.classList.add('border', 'border-danger', 'text-danger', 'p-2','col-8','text-start'); 
      }
    },
    // Kijelentkezés esetén store-ban tárolt adatok törlése, és visszairányítás a főoldalra
    logout({ commit }) {
      commit('clearUserData');
      commit('clearToken');
      router.push('/');
    },
    checkTokenExpiration({ commit }) {
      const token = localStorage.getItem('token');
      if (token) {
        const decodedToken = jwt_decode(token);
        const currentTime = Date.now() / 1000;
        if (decodedToken.exp < currentTime) {
          commit('clearUserData');
          commit('clearToken');
          router.push('/');
        }
      }
    }
  },
  
  getters: {

    // Más komponensekben való hozzáférés kialakítása
    getID: state => state.id,
    getEmail: state => state.email,
    getPassword: state => state.password,
    getName: state => state.name,
    getCitizenship: state => state.citizenship,
    getGender: state => state.gender,
    getBirthday: state => state.birthday,
    getPermission: state => state.permission,
    },
});

export default store;
