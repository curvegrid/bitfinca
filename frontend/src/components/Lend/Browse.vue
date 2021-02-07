<template>
  <div>
    <v-container>
      <h1 class="page-title">
        Become a Lender
      </h1>
    </v-container>
    <v-main class="grey lighten-5" style="padding: 20px 0px 0px;">
      <v-container>
        <v-row>
          <v-col cols="2">
            <v-sheet rounded="lg">
              <v-list rounded>
                <v-list-item
                  v-for="c in categories"
                  :key="c"
                  link
                >
                  <v-list-item-content>
                    <v-list-item-title class="body-text" style="font-weight: 500;">
                      {{ c }}
                    </v-list-item-title>
                  </v-list-item-content>
                </v-list-item>

                <v-divider class="my-2"></v-divider>
                <v-list-item
                  link
                  color="grey lighten-4"
                >
                  <v-list-item-content>
                    <v-list-item-title class="body-text" style="font-weight: 700;">
                      Refresh
                    </v-list-item-title>
                  </v-list-item-content>
                </v-list-item>
              </v-list>
            </v-sheet>
          </v-col>

          <v-col>
            <h2 class="page-header-two">Entrepreneurs</h2>
            <v-sheet
              min-height="70vh"
              rounded="lg"
            >
             <v-container>
              <v-row>
                <v-col
                  v-for="(e, i) in entrepreneurs"
                  :key="i"
                  cols="4"
                >
                  <v-card>
                    <v-card-title class=body-text>
                      {{ e.title }}
                      <v-spacer/>
                      <v-avatar><img :src="people[e.id].picture.large"></v-avatar>
                    </v-card-title>
                    <v-card-text>
                      <img height=150 :src="(require(`../../assets/entrepreneurs/${e.src}`))"/>
                      {{ e.progress }}% funded
                      <v-progress-linear
                        :value="e.progress"
                        height="12"
                        rounded
                        color="#B6509E">
                      </v-progress-linear>
                    </v-card-text>
                    <v-card-actions>
                      <v-btn @click="goTo(i)" class="page-button">Learn more</v-btn>
                      <v-spacer/>
                      <v-btn class="lend-button" @click="lendNow(i)">Lend now</v-btn>
                    </v-card-actions>
                  </v-card>
                </v-col>
              </v-row>
            </v-container>
            </v-sheet>
          </v-col>
        </v-row>
      </v-container>
    </v-main>
  </div>
</template>

<script>
import Entrepreneurs  from '../../assets/DummyData.json';
import People from '../../assets/People.json'

  export default {
    data: () => ({
      entrepreneurs: Entrepreneurs['entrepreneurs'],
      allEntrepreneurs: [],
      categories: [
        'Arts', 'Agriculture', 'Education', 'Environment', 'Technology'
      ],
      people: People['results'],
    }),
    async created() {
      const Web3 = require('web3');
      if (window.ethereum != null) { // true if user is using MetaMask
        window.web3 = new Web3(window.ethereum);
        await window.ethereum.enable();
      }
      this.connectToWeb3();
      this.axios = this.$root.$_cgutils.createAxiosInstance(this.$BASE_URL, this.$API_KEY);
      this.walletAddress = await this.getActiveAccount();
      this.allEntrepreneurs = await this.getEntrepreneurs();
      console.log("BaseUrl", this.$BASE_URL);
    },
    methods: {
      connectToWeb3() {
      const web3Config = this.$root.$_cgutils.connectToWeb3(window.web3);
      this.$root.$_web3 = web3Config.provider;
      this.$root.$_web3Available = web3Config.web3Available;
      },
      // Get the Eth Address currently selected in MetaMask
      async getActiveAccount() {
        const accounts = await this.$root.$_web3.listAccounts();
        return accounts[0];
      },
      goTo(label) {
        this.$router.push({
          path: `/details/${label}`,
          });
      },
      async getEntrepreneurs() {
        try {
          const body = { args: [], from: this.walletAddress }
          const { data } = await this.axios.post(
            `/api/v0/chains/ethereum/addresses/${this.$BITFINCA_CONTRACT}/contracts/bitfinca/methods/totalEntrepreneurs`,
            body
          );
        this.response = data;
        console.log(this.response);
      } catch (err) {
        console.log(err);
      }
      },
      async lendNow(id) {
        try {
          const body = { args: [id] }
          const { data } = await this.axios.post(
            `/api/v0/chains/ethereum/addresses/${this.$TOKEN_CONTRACT}/contracts/finca_token/methods/totalSupply`, // fix this
            body
          );
        this.response = data;
      } catch (err) {
        console.log(err);
      }
      },
    }
  }
</script>