import Vue from 'vue'
import App from './App.vue'
import vuetify from './plugins/vuetify';
import axios from 'axios'
import router from './router'
import Vuetify from 'vuetify'
import cgutils from './js/cgutils';

Vue.use(cgutils);

// [REQUIRED: REPLACE ME] Server URL
Vue.prototype.$BASE_URL = process.env.VUE_APP_MB_BASE_URL;

// [REQUIRED: REPLACE ME] Server API key
Vue.prototype.$API_KEY = process.env.VUE_APP_MB_API_KEY;

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
