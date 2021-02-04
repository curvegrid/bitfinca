<template>
  <div>
    <v-container>
      <h1 class="page-title">
        Become a Lender
      </h1>
      <v-card>
        <v-card-title class="page-header-two">
          Choose businesses to support. Leave the rest to us!</v-card-title>
        <v-card-text class="body-text">
          <p>Investors will always be able to make more money with lending than they would
            just holding the coin. Borrowers will always need capital, and if they pay it back then they will have more capital for another loan if needed.
          </p>
        </v-card-text>
      </v-card>
    </v-container>

  <div>
    <v-container>
      <v-card>
        <v-card-title class="page-header-one" style="font-size: 32px;">Lender Application</v-card-title>
        <v-card-text class="body-text">
          <v-form>
            <v-row>
              <v-col cols="12"
              md="6">
              <v-text-field
                v-model="name"
                :rules="[rules.required, rules.counter]"
                label="Applicant name"
              ></v-text-field>
              </v-col>
               <v-col cols="12"
              md="6">
              <v-text-field
                v-model="initialDeposit"
                label="Initial Deposit"
                type=number
                :rules="[rules.funding]"
                required
              ></v-text-field>
              </v-col>
            </v-row>
             <v-row>
             <v-col cols="12"
              md="10">
              <v-text-field
                v-model="walletAddress"
                label="Wallet Address"
                required
                readonly
              ></v-text-field>
              </v-col>
              <v-spacer/><v-btn @click="addLender()" class="mt-10 ma-4 page-button">Submit</v-btn>
            </v-row>
          </v-form>
        </v-card-text>
      </v-card>
    </v-container>
  </div>


    <v-container>
      <h1 class="page-title">
       Join a community of lenders
      </h1>
      <v-avatar
        v-for="(lender, i) in lenders"
        :key="i"
        :current-avatar="lender"
        color="primary"
        size="128"
        class="ma-2"
      >
        <img :src="lender.picture.large">
      </v-avatar>
    </v-container>
  </div>
</template>

<script>
export default {
  name: "Lend",

  data: () => ({
    name: '',
    initialDeposit: 100,
    walletAddress: null,
    lenders: null,
    rules: {
      required: value => !!value || 'Required.',
      counter: value => value.length >= 2 || 'Min 2 characters',
      funding: value => value >= 0 || 'Must be a positive amount',
    },
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
    await this.fetchUsers();
  },
  methods: {
    connectToWeb3() {
      const web3Config = this.$root.$_cgutils.connectToWeb3(window.web3);
      console.log("This web3config", web3Config);
      this.$root.$_web3 = web3Config.provider;
      this.$root.$_web3Available = web3Config.web3Available;
    },
    // Get the Eth Address currently selected in MetaMask
    async getActiveAccount() {
      const accounts = await this.$root.$_web3.listAccounts();
      return accounts[0];
    },
    async addLender() {
      const account = await this.getActiveAccount();
      console.log("This account", account);
      try {
        const body = {
          args: [
            this.name,
            this.walletAddress
          ],
          from: account,
          signer: account
        }
        await this.axios.post(
          `/api/v0/chains/ethereum/addresses/${this.$BITFINCA_CONTRACT}/contracts/bitfinca/methods/addLender`, body
        );
      } catch (err) {
        console.log(err);
      }
    },
    async fetchUsers() {
      const lResponse = await this.$axios.get('https://randomuser.me/api/', {
      params: {
        seed: 'lender',
        results: 15,
        inc: 'name,picture,location'
      }
      });
      this.lenders = lResponse.data.results;
    }
  },
};
</script>