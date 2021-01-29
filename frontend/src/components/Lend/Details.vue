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
              <v-col>
                <h2 class="aligh-left page-header-one">My Business</h2>
                <p class="body-text">Information about my business</p>
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
  }
</script>