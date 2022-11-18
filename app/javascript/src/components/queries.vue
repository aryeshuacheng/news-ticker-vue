<template>
  <div class = "center">
    <b-table-simple>
      <b-thead variant="primary">
        <b-tr>
        <b-th class="row-width">Saved Queries</b-th>
        </b-tr>
      </b-thead>
      <b-tbody>
        <b-tr v-for="query in saved_queries">
          <b-td><a href="javascript:void(0);" @click="getNewsFromSavedQuery(query.name)"> {{ query.name }}</a></b-td>
        </b-tr>
      </b-tbody>
    </b-table-simple>
  </div>
</template>

<script>
  import { ref } from 'vue'
  export default {
    setup() {
      let saved_queries = ref([])

      function getSavedQueries() {
        fetch('http://localhost:3000/api/v1/get_saved_queries')
            .then(response => response.json())
            .then(response => saved_queries.value = response)
      }

      getSavedQueries()
      return {getSavedQueries, saved_queries}
    }
  }
</script>
