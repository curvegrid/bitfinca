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
                <h2 class="aligh-left page-header-one">My Account</h2>
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
              <!-- Right col -->

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
      payments: [
        {
          name: 'Lender 1', amount: '5000',
        }
      ],
      transactions: [
        {
          name: 'Lender 1', amount: '-5000',
        }
      ],
    }),
    methods: {
      async getTotalTokens() {
        try {
        const { data } = await this.$axios.post(
          `/api/v0/chains/ethereum/addresses/${this.$CONTRACT_LABEL_OR_ADDRESS}/contracts/mltitoken/methods/totalSupply`, // TODO fix this
        );
          this.response = data;
        } catch (err) {
          console.log(err);
        }
      },
      async getTransactions() {
        try {
        const { data } = await this.$axios.post(
          `/api/v0/chains/ethereum/addresses/${this.$CONTRACT_LABEL_OR_ADDRESS}/contracts/mltitoken/methods/totalSupply`, // TODO fix this
        );
          this.response = data;
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
    }
  }
</script>