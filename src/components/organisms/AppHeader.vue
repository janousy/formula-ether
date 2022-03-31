<template>
    <div class="AppHeaderWrapper">
        <img class="f1Logo" src="@/assets/images/f1/f1_logo.svg" alt="Formula 1 Logo">
        <span class="text">{{getAppHeaderText}}</span>
        <b-button :disabled="!!address" @click="connectMetamask()" class="metamaskButton">
          Connect
        </b-button>
    </div>
</template>

<script>
import headerTexts from '@/consts/headerTexts.const'
import { mapState } from 'vuex'

export default {
  /* eslint-disable semi */

  name: 'AppHeader',
  computed: {
    getAppHeaderText () {
      return headerTexts.appHeaderTexts[0]
    },
    ...mapState('data', {
      address: (state) => state.account
    }),
  },
  methods: {
  }
}
</script>

<style lang="scss" scoped>
@import "src/styles/fonts.scss";
    .AppHeaderWrapper{
        width: 100%;
        height: 71px;
        background-color: #e10600;
        padding-left: 50px;
        .f1Logo{
            display: inline-block;
            vertical-align: top;
            width: 130px;
            margin: 19px 30px 12px;
        }
        .text {
            display: inline-block;
            font-size: 35px;
            font-weight: bolder;
            color: white;
            margin: 9px 30px 12px;
            font-family: F1-Bold;
        }
        .metamaskButton {
            display: inline-block;
            position: absolute;
            font-family: F1-Bold;
            margin-top: 10px;
            height: 50px;
            right: 10px;
        }

    }

</style>
