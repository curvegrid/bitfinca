<template>
  <div>
    <div id="landing" class="landing full-height">
      <v-container>
        <v-row>
            <v-col
              cols="7"
              xs="5"
              md="5">
            <v-img
              :src="require('../assets/BitfincaXLarge.svg')"
              contain
            />
            </v-col>
            <v-col>
              <div justify-center style="padding: 70px 0;">
                <p class="page-title ma-4" style="font-size:50px">Democratising access to <strong>capital.</strong></p>
                <p class="page-subtitle ma-4" style="font-size:28px">Sustainable Solutions for the Community.</p>
                <p class="page-header-one ma-4" style="font-size:20px">
                  BitFinca is a blockchain-based lending platform that allows anyone to microinvest in ventures that matter,
                with no minimum investment.
                </p>
            </div>
            </v-col>
          </v-row>
       <!-- hero end -->
      <v-layout class="mb-10" align-center>
      <v-row>
        <v-col>
          <v-row>
            <v-col>
              <v-card elevation="1">
                <v-card-title class="page-subtitle justify-center">
                  Transparency and decentralization in full.
                </v-card-title>
                <v-card-text class="text-center body-text">
                  The platform is built on the Ethereum blockchain and smart contracts, making sure that it is transparent, efficient, and secure.
                  Through our lending and investment products, BitFinca offers micro-investments in hundreds of decentralized projects and businesses.
                </v-card-text>
              </v-card>
            </v-col>
            <v-col>
              <v-card elevation="1">
                <v-card-title class="page-subtitle justify-center">
                  BitFinca is the platform for democratising access to capital.
                </v-card-title>
                <v-card-text class="text-center body-text">
                  BitFinca is a decentralized project with the purpose of fundraising for various projects.
                  It has a two-tiered token-based ecosystem designed to make the best out of every single microinvestment.
                  </v-card-text>
              </v-card>
            </v-col>
          </v-row>
          <v-row >
            <v-col>
              <v-card elevation="1">
                <v-card-title class="page-subtitle justify-center">
                  Supporting Entrepreneurs
                </v-card-title>
                <v-card-text class="text-center body-text">
                  Bitfinca is a lending platform for the developing world. We provide micro-loans and crowdfund loans for entrepreneurs who need capital to grow their businesses.
                  Our goal is to provide financial services to people who need them, in a safe and trustful way – a better world needs a better financial system.
                </v-card-text>
              </v-card>
            </v-col>
            <v-col>
              <v-card tile elevation="1">
                <v-card-title class="page-subtitle justify-center">
                  Microfinance for a better future.
                </v-card-title>
                <v-card-text class="text-center body-text">
                  Bitfinca provides the financial services of microfinance in a digital world, making them accessible to everyone,
                  no matter their economic status or geographical location. We are a microfinance solution for the community. Creating sustainable solutions for the community one loan at a time.
                  </v-card-text>
              </v-card>
            </v-col>
          </v-row>
        </v-col>
    </v-row>
       </v-layout>
    </v-container>
    </div>
       <!-- end -->

       <!-- how it works -->
  <div id="how">
    <v-container>
       <p class="text-center page-header-one">How it works</p>
       <v-row no-gutters>
         <v-col>
          <v-card tile elevation="0">
            <v-card-title class="justify-center page-header-two ">
              Pick
            </v-card-title>
            <v-card-text class="text-center body-text">
              <img height=150
               :src="require('../assets/icons/clip-welcome.png')">
            </v-card-text>
            <v-card-text class="text-center body-text">
              Pick an entreprenuer to support
            </v-card-text>
          </v-card>
        </v-col>
         <v-col>
           <v-card tile elevation="0">
            <v-card-title class="justify-center page-header-two ">
              Loan
            </v-card-title>
            <v-card-text class="text-center body-text">
              <img height=150
               :src="require('../assets/icons/clip-payment.png')">
            </v-card-text>
              <v-card-text class="text-center body-text">
              Fund a loan
            </v-card-text>
          </v-card>
         </v-col>
         <v-col>
           <v-card tile elevation="0">
            <v-card-title class="justify-center page-header-two ">
              Collect
            </v-card-title>
            <v-card-text class="text-center body-text">
              <img height=150
               :src="require('../assets/icons/clip-done.png')">
            </v-card-text>
            <v-card-text class="text-center body-text">
              Get repaid
            </v-card-text>
          </v-card></v-col>
         <v-col>
           <v-card tile elevation="0">
            <v-card-title class="justify-center page-header-two ">
              Repeat
            </v-card-title>
            <v-card-text class="text-center body-text">
              <img height=150
               :src="require('../assets/icons/clip-relationships.png')">
            </v-card-text>
            <v-card-text class="text-center body-text">
              Reinvest your money or withdraw
            </v-card-text>
          </v-card></v-col>
       </v-row>
    </v-container>
  </div>
  <!-- how it works end -->

  <div id="bottom">
  <v-container>
    <br/><br/>
    <p class="text-center page-header-one"> Ready to dive in?</p>
    <br/>
    <p class="text-center page-subtitle">
       Bitfinca has created an innovative,
        fully transparent and secure platform that democratises access to capital for everyone. The loan application process takes only minutes via your smartphone or computer.
    </p>
       <v-row no-gutters>
            <v-col>
              <v-card color="transparent" elevation="0">
                <v-card-title class="page-subtitle justify-center">
                  Join as a lender
                </v-card-title>
                <v-card-text class="text-center body-text">
                  Investors will always be able to make more money with lending than they would just holding the coin.
                  Borrowers will always need capital, and if they pay it back then they will have more capital for another loan if needed.
                </v-card-text>
                <v-card-action class="justify-center">
                    <p class=text-center><v-btn
                      rounded
                      class="ma-5 page-button"
                      href="/lend">
                      Lend
                    </v-btn></p>
                </v-card-action>
              </v-card>
            </v-col>
            <v-col>
              <v-card color="transparent" elevation="0">
                <v-card-title class="page-subtitle justify-center">
                  Join as a borrower
                </v-card-title>
                <v-card-text class="text-center body-text">
                  Borrowers will have access to cheap loans, investors will have access to a higher earning opportunity.
                  Bitfinca's decntralized microfinance model allows us to loan out money at lower rates and also charge less fees.
                  </v-card-text>
                  <v-card-action class="justify-center">
                    <p class=text-center><v-btn
                      rounded
                      class="ma-5 page-button"
                      href="/borrow">
                      Borrow
                    </v-btn></p>
                  </v-card-action>
              </v-card>
            </v-col>
          </v-row>
  </v-container>
  </div>
  </div>
</template>

<script>
export default {
  name: "Home",
  data: () => ({
    how: [
      {title: "Pick", description: "Pick an entreprenuer to support"},
    ]
  }),
};
</script>

<style>
  #landing {
    background: -webkit-linear-gradient(to right, #FFFFFF, #C0EAED, #E9CAE2);
    background: linear-gradient(to right, #FFFFFF, #C0EAED, #E9CAE2);
    background: url('../assets/background.png') no-repeat center;
    -webkit-background-size: cover;
    -moz-background-size: cover;
    -o-background-size: cover;
    background-size: cover;
  }
  #bottom {
    background: -webkit-linear-gradient(to right, #FFFFFF, #C0EAED, #E9CAE2);
    background: linear-gradient(to right, #FFFFFF, #C0EAED, #E9CAE2);
    /* background: url('../assets/backgroundbottom.png') no-repeat center; */
    -webkit-background-size: cover;
    -moz-background-size: cover;
    -o-background-size: cover;
    background-size: cover;
  }

</style>
