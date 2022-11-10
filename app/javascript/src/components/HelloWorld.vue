<template>
  Search: <input v-model="query" placeholder="Query"/>
  <br>
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
    let sources =  ref([])
    let source_name = ref('')
    let selected = ref('')

    function getNews() {
      fetch('http://localhost:3000/api/v1/get_news' + '?query=' + query.value + '&sources=' + this.selected)
          .then(response => response.json())
          .then(response => news.value = response)


    }

    function getSources() {
      fetch('http://localhost:3000/api/v1/get_sources')
          .then(response => response.json())
          .then(response => sources.value = response)

      console.log(sources)
    }

    getSources()

    return { getNews, news, query, getSources, sources, source_name, selected}
  }
}
</script>

<style scoped>
p {
  font-size: 2em;
  text-align: center;
}
</style>
