<template>
  <div class ="center">
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
        <b-tr v-for="article in exa">
          <b-td><a v-bind:href="article.url"> {{ article.source.name }} </a></b-td>
          <b-td>{{ article.title }}</b-td>
          <b-td>{{ article.author }}</b-td>
          <b-td>{{ article.publishedAt }}</b-td>
          <b-td>{{ article.description }}</b-td>
        </b-tr>
      </b-tbody>
    </b-table-simple>
  </div>
</template>

<script>
  import { ref } from 'vue'

  let exa
  export default {
  props: {exa},
  setup() {
    let news = ref([])
    let query = ref('Bitcoin')
    let sources = ref([])
    let source_name = ref('')
    let selected = ref('')
    let saved_queries = ref([])

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

    return {getSources, saveQuery, getNewsFromSavedQuery, deleteQuery, getSavedQueries, saved_queries,  news, query, sources, source_name, selected}
  }
}
</script>

<style scoped>
p {
  font-size: 2em;
  text-align: center;
}
</style>
