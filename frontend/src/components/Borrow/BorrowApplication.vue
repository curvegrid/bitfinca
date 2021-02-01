<template>
  <div>
    <v-container>
      <h1 class="page-title">
        Take the first step.
      </h1>
      <v-card>
        <v-card-title class="page-header-one" style="font-size: 32px;">Business Application</v-card-title>
        <v-card-text class="body-text">
          <v-form>
            <v-row>
              <v-col cols="12"
              md="4">
              <v-text-field
                v-model="firstname"
                :rules="nameRules"
                label="Applicant name"
                required
              ></v-text-field>
              </v-col>
              <v-col cols="12"
              md="4">
              <v-text-field
                v-model="firstname"
                :rules="nameRules"
                label="Applicant role"
                required
              ></v-text-field>
              </v-col>
              <v-col cols="12"
              md="4">
                <v-text-field
                  v-model="firstname"
                  :rules="nameRules"
                  label="Business Name"
                  required
                ></v-text-field>
              </v-col>
            </v-row>
             <v-row>
              <v-col cols="12"
              md="6">
              <v-text-field
                v-model="firstname"
                :rules="nameRules"
                label="Amount Needed"
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