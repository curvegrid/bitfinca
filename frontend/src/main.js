import Vue from 'vue'
import App from './App.vue'
import vuetify from './plugins/vuetify';
import axios from 'axios'
import router from './router'
import Vuetify from 'vuetify'
import cgutils from './js/cgutils';

Vue.use(cgutils);

// [REQUIRED: REPLACE ME] Server URL
Vue.prototype.$BASE_URL = 'http://localhost:8080';

// [REQUIRED: REPLACE ME] Server API key
Vue.prototype.$API_KEY = 'eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJqdGkiOiI2ZDA2ZGJkMi00ZDM3LTRkOGUtYTgyZS1hNjdiYWQ1YjZhZjgiLCJpYXQiOjE2MTIxNzIzNjYsInN1YiI6IjEifQ.Ls-tGBswZ_zg3JS-6zg46GyH_a3LRDrlBylkPYEpwKg';

// The deployed contract's address, or the label you assigned it in MultiBaas
// [REQUIRED: REPLACE ME]
Vue.prototype.$BITFINCA_CONTRACT = 'bitfinca';
Vue.prototype.$TOKEN_CONTRACT = 'finca_token';

// global variable
Vue.prototype.$axios = axios;
Vue.prototype.$BITFINCA_ADDRESS = process.env.variable

Vue.config.productionTip = false

new Vue({
  router,
  vuetify,
  Vuetify,
  render: h => h(App)
}).$mount('#app')
