<template>
  <v-app id="inspire">
    <v-container>
      <h1 class="page-title">
        Dashboard
      </h1>
    </v-container>
    <v-main class="grey lighten-5" style="padding: 20px 0px 0px;">
      <v-container>
        <v-row>
          <!-- <v-col
            cols="12"
            sm="2"
          >
            <v-sheet
              rounded="lg"
              min-height="268"
            >
            </v-sheet>
          </v-col> -->

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
              md="5"
              >
                <img height=300 :src="require('../../assets/icons/clip-order-complete-1.png')">
              </v-col>
              <v-col
               cols="7"
              md="6"
              >
                <h2 class="aligh-left page-header-one">Education for All</h2>
                <p class="body-text">Information about my business</p>
                <v-spacer/>
                  10% funded
                  <v-progress-linear
                    value="10"
                    height="12"
                    rounded
                    color="#B6509E">
                  </v-progress-linear>
              </v-col>
            </v-row>
            <v-divider/>
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
                <v-card-text>
                  <v-text-field
                    :v-model="requestAmount"
                    label="Amount"
                  />
                  <v-btn @click="requestFunds()" class="page-button">Request Additional Funding</v-btn>
                </v-card-text>
              </v-card>
            </v-container>

            <v-container>
              <v-card>
                <v-card-text>
                  <v-text-field
                    :v-model="requestAmount"
                    label="Amount"
                  />
                  <v-btn @click="updateTotalNeed()" class="page-button">Update Total Need</v-btn>
                </v-card-text>
              </v-card>
            </v-container>
            <!-- lenders -->
            <v-container>
              <v-card>
              <v-card tile elevation=0>
                <v-card-title class=page-header-one>My Lenders</v-card-title>
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
                <v-card-title class=page-header-one>My Validators</v-card-title>
                <v-card-text>
                  <v-avatar
                    v-for="v in validators"
                    :key="v"
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
    },
    data: () => ({
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
      requestAmount: 0,
      updateTotalNeed: 0,
    }),
    created() {
      Promise(this.fetchUsers(Math.random()*20+3, Math.random()*20+1));
    },
    methods: {
      async requestFunds() {
        try {
        const { data } = await this.$axios.post(
          `/api/v0/chains/ethereum/addresses/${this.$CONTRACT_LABEL_OR_ADDRESS}/contracts/mltitoken/methods/totalSupply`, // TODO fix this
        );
          this.response = data;
        } catch (err) {
          console.log(err);
        }
      },
      async updateNeed() {
        try {
        const { data } = await this.$axios.post(
          `/api/v0/chains/ethereum/addresses/${this.$CONTRACT_LABEL_OR_ADDRESS}/contracts/mltitoken/methods/totalSupply`, // TODO fix this
        );
          this.response = data;
        } catch (err) {
          console.log(err);
        }
      },
      async fetchUsers(numLenders, numValidators) {
        const lResponse = await this.$axios.get('https://randomuser.me/api/', {
        params: {
          seed: 'l'+this.id,
          results: parseInt(numLenders),
          inc: 'name,picture,location'
        }
        });
        this.lenders = lResponse.data.results;
        const vResponse= await this.$axios.get('https://randomuser.me/api/', {
        params: {
          seed: 'v'+ this.id,
          results: parseInt(numValidators),
          inc: 'name,picture,location'
        }
        });
        this.validators = vResponse.data.results;
      },
    }
  }
</script>