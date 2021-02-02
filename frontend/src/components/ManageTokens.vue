<template>
  <v-app id="inspire">
    <v-container>
      <h1 class="page-title">
        Manage Tokens
      </h1>
    </v-container>
    <v-main class="grey lighten-5" style="padding: 20px 0px 0px;">
      <v-container>
        <v-row>
          <v-col
            cols="12"
            sm="8"
          >
            <v-sheet
              min-height="70vh"
              rounded="lg"
            >
            <v-row>
              <v-col
              cols="4"
              md="3"
              >
                <img height=150 :src="require('../assets/icons/clip-payment.png')">
              </v-col>
              <v-col>
                <h2 class="aligh-left page-header-one">Account Overview</h2>
                <p class="body-text">Token Balance: </p>
              </v-col>
            </v-row>
            <v-divider/>
            <v-container>
              <v-row>
                <v-card elevation=0 width=100%>
                  <v-card-title>
                    <h2 class="aligh-left page-header-one">Payments Due </h2>
                  </v-card-title>
                  <v-card-text>
                    <v-simple-table
                      fixed-header
                      height="300px"
                    >
                      <template v-slot:default>
                        <thead>
                          <tr>
                            <th class="text-left">
                              Name
                            </th>
                            <th class="text-left">
                              Amount
                            </th>
                          </tr>
                        </thead>
                        <tbody>
                          <tr
                            v-for="item in payments"
                            :key="item.name"
                          >
                            <td>{{ item.name }}</td>
                            <td>{{ item.amount }}</td>
                          </tr>
                        </tbody>
                      </template>
                    </v-simple-table>
                  </v-card-text>
                </v-card>
              </v-row>
              <v-row>
                  <v-card elevation=0 width=100%>
                  <v-card-title>
                    <h2 class="aligh-left page-header-one">Transactions</h2>
                  </v-card-title>
                  <v-card-text>
                    <v-data-table
                      fixed-header
                      height="300px"
                    >
                      <template v-slot:default>
                        <thead>
                          <tr>
                            <th class="text-left">
                              Name
                            </th>
                            <th class="text-left">
                              Amount
                            </th>
                          </tr>
                        </thead>
                        <tbody>
                          <tr
                            v-for="item in transactions"
                            :key="item.name"
                          >
                            <td>{{ item.name }}</td>
                            <td>{{ item.amount }}</td>
                          </tr>
                        </tbody>
                      </template>
                    </v-data-table>
                  </v-card-text>
                </v-card>
              </v-row>
            </v-container>
            </v-sheet>
          </v-col>

          <v-col>
            <v-sheet
              rounded="lg"
              min-height="300"
            >
              <v-card elevation=0>
                <v-card-title class=page-header-one>Details</v-card-title>
                <v-card-text class=body-text>
                  <v-row>
                    <v-col>
                      <strong>Total Supply</strong>
                    </v-col>
                    <v-col>
                      {{ total.output }}
                    </v-col>

                  </v-row></v-card-text>
              </v-card>

               <v-card elevation=0>
                <v-card-title class=page-header-one>Actions</v-card-title>
                <v-card-text class=body-text>
                  <v-row>
                    <v-col md=5>
                      <strong>Deposit</strong>
                    </v-col>
                    <v-col md=5>
                      <v-text-field @click="deposit()" v-model="depositAmount" class=ma-0 dense append-icon="mdi-plus"></v-text-field>
                    </v-col>
                    </v-row><v-row>
                     <v-col md=5>
                      <strong>Withdraw</strong>
                    </v-col>
                    <v-col md=5>
                      <v-text-field @click="withdraw()" v-model="withdrawAmount" class=ma-0 dense append-icon="mdi-minus"></v-text-field>
                    </v-col>

                  </v-row></v-card-text>
              </v-card>

            </v-sheet>
          </v-col>
        </v-row>
      </v-container>
    </v-main>
  </v-app>
</template>

<script>
  export default {
    data: () => ({
      total: -1,
      transactions: null,
      depositAmount: 0,
      withdrawAmount: 0,
      payments: [
        {
          name: 'Lender 1', amount: '5000',
        }
      ],
    }),

    async created() {
      // If MetaMask's privacy mode is enabled, we must get the user's permission
      // in order to be able to access their signers
      if (window.ethereum != null) { // true if user is using MetaMask
        await window.ethereum.enable();
      }

      this.axios = this.$root.$_cgutils.createAxiosInstance(this.$BASE_URL, this.$API_KEY);
      const gtotal = this.getTotalTokens();
      const gTrans = this.getTransactions();
      Promise.all([gtotal, gTrans]);
    },
    methods: {
      async getTotalTokens() {
        try {
        const { data } = await this.axios.post(
          `/api/v0/chains/ethereum/addresses/${this.$CONTRACT_LABEL_OR_ADDRESS}/contracts/mltitoken/methods/totalSupply`, // TODO fix this
        );
          this.total = data.result;
        } catch (err) {
          console.log(err);
        }
      },
      async getTransactions() {
        try {
        const { data } = await this.axios.post(
          `/api/v0/events?contract_address=${this.$CONTRACT_LABEL_OR_ADDRESS}`, // TODO fix this
        );
          this.transactions = data;
        } catch (err) {
          console.log(err);
        }
      },
       async getPaymentsDue() {
        try {
        const { data } = await this.$axios.post(
          `/api/v0/chains/ethereum/addresses/${this.$CONTRACT_LABEL_OR_ADDRESS}/contracts/mltitoken/methods/totalSupply`, // TODO fix this
        );
          this.response = data;
        } catch (err) {
          console.log(err);
        }
      },
      deposit() {
        console.log("Deposit", this.depositAmount);
      },
      withdraw() {
        console.log("Withdraw", this.withdrawAmount);
      }
    }
  }
</script>