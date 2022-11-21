<template>
  <div class="left">
    <b-table-simple>
      <b-thead variant="primary">
        <b-tr>
          <b-th class="row-width">Saved Queries</b-th>
        </b-tr>
      </b-thead>
      <b-tbody>
        <b-tr v-for="query in folderContents">
          <b-td>
            <a href="javascript:void(0);" @click="getNewsFromSavedQuery(query.name)"> {{ query.name }}</a>
            <p @click="deleteQuery(query.name)"> Delete</p>
          </b-td>
        </b-tr>
      </b-tbody>
    </b-table-simple>
  </div>

  <div class="center">

    <center>
      <b-container class="bv-example-row">
        <b-row class="justify-content-md-center">
        <b-col col lg="2">Folders<b-form-select v-model="selected" :options="folder_names"></b-form-select><br><b-button variant="success" @click="loadFolder()">Load Folder</b-button></b-col>
        </b-row>
      </b-container>
      <div class = "query">
        <b-input-group class="mt-3">
          <b-form-input v-model="folderName" placeholder="Folder Name"/>
          <b-button variant="outline-primary" @click="addFolder()">Add</b-button>
        </b-input-group>
      </div>
      <br>
      <div class="query">
        <b-input-group class="mt-3">
          <b-form-input v-model="query" placeholder="Query"></b-form-input>
          <b-button variant="outline-primary" @click="saveQuery()">Save Query To Folder</b-button>
          <b-button variant="outline-primary" @click="getNews()">Get News</b-button>
        </b-input-group>
      </div>
      <br>

    </center>
  </div>
<News :news="news"/>

</template>
<script>
import News from './news.vue'
import {ref} from "vue";

let folderName = ref()
let query = ref()

export default {
  name: "Home",
  components: {News},
  data()
  {
    let news = ref()
    let folderContents = ref([])

    function addFolder() {
      fetch('http://localhost:3000/api/v1/add_folder' + '?name=' + this.folderName)
    }

    function saveQuery() {
      fetch('http://localhost:3000/api/v1/save_query' + '?query=' + query.value + '&folder_name=' + this.selected)
    }

    function getNews() {
      fetch('http://localhost:3000/api/v1/get_news' + '?query=' + this.query)
          .then(response => response.json())
          .then(response => news.value = response)
    }

    function getNewsFromSavedQuery(query) {
      fetch('http://localhost:3000/api/v1/get_news' + '?query=' + query)
          .then(response => response.json())
          .then(response => news.value = response)
    }

    function deleteQuery(query) {
      fetch('http://localhost:3000/api/v1/delete_query' + '?query=' + query)
    }

    function loadFolder(){
      fetch('http://localhost:3000/api/v1/load_queries_from_folder' + '?folder_name=' + this.selected)
          .then(response => response.json())
          .then(response => folderContents.value = response)

    }

    return {
      loadFolder,
      getNewsFromSavedQuery,
      saveQuery,
      deleteQuery,
      getNews,
      addFolder,
      news: news,
      query: query,
      folderName: folderName,
      folderContents: folderContents,
      selected: null
    }
  },
  setup()
  {
    let saved_queries = ref([])
    let folders = ref([])
    let folder_names = ref([])
    let options = [{value:'a',text:'a' }]

    function getSavedQueries() {
      fetch('http://localhost:3000/api/v1/get_saved_queries')
          .then(response => response.json())
          .then(response => saved_queries.value = response)
    }

    function getFolders() {
      fetch('http://localhost:3000/api/v1/get_folders')
          .then(response => response.json())
          .then(response => folders.value = response)
          .then(response => folder_names.value = response.map(d => d.name))
    }

    getFolders()

    return {saved_queries, folders, options, folder_names}
  }
}
</script>
