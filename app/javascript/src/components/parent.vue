<template>
  <div class="left">
    <b-table-simple>
      <b-thead variant="primary">
        <b-tr>
          <b-th class="row-width">Saved Queries</b-th>
        </b-tr>
      </b-thead>
      <b-tbody>
        <b-tr v-for="query in saved_queries">
          <b-td>
            <a href="javascript:void(0);" @click="getNewsFromSavedQuery(query.name)"> {{ query.name }}</a>
            <p @click="deleteQuery(query.name)"> Delete</p>
          </b-td>
        </b-tr>
      </b-tbody>
    </b-table-simple>
  </div>

  <div class="center">
    <p><center>The parent will initiate API calls to retrieve news and send it to the child (News table)</center></p>
    <br>
    <center>
      Search: <input v-model="query" placeholder="Query"/> <button @click="getNews()">Get News</button>
      <br>
      <button @click="saveQuery()">Save Query</button>
    </center>
  </div>
<News :news="news"/>

<!--<SavedQueries  />-->
</template>
<script>
import News from './news.vue'
import {ref} from "vue";

let query = ref('Hope')

export default {
  name: "Home",
  components: {News},
  data()
  {
    let news = ref()

    function getNews() {
      fetch('http://localhost:3000/api/v1/get_news' + '?query=' + this.query + '&sources=' + this.selected)
          .then(response => response.json())
          .then(response => news.value = response)
    }

    function getNewsFromSavedQuery(query) {
      fetch('http://localhost:3000/api/v1/get_news' + '?query=' + query)
          .then(response => response.json())
          .then(response => news.value = response)

      console.log("getNewsFromSavedQuery() hit")
    }

    function deleteQuery(query) {
      fetch('http://localhost:3000/api/v1/delete_query' + '?query=' + query)
    }

    function saveQuery() {
      fetch('http://localhost:3000/api/v1/save_query' + '?query=' + query.value)
    }
    return {
      getNewsFromSavedQuery,
      saveQuery,
      deleteQuery,
      getNews,
      news: news,
      query: query
    }
  },
  setup()
  {
    let saved_queries = ref([])

    function getSavedQueries() {
      fetch('http://localhost:3000/api/v1/get_saved_queries')
          .then(response => response.json())
          .then(response => saved_queries.value = response)
    }

    getSavedQueries()
    return {saved_queries}
  }
}
</script>
