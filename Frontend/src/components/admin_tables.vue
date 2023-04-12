<template>
    <div class="container" id="eventTable">
        <table class="table table-bordered" id="tbl_events">
            <thead>
                <tr class="adminpage-tableheader bg-light">
                    <th scope="col">#</th>
                    <th scope="col" class="col-2">Esemény neve</th>
                    <th scope="col" class="col-2">Időpont</th>
                    <th scope="col" class="col-3">Helyszín</th>
                    <th scope="col" class="col-1">Max. létszám</th>
                    <th scope="col" class="col-1">Jk. száma</th>
                    <th scope="col" class="col-1">Korhatár</th>
                    <th scope="col" class="col-1">Szerkesztés</th>
                </tr>
            </thead>
            <tbody class="text-white ">
                <tr style="height: 30px;" v-for="(event, index) in events" :key="event.id">
                    <th style="height: 30px;" scope="row">{{ index + 1 }}</th>
                    <td>{{ event.name }}</td>
                    <td>{{ new Date(event.date).toLocaleString('hu-HU', { dateStyle: 'short', timeStyle: 'short' }) }}</td>
                    <td>{{ event.city }}, {{ event.street }} {{ event.house_number ? event.house_number + '.' : '' }}</td>
                    <td>{{ event.capacity }}</td>
                    <td>{{ event.applied }}</td>
                    <td>{{ event.agelimit }}</td>
                    <td><div class="d-flex align-items-center">

                        <!-- <form @submit.prevent="modifyEvent(index)" class="me-2">
                          <input type="hidden" name="eventId" :value="event.id">
                          <button type="submit" class="btn bg-transparent btn-sm">
                            <i class="bi bi-pencil-square p-2 text-white"></i>
                          </button>
                        </form> -->
      
                        <form @submit.prevent="deleteEvent(event.id)">
                          <button type="submit" class="btn bg-transparent btn-sm" @click="confirmDelete(event.name)">
                            <i class="bi bi-trash3-fill p-2 text-danger"></i>
                          </button>
                        </form>

                        </div>
                    </td>
                </tr>
            </tbody>
        </table>
    </div>

<!-- FELHASZNÁLÓK ADATAIT TARTALMAZÓ TÁBLÁZAT -->
    <div id="usersTable" class="container"  style="display: none;">
      <table class="table table-bordered" id="tbl_users">
        <thead>
          <tr class="adminpage-tableheader bg-light">
            <th scope="col" class="col-1">#</th>
            <th scope="col" class="col-2">Név</th>
            <th scope="col" class="col-2">Email cím</th>
            <th scope="col" class="col-1">Állampolgárság</th>
            <th scope="col" class="col-1">Nem</th>
            <th scope="col" class="col-1">Születési idő</th>
            <th scope="col" class="col-1">Életkor</th>
            <th scope="col" class="col-1">Jogosultság</th>
            <th scope="col" class="col-1">Törlés</th>
          </tr>
        </thead>
        <tbody class="text-white">
            <tr v-for="(user, index) in users" :key="user.id">
        <th scope="row">{{ index+1 }}</th>
        <td class="text-uppercase">{{ user.name }}</td>
        <td>{{ user.email }}</td>
        <td>{{ user.nationality }}</td>
        <td>{{ user.gender }}</td>
        <td>{{ new Date(user.birthdate).toLocaleString('hu-HU', { dateStyle: 'short' }) }}</td>
        <td>{{ new Date().getFullYear() - new Date(user.birthdate).getFullYear() }} éves</td>
        <td>{{ user.permission }}</td>
        <td>
          <form @submit.prevent="deleteUser(user.id)">
            <button type="submit" class="btn bg-transparent btn-sm" @click="confirmDelete(user.name)">
              <i class="bi bi-person-x p-2 text-danger"></i>
            </button>
          </form>
        </td>
      </tr>
        </tbody>
      </table>
    </div>
</template>

<script>
import axios from 'axios';

export default {
    data() {
        return {
            events: [],
            users: [],

        };
    },
    mounted() {
      axios.get("/allevents")
      .then(response => {
        this.events = response.data;
       
      })
      .catch(error => {
        console.log(error);
      });
      axios.get("/allusers")
      .then(response => {
        this.users = response.data;
       
      })
      .catch(error => {
        console.log(error);
      });
  },
  methods: {
  deleteUser(id) {
    axios.delete('/deleteUser/' + id)
      .then(response => {
        // Sikeres törlés esetén a felhasználói tömb frissítése
        this.users = response.data;
      })
      .catch(error => {
        console.log(error);
      });
      location.reload();
  },
  deleteEvent(id) {
    axios.delete('/deleteEvent/' + id)
      .then(response => {
        // Sikeres törlés esetén a felhasználói tömb frissítése
        this.events = response.data;
      })
      .catch(error => {
        console.log(error);
      });
      location.reload();
  },
},
};

</script>

<style>
#eventTable,
#usersTable {
  min-height: 100vh;
}

</style>
