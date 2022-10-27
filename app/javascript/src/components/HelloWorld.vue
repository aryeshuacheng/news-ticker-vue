<template>
  <p>
    <button @click="getNews()">Get News</button>
  <br>
    <table-simple>
      <thead variant="primary">
        <tr>
          <th>Name</th>
          <th>Description</th>
        </tr>
      </thead>
      <tbody>
        <tr v-for="source in news">
          <td>{{ source.name }}</td>
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

    function getNews() {
      fetch('http://localhost:3000/api/v1/get_news')
          .then(response => response.json())
          .then(response => news.value = response);
    }
    return { getNews, news };
  }
}
</script>

<style scoped>
p {
  font-size: 2em;
  text-align: center;
}
</style>
