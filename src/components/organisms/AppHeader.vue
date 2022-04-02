<template>
  <div class="AppHeaderWrapper">
    <img class="f1Logo" :src="getF1Logo" alt="Formula 1 Logo">
    <span class="text">{{ getAppHeaderText }}</span>
    <b-button :disabled="!!signer" @click="connectMetamask()" class="metamaskButton">
      {{ getButtonText }}
    </b-button>
  </div>
</template>

<script>
import headerTexts from "../../consts/headerTexts.const";
import {mapState} from 'vuex'
import {ethers} from "ethers";

export default {
  name: 'AppHeader',
  computed: {
    ...mapState('etherStore', {
      signer: state => state.signer,
    }),
    getF1Logo() {
      return require('@/assets/images/f1/f1_logo.svg');
    },
    getAppHeaderText() {
      return headerTexts.appHeaderTexts[0]
    },
    getButtonText() {
      return this.signer ? 'Connected' : 'Connect';
    }
  },
  created() {
    if (!this.signer) {
      this.connectMetamask();
    }
  },
  methods: {
    async connectMetamask() {
      const provider = new ethers.providers.Web3Provider(window.ethereum);
      await provider.send("eth_requestAccounts", []);
      const accountsList = await provider.listAccounts();
      const signer = provider.getSigner();
      this.$store.commit('etherStore/setSigner', signer);
      this.$store.commit('etherStore/setAddress', accountsList[0]);
      console.log('Metamask successfully connected')
    }
  },
}
</script>

<style lang="scss" scoped>
@import "src/styles/fonts.scss";

.AppHeaderWrapper {
  width: 100%;
  height: 71px;
  background-color: #e10600;
  position: sticky;
  top: 0;
  z-index: 5;

  .f1Logo {
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
    font-size: 20px;
  }
}

</style>
