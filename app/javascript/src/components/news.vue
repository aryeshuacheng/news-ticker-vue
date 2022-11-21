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
        <b-tr v-for="article in news">
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

  let news

  export default {
  props: {news},
  setup() {
    let query = ref('Bitcoin')
    let sources = ref([])
    let source_name = ref('')
    let selected = ref('')

    function getSources() {
      fetch('http://localhost:3000/api/v1/get_sources')
          .then(response => response.json())
          .then(response => sources.value = response)
    }

    getSources()

    return {getSources, query, sources, source_name, selected}
  }
}
</script>
