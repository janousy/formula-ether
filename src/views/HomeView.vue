<template>
  <div class="home">
    <AppHeader/>
    <RaceSetup/>
    <b-button class="helpButton" v-b-modal.HelpModal>
      Help
      <i class="bi-question-circle"/>
    </b-button>
    <HelpModal/>
  </div>
</template>

<script>
import AppHeader from "../components/organisms/AppHeader";
import RaceSetup from "../components/organisms/RaceSetup";
import HelpModal from "../components/organisms/HelpModal";

export default {
  name: 'HomeView',
  components: {HelpModal, RaceSetup, AppHeader},
}
</script>

<style lang="scss" scoped>
@import "src/styles/fonts.scss";

.home {
  width: 100%;
  height: 100%;
  background-color: #38383f;
  overflow: auto;

  .helpButton {
    position: absolute;
    bottom: 30px;
    right: 30px;
    font-family: F1-Bold;
    font-size: 20px;
  }
}
</style>
