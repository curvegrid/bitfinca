import Vue from 'vue';
import Vuetify from 'vuetify/lib/framework';



Vue.use(Vuetify);

export default new Vuetify({
  theme: {
    themes: {
      light: {
        primary: '#14044D',
        secondary: '#716B94',
        header: "#37367B",
        highlight: '#C6C5D5',
        nav: '#FFFFFF',
        body: '#37367B',
        accent: '#B6509E',
        error: '#b71c1c',

      },
      dark: {
        primary: '#14044D',
        secondary: '#716B94',
        header: "#37367B",
        highlight: '#C6C5D5',
        body: '#37367B',
        accent: '#B6509E',
        error: '#b71c1c',

      },
      options: {
        themeCache: {
          get: key => localStorage.getItem(key),
          set: (key, value) => localStorage.setItem(key, value),
        },
      },
    },
  },
});
