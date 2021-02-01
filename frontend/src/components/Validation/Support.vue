<template>
  <div id="support">
    <v-container class=dark>
      <h1 class="page-title">
        Support Entrepreneurs. Earn tokens.
      </h1>
      <v-card>
        <v-card-title class="page-header-three">
          The verification of businesses is crowd-sourced. We need you!</v-card-title>
        <v-card-text class="body-text">
          Bitfinca is built on the Ethereum blockchain and smart contracts, making sure that it is transparent, efficient, and secure. Join our decentralized network of validators who stake some amount of tokens, earn a fee for it, and provide documents to a trusted third party.</v-card-text>
      </v-card>
    </v-container>
     <v-container>
      <v-card>
        <v-card-title class="page-header-one" style="font-size: 32px;">Validator Application</v-card-title>
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
              md="5">
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
</template>

<style>
</style>