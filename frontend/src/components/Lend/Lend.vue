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
                label="Applicant name"
                required
              ></v-text-field>
              </v-col>
               <v-col cols="12"
              md="6">
              <v-text-field
                v-model="initialDeposit"
                label="Initial Deposit"
                required
              ></v-text-field>
              </v-col>
            </v-row>
             <v-row>
             <v-col cols="12"
              md="11">
              <v-text-field
                v-model="walletAddress"
                label="Wallet Address"
                required
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
        v-for="lender in lenders"
        :key="lender"
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
    initialDeposit: 0,
    walletAddress: null,
    lenders: null,
  }),
  created() {
      Promise(this.fetchUsers());
  },
  methods: {
    async addLender() {
      try {
        const { data } = await this.$axios.post(
          `/api/v0/chains/ethereum/addresses/${this.$CONTRACT_LABEL_OR_ADDRESS}/contracts/mltitoken/methods/totalSupply`, // TODO fix this
        );
        this.response = data;
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