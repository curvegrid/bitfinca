import Vue from 'vue'
import App from './App.vue'
import vuetify from './plugins/vuetify';
import router from './router'
import axios from 'axios'

// global variable
Vue.prototype.$axios = axios

// [REQUIRED] Server URL
Vue.prototype.$BASE_URL = 'http://localhost:8080';

// [REQUIRED] Server API key
Vue.prototype.$API_KEY = 'eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJqdGkiOiI2ZDA2ZGJkMi00ZDM3LTRkOGUtYTgyZS1hNjdiYWQ1YjZhZjgiLCJpYXQiOjE2MTIxNzIzNjYsInN1YiI6IjEifQ.Ls-tGBswZ_zg3JS-6zg46GyH_a3LRDrlBylkPYEpwKg';

// The deployed contract's address, or the label you assigned it in MultiBaas
// [CAN BE REPLACED]
Vue.prototype.$CONTRACT_LABEL_OR_ADDRESS = 'nodecimal';

Vue.config.productionTip = false

new Vue({
  router,
  vuetify,
  render: h => h(App)
}).$mount('#app')
