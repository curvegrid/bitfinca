<template>
  <div id="support">
    <v-container class=dark>
      <h1 class="page-title">
        Support Entrepreneurs. Earn tokens.
      </h1>
      <v-card>
        <v-card-title class="page-header-three">
          The verification of businesses is crowd-sourced. We need you!</v-card-title>
        <v-card-text class="body-text">
          Bitfinca is built on the Ethereum blockchain and smart contracts, making sure that it is transparent, efficient, and secure. Join our decentralized network of validators who stake some amount of tokens, earn a fee for it, and provide documents to a trusted third party.</v-card-text>
      </v-card>
    </v-container>
     <v-container>
      <v-card>
        <v-card-title class="page-header-one" style="font-size: 32px;">Validator Application</v-card-title>
        <v-card-text class="body-text">
          <v-form>
            <v-row>
              <v-col cols="12"
              md="6">
              <v-text-field
                v-model="name"
                label="Applicant name"
                :rules="[rules.required, rules.counter]"
                required
              ></v-text-field>
              </v-col>
               <v-col cols="12"
              md="5">
              <v-text-field
                v-model="walletAddress"
                label="Wallet Address"
                required
                readonly
              ></v-text-field>
              </v-col>
              <v-spacer/><v-btn @click="addValidator()" class="mt-10 ma-4 page-button">Submit</v-btn>
            </v-row>
          </v-form>
        </v-card-text>
      </v-card>
    </v-container>
  </div>
</template>

<script>
export default {
  name: "Borrow",

  data: () => ({
    name: '',
    walletAddress: null,
    rules: {
      required: value => !!value || 'Required.',
      counter: value => value.length >= 2 || 'Min 2 characters',
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
    console.log("This account", this.walletAddress);
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
    async addValidator() {
      const account = await this.getActiveAccount();
      console.log("This account", account);
      try {
        const body = {
          args: [this.name, this.walletAddress],
          from: account,
          signer: account,
        }
        const { data } = await this.axios.post(
          `/api/v0/chains/ethereum/addresses/${this.$BITFINCA_CONTRACT}/contracts/bitfinca/methods/addValidator`, body
        );
        this.response = data;
      } catch (err) {
        console.log(err);
      }
    },
  },
};
</script>
