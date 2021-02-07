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
                      v-model="lendAmount"
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
                    v-for="lender in lenders"
                    :key="lender"
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
                    Data data data
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
import People from '../../assets/People.json'

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
      details: {
        type: Object,
        default: null,
      },
    },
    data: () => ({
      name: 'Some Business',
      description: 'Information about some business',
      progress: 0,
      lendAmount: 5,
      image: 'icons/clip-order-complete-1.png',
      lenders: null,
      validators: null,
      personData: null,
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
    created() {
      this.updateVariables();
      Promise(this.fetchUsers(Math.random()*20+3, Math.random()*20+2));
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
      updateVariables() {
        const entrepreneur = Entrepreneurs['entrepreneurs'][this.id];
        this.name = entrepreneur.title;
        this.description = entrepreneur.description;
        this.progress = entrepreneur.progress;
        this.image = 'entrepreneurs/'+ entrepreneur.src;
        this.personData = People['results'][entrepreneur.id]
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
      async fetchUsers(numLenders, numValidators) {
        const lResponse = await this.$axios.get('https://randomuser.me/api/', {
        params: {
          seed: 'le'+this.id,
          results: parseInt(numLenders),
          inc: 'name,picture,location'
        }
        });
        this.lenders = lResponse.data.results;
        const vResponse= await this.$axios.get('https://randomuser.me/api/', {
        params: {
          seed: 'va'+ this.id,
          results: parseInt(numValidators),
          inc: 'name,picture,location'
        }
        });
        this.validators = vResponse.data.results;

      }
    }
  }
</script>