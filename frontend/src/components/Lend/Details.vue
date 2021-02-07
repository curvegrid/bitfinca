<template>
  <v-app id="inspire">
    <v-container>
      <h1 class="page-title">
        Entrepreneur Details
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
              cols="7"
              md="7"
              >
              <v-card color=transparent elevation=0>
              <v-card-text>
                <v-img contain :src="require(`../../assets/${image}`)"/>
              </v-card-text>
              </v-card>
              </v-col>
              <v-col cols="7"
              md="5">
              <v-card color=transparente elevation=0>
                <v-card-title>
                   <h2 class="aligh-left page-header-one">{{ name }}</h2>
                </v-card-title>
              <v-card-text>
                <p class="body-text">{{ description }}</p>
                <p class=body-text style="font-size: 18px;"><strong>Target: </strong> {{target}}</p>
                <p class=body-text style="font-size: 18px;"><strong>Credit Score: </strong> {{creditScore}}</p>
              </v-card-text>
              <v-spacer/>
              <v-card-text>
                {{ progress }}% funded
                <v-progress-linear
                    :value=progress
                    height="12"
                    rounded
                    color="#B6509E">
                </v-progress-linear>
              </v-card-text>
              <v-card-actions>
                <v-row>
                  <v-col
                    md=7>
                    <v-text-field
                      label="Loan Amount"
                      type=number
                      v-model="loanAmount"
                      suffix= "Tokens"
                    />
                  </v-col>
                  <v-col>
                    <v-btn class="mb-4 lend-button" @click="lendNow(i)">Lend now</v-btn>
                  </v-col>
                </v-row>
              </v-card-actions>
              </v-card>

              </v-col>
            </v-row>
            <v-divider/>
            <v-card color=transparent elevation=0>
              <v-card-title class="page-header-one">
                About me <v-spacer/>
                <v-avatar><v-img :src="personData.picture.large" /></v-avatar>
              </v-card-title>
              <v-card-text class=body-text>
                <v-row>
                  <v-col>
                  <p><strong>{{personData.name.first}} {{personData.name.last}}</strong> {{personData.location.city}}, {{personData.location.country}}</p>
                  </v-col>
                  <v-col>
                  <p>Contact: {{personData.email}}</p>
                  </v-col>
                </v-row>
                </v-card-text>
            </v-card>
              <v-timeline
                align-top
                :dense="$vuetify.breakpoint.smAndDown"
              >
                <v-timeline-item
                  v-for="(update, i) in updates"
                  :key="i"
                  :color="update.color"
                  fill-dot
                >
                  <v-card
                    :color="update.color"
                    dark
                  >
                    <v-card-title class="title">
                      {{ update.title }}
                    </v-card-title>
                    <v-card-text class="white text--primary">
                      <p class="body-text">
                        {{ update.text }}
                      </p>
                      <v-btn
                        :color="update.color"
                        class="mx-0"
                        outlined
                      >
                        Read more
                      </v-btn>
                    </v-card-text>
                  </v-card>
                </v-timeline-item>
              </v-timeline>
            </v-sheet>
          </v-col>

          <v-col>
            <v-sheet
              rounded="lg"
              min-height="300"
            >
                       <v-container>
              <v-card>
              <v-card tile elevation=0>
                <v-card-title class=page-header-one>Lenders</v-card-title>
                <v-card-text>
                  <v-avatar
                    v-for="(lender, i) in lenders"
                    :key="i"
                    :current-avatar="lender"
                    color="primary"
                    size="50"
                    class="ma-2"
                  >
                    <img :src="lender.picture.large">
                  </v-avatar>
                </v-card-text>
              </v-card>
              <v-card tile elevation=0>
                <v-card-title class=page-header-one>Validators</v-card-title>
                <v-card-text>
                  <v-avatar
                    v-for="(v,i) in validators"
                    :key="i"
                    :current-avatar="v"
                    color="primary"
                    size="50"
                    class="ma-2"
                  >
                    <img :src="v.picture.large">
                  </v-avatar>
                </v-card-text>
              </v-card>
              </v-card>
            </v-container>
            <v-container>
              <v-card >
                <v-card-title class=page-header-one>Documentation</v-card-title>
                  <v-card-text>
                    <a><p>Financial Documents</p></a>
                    <a><p>Business Registration</p></a>
                    <a><p>Detailed Business Plan</p></a>
                  </v-card-text>
                </v-card>
            </v-container>
            </v-sheet>
          </v-col>
        </v-row>
      </v-container>
    </v-main>
  </v-app>
</template>

<script>
import Entrepreneurs  from '../../assets/DummyData.json';

  export default {
    props: {
      create: {
        type: Boolean,
        default: false,
      },
      id: {
        type: String,
        default: '-1',
      },
      account: {
        type: String,
        default: '-1',
      },
      details: {
        type: Object,
        default: null,
      },
    },
    data: () => ({
      name: 'Some Business',
      description: 'Information about some business',
      progress: 0,
      loanAmount: 5,
      target: 0,
      creditScore: 650,
      image: 'icons/clip-order-complete-1.png',
      lenders: null,
      validators: null,
      personData: null,
      walletAddress: null,
      updates: [
        {
          title: 'Product Launch',
          color: 'red lighten-2',
          text: 'Update on my business',
        },
        {
          title: 'Hit Sales',
          color: 'purple darken-1',
          text: 'Update on my business',
        },
        {
          title: 'Update',
          color: 'green lighten-1',
          text: 'Update on my business',
        },
        {
          title: 'Event Recap',
          color: 'indigo',
          text: 'Update on my business',
        },
      ],
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
      await this.updateVariables();
      await this.fetchUsers(Math.random()*20+3, Math.random()*20+2);
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
      async updateVariables() {
        const business = Entrepreneurs['entrepreneurs'][this.id];
        business['account'] = this.account;
        const body = { args: [this.account], from: this.walletAddress}
        const response = await this.axios.post(`api/v0/chains/ethereum/addresses/${this.$BITFINCA_CONTRACT}/contracts/bitfinca/methods/entrepreneurs`, body)
        const info = response.data.result.output;
        this.creditScore = info[4];
        this.target = info[3];
        const { data } = await this.$axios.get('https://randomuser.me/api/', {
        params: {
          seed: this.account,
          results: 1,
          inc: 'name,picture,location, email'
        }
        });
        this.personData = data.results[0];
        this.name = business.title;
        this.description = business.description;
        this.progress = business.progress;
        this.image = 'entrepreneurs/'+ business.src;
      },
      async lendNow() {
        try {
          const body = { args: [this.$BITFINCA_ADDRESS, this.loanAmount], from: this.walletAddress, signer: this.walletAddress };
          await this.axios.post(
            `/api/v0/chains/ethereum/addresses/${this.$TOKEN_CONTRACT}/contracts/finca_token/methods/transfer`,
            body
          );
      } catch (err) {
        console.log(err);
      }
      },
      async fetchUsers(numLenders, numValidators) {
        const lResponse = await this.$axios.get('https://randomuser.me/api/', {
        params: {
          seed: 'le'+this.id,
          results: parseInt(numLenders),
          inc: 'picture'
        }
        });
        this.lenders = lResponse.data.results;
        const vResponse= await this.$axios.get('https://randomuser.me/api/', {
        params: {
          seed: 'va'+ this.id,
          results: parseInt(numValidators),
          inc: 'picture'
        }
        });
        this.validators = vResponse.data.results;

      }
    }
  }
</script>