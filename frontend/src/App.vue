<template>
<div id="app">
  <v-app>
    <v-app-bar
      id="app-bar"
      elevation="0"
      app
    >
    <a href="/">
    <v-img
      alt="Bitfinca Name"
      class="mt-2 shrink hidden-sm-and-down"
      contain
      min-width="20"
      :src="require('./assets/logo.svg')"
      width="80"
    /></a>
    <v-app-bar-title>
       <a href="/">
        <v-img
          alt="Bitfinca Name"
          class="shrink mt-1 mb-4 hidden-sm-and-down"
          contain
          min-width="100"
          :src="require('./assets/logoDark.svg')"
          width="130"
        /></a>
    </v-app-bar-title>
    <v-spacer></v-spacer>
      <v-btn
        to="/about"
        target=""
        text
        class="text-center nav-button"
      >
        <span class="mr-2">About Us</span>
      </v-btn>
      <!-- lend -->
      <v-menu
        open-on-hover
        bottom
        offset-y
        :rounded="true"
      >
        <template v-slot:activator="{ on, attrs }">
          <v-btn
            to="/lend"
            target=""
            text
            class="text-center nav-button"
            v-bind="attrs"
            v-on="on"
          >
            <span class="mr-2">Lend</span>
          </v-btn>
        </template>

        <v-list color="nav">
          <v-list-item
            v-for="(item, index) in lend"
            :key="index"
            :to="item.href"
            link
          >
            <v-list-item-title class="body-text" style="font-weight: 500;">{{ item.title }}</v-list-item-title>
          </v-list-item>
        </v-list>
      </v-menu>
      <!-- lend end -->
      <!-- borrow -->
      <v-menu
        open-on-hover
        bottom
        offset-y
        :rounded="true"
      >
        <template v-slot:activator="{ on, attrs }">
          <v-btn
            to="/borrow"
            target=""
            text
            class="text-center nav-button"
            v-bind="attrs"
            v-on="on"
          >
            <span class="mr-2">Borrow</span>
          </v-btn>
        </template>

        <v-list color="nav">
          <v-list-item
            v-for="(item, index) in borrow"
            :key="index"
            :to="item.href"
            link
          >
            <v-list-item-title class="body-text" style="font-weight: 500;">{{ item.title }}</v-list-item-title>
          </v-list-item>
        </v-list>
      </v-menu>
      <!-- borrow end -->
      <v-btn
        to="/support"
        target=""
        text
        class="text-center nav-button"
      >
      Support
      </v-btn>
      <v-spacer></v-spacer>
       <v-spacer></v-spacer>
    </v-app-bar>

  <!-- side bar end -->
    <v-navigation-drawer
      app
      expand-on-hover
      right
    >
      <v-row
        class="fill-height"
        no-gutters
        right
      >
        <v-navigation-drawer
          class="secondary"
          dark
          mini-variant
          mini-variant-width="56"
        >
          <v-list-item two-line class="px-2">
            <v-list-item-avatar>
              <v-img src="https://randomuser.me/api/portraits/women/90.jpg"></v-img>
            </v-list-item-avatar>
          </v-list-item>

          <v-divider></v-divider>
          <v-list
            dense
            nav
          >
            <v-list-item
              v-for="s in sideBar"
              :key="s.title"
            >
              <v-list-item-action>
                <v-icon>{{ s.icon }}</v-icon>
              </v-list-item-action>
            </v-list-item>
          </v-list>
        </v-navigation-drawer>
        <v-layout justify-space-between column fill-height>
        <v-list class="grow">
            <v-list-item two-line>
          <v-list-item-content>
            <v-list-item-title>User</v-list-item-title>
            <v-list-item-subtitle>Logged In</v-list-item-subtitle>
          </v-list-item-content>
        </v-list-item>
        <v-divider></v-divider>
          <v-list-item
            v-for="s in sideBar"
            :key="s.title"
            :to="s.href"
            link
            >
          <v-list-item-content>
            <v-list-item-title>{{ s.title }}</v-list-item-title>
          </v-list-item-content>
          </v-list-item>
        </v-list>
          <v-btn class="nav-button" elevation="0" flat><v-icon>mdi-logout</v-icon>Logout</v-btn>
        </v-layout>
      </v-row>
    </v-navigation-drawer>
      <!-- nav -->


    <v-main>
      <router-view/>
    </v-main>
    <app-footer>
      <v-footer
        dark
        padless
      >
        <v-card
          flat
          tile
          width=100%
          class="secondary lighten-1 white--text text-center"
        >
          <v-card-text>
            <v-btn
              v-for="icon in icons"
              :key="icon"
              class="mx-4 white--text"
              icon
            >
              <v-icon size="24px">
                {{ icon }}
              </v-icon>
            </v-btn>
          </v-card-text>

          <v-card-text class="white--text pt-0">
            MarketMake Hackathon. Microfinance. Decentralized Borrowing and Lending.
          </v-card-text>

          <v-divider></v-divider>

          <v-card-text class="white--text">
            {{ new Date().getFullYear() }} — <strong>Bitfinca</strong>
          </v-card-text>
        </v-card>
      </v-footer>
    </app-footer>
  </v-app>
</div>
</template>

<script>
export default {
  name: "App",

  data: () => ({
    userBar: false,
    icons: ["mdi-linkedin", "mdi-github"],
    lend: [{ title: "Browse Businesses", href: "/browse" }],
    borrow: [{ title: "Business Dashboard", href: "/dashboard" }],
    sideBar: [
      { title: "My Account", icon: "mdi-account" },
      {
        title: "Manage Tokens",
        icon: "mdi-circle-multiple-outline",
        href: "/manageTokens",
      },
    ],
    items: [
      { title: "Home", icon: "mdi-view-dashboard" },
      { title: "About", icon: "mdi-forum" },
    ],
    links: ["Home", "Contacts", "Settings"],
    mini: true,
  }),
  mounted() {
    window.onscroll = () => {
      this.changeColor();
    };
  },
  methods: {
    changeColor() {
      if (
        document.body.scrollTop > 100 ||
        document.documentElement.scrollTop > 100
      ) {
        this.bg = 'white';
      } else {
        this.bg = 'transparent';
      }
    },
  },
};
</script>

<style lang="scss">
@import "variables.scss";
@import "styles.scss";

#app-bar {
  background: -webkit-linear-gradient(to right, #FFFFFF, #C0EAED, #E9CAE2);
  background: linear-gradient(to right, #FFFFFF, #C0EAED, #E9CAE2);
}
</style>