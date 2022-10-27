<template>
  <p>
    <input v-model="query" placeholder="Query"/>
    <button @click="getNews()">Get News</button>
  <br>
    <table-simple>
      <thead variant="primary">
        <tr>
          <th>Name</th>
          <th>Author</th>
          <th>Published At</th>
          <th>Description</th>
        </tr>
      </thead>
      <tbody>
        <tr v-for="source in news">
          <td>{{ source.name }}</td>
          <td>{{ source.author }}</td>
          <td>{{ source.publishedAt }}</td>
          <td>{{ source.description }}</td>
        </tr>
      </tbody>
    </table-simple>
  </p>
</template>

<script>
import { ref } from 'vue'

export default {
  setup() {
    let news = ref([])
    let query = ref('Bitcoin')

    function getNews() {
      fetch('http://localhost:3000/api/v1/get_news' + '?query=' + query.value)
          .then(response => response.json())
          .then(response => news.value = response);

      console.log(query.value);
    }
    return { getNews, news, query };
  }
}
</script>

<style scoped>
p {
  font-size: 2em;
  text-align: center;
}
</style>
