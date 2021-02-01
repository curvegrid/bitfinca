<template>
  <div>
    <v-container>
      <h1 class="page-title">
        Become a Lender
      </h1>
    </v-container>
    <v-main class="grey lighten-5" style="padding: 20px 0px 0px;">
      <v-container>
        <v-row>
          <v-col cols="2">
            <v-sheet rounded="lg">
              <v-list rounded>
                <v-list-item
                  v-for="c in categories"
                  :key="c"
                  link
                >
                  <v-list-item-content>
                    <v-list-item-title class="body-text" style="font-weight: 500;">
                      {{ c }}
                    </v-list-item-title>
                  </v-list-item-content>
                </v-list-item>

                <v-divider class="my-2"></v-divider>
                <v-list-item
                  link
                  color="grey lighten-4"
                >
                  <v-list-item-content>
                    <v-list-item-title class="body-text" style="font-weight: 700;">
                      Refresh
                    </v-list-item-title>
                  </v-list-item-content>
                </v-list-item>
              </v-list>
            </v-sheet>
          </v-col>

          <v-col>
            <h2 class="page-header-two">Entrepreneurs</h2>
            <v-sheet
              min-height="70vh"
              rounded="lg"
            >
             <v-container>
              <v-row>
                <v-col
                  v-for="(e, i) in entrepreneurs"
                  :key="i"
                  cols="4"
                >
                  <v-card>
                    <v-card-title class=body-text>
                      {{ e.title }}
                      <v-spacer/>
                      <v-avatar><img :src="e.avatar"></v-avatar>
                    </v-card-title>
                    <v-card-text>
                      <img height=150 :src="(require(`../../assets/entrepreneurs/${e.src}`))"/>
                      {{ e.progress }}% funded
                      <v-progress-linear
                        :value="e.progress"
                        height="12"
                        rounded
                        color="#B6509E">
                      </v-progress-linear>
                    </v-card-text>
                    <v-card-actions>
                      <v-btn class="page-button">Learn more</v-btn>
                      <v-spacer/>
                      <v-btn class="lend-button" @click="lendNow(i)">Lend now</v-btn>
                    </v-card-actions>
                  </v-card>
                </v-col>
              </v-row>
            </v-container>
            </v-sheet>
          </v-col>
        </v-row>
      </v-container>
    </v-main>
  </div>
</template>

<script>
  export default {
    data: () => ({
      entrepreneurs: [
        {
          title: 'Coworking Space',
          avatar: 'https://randomuser.me/api/portraits/men/22.jpg',
          src: 'pablo-finance.svg',
          progress: 22,
        },
        {
          title: 'Agriculture',
          avatar: 'https://randomuser.me/api/portraits/men/66.jpg',
          src: 'pablo-eco-technologies.svg',
          progress: 66,
        },
        {
          title: 'Small Business',
          avatar: 'https://randomuser.me/api/portraits/women/44.jpg',
          src: 'pablo-payment-processed.svg',
          progress: 44,
        },
        {
          title: 'Resturant',
          avatar: 'https://randomuser.me/api/portraits/women/16.jpg',
          src: 'pablo-order-completed.svg',
          progress: 16,
        },
        {
          title: 'Education for All',
          avatar: 'https://randomuser.me/api/portraits/men/18.jpg',
          src: 'pablo-education.svg',
          progress: 18,
        },
        {
          title: 'Assessibility',
          avatar: 'https://randomuser.me/api/portraits/men/54.jpg',
          src: 'pablo-help-and-care.svg',
          progress: 54,
        },
        {
          title: 'Facial Recognition',
          avatar: 'https://randomuser.me/api/portraits/women/24.jpg',
          src: 'pablo-face-recognition.svg',
          progress: 24,
        },
        {
          title: 'Blogging',
          avatar: 'https://randomuser.me/api/portraits/women/11.jpg',
          src: 'pablo-blogging.svg',
          progress: 11,
        },
        {
          title: 'Record Label',
          avatar: 'https://randomuser.me/api/portraits/men/26.jpg',
          src: 'pablo-friendship.svg',
          progress: 26,
        },
        {
          title: 'Mining',
          avatar: 'https://randomuser.me/api/portraits/men/49.jpg',
          src: 'pablo-bitcoin-mining.svg',
          progress: 49,
        },
        {
          title: 'Artificial Intelligence',
          avatar: 'https://randomuser.me/api/portraits/women/27.jpg',
          src: 'pablo-artifficial-intelligence.svg',
          progress: 27,
        },
        {
          title: 'Car Rental',
          avatar: 'https://randomuser.me/api/portraits/men/40.jpg',
          src: 'pablo-car-rental.svg',
          progress: 40,
        },
      ],
      categories: [
        'Arts', 'Agriculture', 'Education', 'Environment', 'Technology'
      ],
    }),
    methods: {
      async lendNow(id) {
        try {
          const body = { args: [id] }
          const { data } = await this.$axios.post(
            `/api/v0/chains/ethereum/addresses/${this.$CONTRACT_LABEL_OR_ADDRESS}/contracts/mltitoken/methods/totalSupply`, // fix this
            body
          );
        this.response = data;
      } catch (err) {
        console.log(err);
      }
      },
    }
  }
</script>