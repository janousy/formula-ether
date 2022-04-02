<template>
  <div class="raceWaiting">
    <img class="raceLoadGif" :src="getRaceLoadGif" alt="Racing Car racing">
    <div class="waitingText">{{ getWaitingText }}</div>
    <admin-modal/>
  </div>
</template>

<script>

import {texts} from "@/consts/generalTexts.consts";
import AdminModal from "@/components/molecules/AdminModal";

export default {
  name: 'RaceWaiting',
  components: {AdminModal},
  computed: {
    getRaceLoadGif() {
      return require('@/assets/images/general/race-load-icon.gif');
    },
    getWaitingText() {
      return texts.waitingText;
    }
  },
}
</script>

<style lang="scss" scoped>
@import "src/styles/fonts.scss";

.raceWaiting {
  margin-top: 200px;
  display: flex;
  align-items: center;
  flex-flow: column;

  .raceLoadGif {
    width: 800px;
  }

  .waitingText {
    font-family: F1-Regular;
    color: white;
    font-size: 25px;
  }
}

</style>
