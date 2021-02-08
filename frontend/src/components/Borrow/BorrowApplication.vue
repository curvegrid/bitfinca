<template>
  <div>
    <v-container>
      <h1 class="page-title">
        Take the first step.
      </h1>
      <v-card>
        <v-card-title class="page-header-one" style="font-size: 32px;">Business Application</v-card-title>
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
              md="6">
                <v-text-field
                  v-model="businessName"
                  :rules="[rules.required, rules.counter]"
                  label="Business Name"
                  required
                ></v-text-field>
              </v-col>
            </v-row>
             <v-row>
              <v-col cols="12"
              md="6">
              <v-text-field
                v-model="target"
                label="Amount Needed"
                :rules="[rules.required, rules.funding]"
                required
                type=number
              ></v-text-field>
              </v-col>
             <v-col cols="12"
              md="5">
              <v-text-field
                v-model="walletAddress"
                maxlength="34"
                label="Wallet Address"
                readonly
                required
              ></v-text-field>
              </v-col>
              <v-spacer/><v-btn @click="addEntrepreneur()" class="mt-10 ma-4 page-button">Submit</v-btn>
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
    businessName: '',
    initialDeposit: 100,
    target: 0,
    walletAddress: null,
    rules: {
      required: value => !!value || 'Required.',
      counter: value => value.length >= 2 || 'Min 2 characters',
      funding: value => value > 0 || 'Must be a positive amount',
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
    async addEntrepreneur() {
      const account = await this.getActiveAccount();
      console.log("This account", account);
      try {
        const body = {
          args: [this.name, this.businessName, this.walletAddress, this.target, 0],
          from: account,
          signer: account,
        }
        const { data } = await this.axios.post(
          `/api/v0/chains/ethereum/addresses/bitfinca/contracts/bitfinca/methods/addEntrepreneur`, body
        );
        this.response = data;
        console.log(data);
      } catch (err) {
        console.log(err);
      }
    },
  },
};
</script>