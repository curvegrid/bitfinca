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
                v-model="firstname"
                :rules="nameRules"
                label="Applicant name"
                required
              ></v-text-field>
              </v-col>
               <v-col cols="12"
              md="6">
              <v-text-field
                v-model="firstname"
                :rules="nameRules"
                label="Initial Deposit"
                required
              ></v-text-field>
              </v-col>
            </v-row>
             <v-row>
             <v-col cols="12"
              md="11">
              <v-text-field
                v-model="firstname"
                :rules="nameRules"
                label="Wallet Address"
                required
              ></v-text-field>
              </v-col>
              <v-spacer/><v-btn class="mt-10 ma-4 page-button">Submit</v-btn>
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
        <img :src="lender">
      </v-avatar>
    </v-container>
  </div>
</template>

<script>
export default {
  name: "Lend",

  data: () => ({
    lenders: ['https://randomuser.me/api/portraits/men/22.jpg', 'https://randomuser.me/api/portraits/men/66.jpg',
    'https://randomuser.me/api/portraits/women/82.jpg', 'https://randomuser.me/api/portraits/women/54.jpg', 'https://randomuser.me/api/portraits/men/90.jpg',
    'https://randomuser.me/api/portraits/women/42.jpg', 'https://randomuser.me/api/portraits/women/2.jpg', 'https://randomuser.me/api/portraits/men/1.jpg',
    'https://randomuser.me/api/portraits/women/79.jpg', 'https://randomuser.me/api/portraits/men/49.jpg', 'https://randomuser.me/api/portraits/men/51.jpg',
    'https://randomuser.me/api/portraits/women/24.jpg', 'https://randomuser.me/api/portraits/men/4.jpg', 'https://randomuser.me/api/portraits/men/11.jpg',
    'https://randomuser.me/api/portraits/women/17.jpg',
    'https://randomuser.me/api/portraits/men/54.jpg']
  }),
};
</script>