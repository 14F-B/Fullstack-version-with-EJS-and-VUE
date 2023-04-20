import { createStore } from 'vuex';
import createPersistedState from 'vuex-persistedstate';
import axios from 'axios';
import router from './routes';


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

  },
  plugins: [createPersistedState()],
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
    clearUserData(state) { // új mutáció
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

        commit('setID', response.data.user.id);
        commit('setName', response.data.user.name);
        commit('setEmail', response.data.user.email);
        commit('setBirthday', response.data.user.birthdate);
        commit('setCitizenship', response.data.user.nationality);
        commit('setGender', response.data.user.gender);
        commit('setPermission', response.data.user.permission);
        commit('setPassword', response.data.user.password);

        location.reload();

      } catch (error) {
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
    logout({ commit }) { // új action
      commit('clearUserData');
      router.push('/');
    }
  },
  getters: {
    getID: state => state.id,
    getEmail: state => state.email,
    getPassword: state => state.password,
    getName: state => state.name,
    getCitizenship: state => state.citizenship,
    getGender: state => state.gender,
    getBirthday: state => state.birthday,
    getPermission: state => state.permission,

  }
});

export default store;
