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
                <p class="body-text">Token Balance: {{ tokenBalance }}</p>
              <v-card-title class="page-header-one">
                About me <v-spacer/>
                <v-avatar><v-img :src="userData.picture.large" /></v-avatar>
              </v-card-title>
              <v-card-text class=body-text>
                <v-row>
                  <v-col>
                  <p><strong>{{userData.name.first}} {{userData.name.last}}</strong> {{userData.location.city}}, {{userData.location.country}}</p>
                  <p><strong>Role:</strong> {{role}}</p>
                  </v-col>
                  <v-col>
                  <p>Contact: {{userData.email}}</p>
                  </v-col>

                </v-row>
                </v-card-text>
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
                      height="350px"
                      :headers="headers"
                      :items="items"
                    ></v-data-table>
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
                    <v-col md=3>
                      <strong>Deposit</strong>
                    </v-col>
                    <v-col md=8>
                      <v-row>
                      <v-text-field v-model="depositAmount" class=ma-0 dense></v-text-field>
                      <v-btn icon @click="deposit()"><v-icon>mdi-plus</v-icon></v-btn>
                      </v-row>
                    </v-col>
                    </v-row><v-row>
                     <v-col md=3>
                      <strong>Withdraw</strong>
                    </v-col>
                    <v-col md=8>
                      <v-row>
                      <v-text-field v-model="withdrawAmount" class=ma-0 dense></v-text-field>
                      <v-btn icon @click="withdraw()"><v-icon>mdi-minus</v-icon></v-btn>
                      </v-row>
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
      account: null,
      total: -1,
      tokenBalance: -1,
      transactions: [],
      items: [],
      depositAmount: 0,
      withdrawAmount: 0,
      headers: [],
      role: "",
      userData: {
        "name": {
              "title": "Ms",
              "first": "Judy",
              "last": "Freeman"
          },
          "location": {
              "street": {
                  "number": 3896,
                  "name": "Oak Lawn Ave"
              },
              "city": "Albany",
              "state": "Tasmania",
              "country": "Australia",
              "postcode": 6633,
              "coordinates": {
                  "latitude": "-80.5181",
                  "longitude": "89.6871"
              },
              "timezone": {
                  "offset": "-12:00",
                  "description": "Eniwetok, Kwajalein"
              }
          },
          "email": "judy.freeman@example.com",
          "picture": {
              "large": "https://randomuser.me/api/portraits/women/72.jpg",
              "medium": "https://randomuser.me/api/portraits/med/women/72.jpg",
              "thumbnail": "https://randomuser.me/api/portraits/thumb/women/72.jpg"
          }
      },
      payments: [
        {
          name: 'Lender 1', amount: '210',
        },
        {
          name: 'Lender 2', amount: '20',
        },
        {
          name: 'Lender 3', amount: '240',
        },
        {
          name: 'Lender 4', amount: '120',
        },
        {
          name: 'Lender 5', amount: '80',
        },
      ],
    }),
    async created() {
      try {
      // If MetaMask's privacy mode is enabled, we must get the user's permission
      // in order to be able to access their signers
      const Web3 = require('web3');
      if (window.ethereum != null) { // true if user is using MetaMask
        window.web3 = new Web3(window.ethereum);
        await window.ethereum.enable();
      }
      this.connectToWeb3();
      this.axios = this.$root.$_cgutils.createAxiosInstance(this.$BASE_URL, this.$API_KEY);
      this.account = await this.getActiveAccount();
      const gtotal = this.getTotalTokens();
      const gTrans = this.getTransactions();
      const gBalance = this.getTokenBalance();
      Promise.all([gtotal, gTrans, gBalance]).then(this.makeModel());
      await this.getUser();
      } catch (err) {
        console.log(err);
      }
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
      async getTotalTokens() {
        try {
        const { data } = await this.axios.post(
          `/api/v0/chains/ethereum/addresses/finca_token/contracts/finca_token/methods/totalSupply`,
        );
          this.total = data.result;
        } catch (err) {
          console.log(err);
        }
      },
      async getTransactions() {
        try {
          // retrieve the Bitfinca Token address
          const {
            data: {
              result: { address },
            },
          } = await this.axios.get(
            `/api/v0/chains/ethereum/addresses/finca_token`,
          );

          const { data } = await this.axios.get(
            `/api/v0/events?contract_address=${address}`,
          );
          this.transactions = data.result;
        } catch (err) {
          console.log(err);
        }
        for (const t of this.transactions) {
          this.items.push({
            triggeredAt: t.triggeredAt,
            name: t.event.name,
            contractName: t.transaction.contract.name,
            contractAddress: t.transaction.contract.addressLabel,
            methodName: t.transaction.method.name,
            value: t.transaction.method.inputs[0].value,
          })
        }
      },
      async getTokenBalance() {
        try {
          const body = {
            args: [ this.account ],
            from: this.account,
          }
          const { data } = await this.axios.post(
            `/api/v0/chains/ethereum/addresses/finca_token/contracts/finca_token/methods/balanceOf`, body,
          );
            this.tokenBalance = data.result.output;
        } catch (err) {
          console.log(err);
        }
      },
      makeModel() {
        this.headers = [
          {text: 'Time', value: 'triggeredAt'},
          {text: 'Name', value: 'name'},
          {text: 'Contract', value:'contractName'},
          {text: 'Contract Address', value:'contractAddress'},
          // {text: 'Method', value: 'methodName'},
          {text: 'Value', value: 'value'}
          ]
        for (const t of this.transactions) {
          this.items.push({
            triggeredAt: t.triggeredAt,
            name: t.event.name,
            contractName: t.transaction.contract.name,
            contractAddress: t.transaction.contract.address,
            methodName: t.transaction.method.name,
            value: t.transaction.method.inputs,
          })
        }
      },
      async deposit() {
        try{
        const body = {
          args: [this.depositAmount],
          from: this.account,
          signer: this.account
        }
        const {
          data: {
            result: { tx, submitted },
          },
        } = await this.axios.post(`/api/v0/chains/ethereum/addresses/finca_token/contracts/finca_token/methods/deposit`, body);

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
      async withdraw() {
        try {
        const body = {
          args: [this.withdrawAmount],
          from: this.account,
          signer: this.account
        }
        const {
          data: {
            result: { tx, submitted },
          },
        } = await this.axios.post(`/api/v0/chains/ethereum/addresses/finca_token/contracts/finca_token/methods/withdraw`, body);
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
      async getUser() {
      const response = await this.$axios.get('https://randomuser.me/api/', {
          params: {
            seed: this.account,
            results: 1,
            inc: 'name,picture,location, email'
          }
        });
      this.userData = response.data.results[0];
      try {
      const body = { args: [this.account], from: this.account }
      const { data } = await this.axios.post(
        `api/v0/chains/ethereum/addresses/bitfinca/contracts/bitfinca/methods/addressToRole`,
        body
      );
      const role = data.result.output;
      if (role[0]){
        this.role += "Entrepreneur ";
      }
      if (role[1]){
        this.role += "Validator ";
      }
      if (role[2]){
        this.role += "Lender ";
      }
      console.log(this.role);
      } catch (err) {
        console.log(err);
      }
    },
    }
  }
</script>