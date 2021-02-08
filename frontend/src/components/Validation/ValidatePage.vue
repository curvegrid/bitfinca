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
                      {{ e.business.title }}
                      <v-spacer/>
                      <v-avatar><img :src="e.person.picture.large"></v-avatar>
                    </v-card-title>
                    <v-card-text>
                      <img height=150 :src="(require(`../../assets/entrepreneurs/${e.business.src}`))"/>
                      {{ e.business.progress }}% funded
                      <v-progress-linear
                        :value="e.business.progress"
                        height="12"
                        rounded
                        color="#B6509E">
                      </v-progress-linear>
                    </v-card-text>
                    <v-card-actions>
                      <v-spacer/>
                      <v-btn class="lend-button" @click="validate(e.business.account)">Validate</v-btn>
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

  export default {
    data: () => ({
      entrepreneurs: [],
      allEntrepreneurs: [],
      dummyData: Entrepreneurs['entrepreneurs'],
      categories: [
        'Arts', 'Agriculture', 'Education', 'Environment', 'Technology'
      ],
      businessAccount: null,
      approval: true,
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
      goTo(id, account) {
        this.$router.push({
          path: `/details/${id}/${account}`,
          });
      },
      async getEntrepreneurs() {
        try {
          const body = { args: [], from: this.walletAddress }
          const { data } = await this.axios.post(
            `/api/v0/chains/ethereum/addresses/${this.$BITFINCA_CONTRACT}/contracts/bitfinca/methods/totalEntrepreneurs`,
            body
          );
        this.allEntrepreneurs = data.result.output;
      } catch (err) {
        console.log(err);
      }
      try {
        const entrepreneurs = [];
        for (const e in this.allEntrepreneurs) {
          const body = { args: [this.allEntrepreneurs[e]] }
          const { data } = await this.axios.post(
          `/api/v0/chains/ethereum/addresses/${this.$BITFINCA_CONTRACT}/contracts/bitfinca/methods/entrepreneurs`,
          body
        );
          entrepreneurs.push(data.result.output);
        }
        this.allEntrepreneurs = entrepreneurs;
      } catch (err) {
        console.log(err);
      }
        for (const e in this.allEntrepreneurs) {
          const { data } = await this.$axios.get('https://randomuser.me/api/', {
          params: {
            seed: this.allEntrepreneurs[e][2], // address
            results: 1,
            inc: 'name,picture,location'
          }
          });
          const person = data.results[0];
          const business = this.dummyData[this.allEntrepreneurs[e][1]];
          business['account'] = this.allEntrepreneurs[e][2];
          business['key'] = this.allEntrepreneurs[e][1];
          business['progress'] = Math.round((this.allEntrepreneurs[e][4]/this.allEntrepreneurs[e][3])*100);
          this.entrepreneurs.push({person: person, business: business});
        }
      },
      async validate(account) {
        try {
          let body = { args: [account, this.approval], from: this.walletAddress, signer: this.walletAddress };
          var {
          data: {
            result: { tx, submitted },
          },
           } = await this.axios.post(
            `/api/v0/chains/ethereum/addresses/${this.$BITFINCA_CONTRACT}/contracts/bitfinca/methods/validate`,
            body
          );
          if (!submitted) {
            // Get the signer from MetaMask
            const signer = this.$root.$_web3.getSigner(tx.from);
            // Format the transaction so that ethers.js can sign it
            const ethersTx = this.$root.$_cgutils.formatEthersTx(tx);
            // Submit the transaction to the blockchain
            const txResponse = await signer.sendTransaction(ethersTx);
            this.response = txResponse;
          }

          body = { args: [account, 1], from: this.walletAddress, signer: this.walletAddress };

          await this.axios.post(
            `/api/v0/chains/ethereum/addresses/${this.$TOKEN_CONTRACT}/contracts/finca_token/methods/incrementBalance`,
            body
          );
          if (!submitted) {
            // Get the signer from MetaMask
            const signer = this.$root.$_web3.getSigner(tx.from);
            // Format the transaction so that ethers.js can sign it
            const ethersTx = this.$root.$_cgutils.formatEthersTx(tx);
            // Submit the transaction to the blockchain
            const txResponse = await signer.sendTransaction(ethersTx);
            this.response = txResponse;
          }
      } catch (err) {
        console.log(err);
      }
      },
    }
  }
</script>