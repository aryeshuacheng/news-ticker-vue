import { createApp } from 'vue'
import HelloWorld from '@/components/HelloWorld.vue'
import BootstrapVue3 from 'bootstrap-vue-3'

import 'bootstrap/dist/css/bootstrap.css'
import 'bootstrap-vue-3/dist/bootstrap-vue-3.css'

export default () => {
    document.addEventListener('DOMContentLoaded', () => {
        const app = createApp(HelloWorld)
        app.use(BootstrapVue3)
        app.mount('#news')
    })
}

