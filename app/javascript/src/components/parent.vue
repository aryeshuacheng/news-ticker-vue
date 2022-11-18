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
          <b-td><a href="javascript:void(0);" @click="getNewsFromSavedQuery(query.name)"> {{ query.name }}</a></b-td>
        </b-tr>
      </b-tbody>
    </b-table-simple>
  </div>

  <div class="center">
    <p><center>The parent will initiate API calls to retrieve news and send it to the child (News table)</center></p>
    <br>
    <center>
      Search: <input v-model="query" placeholder="Query"/> <button @click="saveQuery()">Save Query</button>
    </center>
  </div>
<News name="Bobby"/>

<SavedQueries />
</template>
<script>
import News from './news.vue'

export default {
  name: "Home",
  components: {News}
}
</script>
