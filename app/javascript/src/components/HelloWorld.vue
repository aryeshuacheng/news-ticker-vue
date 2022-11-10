<template>
  Search: <input v-model="query" placeholder="Query"/> <button @click="saveQuery()">Save Query</button>
  <br>
  <br>
  <b-table-simple bordered small response>
    <b-thead variant="primary">
      <b-tr>
        <b-th>Name</b-th>
        <b-th>Additional Actions</b-th>
      </b-tr>
    </b-thead>
    <b-tbody>
      <b-tr v-for="query in saved_queries">
        <b-td><a href="javascript:void(0);" @click="getNewsFromSavedQuery(query.name)"> {{ query.name }}</a></b-td>
        <b-td><b-button variant="danger" @click="deleteQuery()">Delete Query</b-button></b-td>
      </b-tr>
    </b-tbody>
  </b-table-simple>

  <div>
    Sources
    <b-form-select v-model="selected">
      <b-form-select-option :value="null">Please select an option</b-form-select-option>
      <b-form-select-option v-for= "source in sources" :value="source.id">{{ source.name }}</b-form-select-option>
    </b-form-select>

    <div class="mt-2">Selected: <strong>{{ selected }}</strong></div>
  </div>
  <br>
    <button @click="getNews()">Get News</button>
  <br>
    <b-table-simple bordered small responsive>
      <b-thead variant="primary">
        <b-tr>
          <b-th>Source</b-th>
          <b-th>Title</b-th>
          <b-th>Author</b-th>
          <b-th>Published At</b-th>
          <b-th>Description</b-th>
        </b-tr>
      </b-thead>
      <b-tbody>
        <b-tr v-for="article in news">
          <b-td><a v-bind:href="article.url"> {{ article.source.name }} </a></b-td>
          <b-td>{{ article.title }}</b-td>
          <b-td>{{ article.author }}</b-td>
          <b-td>{{ article.publishedAt }}</b-td>
          <b-td>{{ article.description }}</b-td>
        </b-tr>
      </b-tbody>
    </b-table-simple>
</template>

<script>
import { ref } from 'vue'

export default {
  setup() {
    let news = ref([])
    let query = ref('Bitcoin')
    let sources = ref([])
    let source_name = ref('')
    let selected = ref('')
    let saved_queries = ref([])

    function getNews() {
      fetch('http://localhost:3000/api/v1/get_news' + '?query=' + query.value + '&sources=' + this.selected)
          .then(response => response.json())
          .then(response => news.value = response)
    }

    function getNewsFromSavedQuery(query) {
      fetch('http://localhost:3000/api/v1/get_news' + '?query=' + query)
          .then(response => response.json())
          .then(response => news.value = response)
    }

    function getSources() {
      fetch('http://localhost:3000/api/v1/get_sources')
          .then(response => response.json())
          .then(response => sources.value = response)
    }

    function getSavedQueries() {
      fetch('http://localhost:3000/api/v1/get_saved_queries')
          .then(response => response.json())
          .then(response => saved_queries.value = response)
    }

    function saveQuery() {
      fetch('http://localhost:3000/api/v1/save_query' + '?query=' + query.value)
    }

    function deleteQuery() {
      fetch('http://localhost:3000/api/v1/delete_query' + '?query=' + query.value)
    }

    getSavedQueries()
    getSources()

    return { getNews,getSources, saveQuery, getNewsFromSavedQuery, deleteQuery, getSavedQueries, saved_queries,  news, query, sources, source_name, selected}
  }
}
</script>

<style scoped>
p {
  font-size: 2em;
  text-align: center;
}
</style>
