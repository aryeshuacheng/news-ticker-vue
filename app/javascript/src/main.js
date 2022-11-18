import { createApp } from 'vue'
import News from '@/components/news.vue'
import Queries from '@/components/queries.vue'
import Parent from '@/components/parent.vue'

import BootstrapVue3 from 'bootstrap-vue-3'

import 'bootstrap/dist/css/bootstrap.css'
import 'bootstrap-vue-3/dist/bootstrap-vue-3.css'

export default () => {
    document.addEventListener('DOMContentLoaded', () => {
        // const app = createApp(News)
        // app.use(BootstrapVue3)
        // app.mount('#news')
        //
        // const queries = createApp(Queries)
        // queries.use(BootstrapVue3)
        // queries.mount('#queries')

        const parent = createApp(Parent)
        parent.use(BootstrapVue3)
        parent.mount('#parent')
    })
}

