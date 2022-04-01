<template>
    <div class="raceWaiting">
        <img class="raceLoadGif" :src="getRaceLoadGif" alt="Racing Car racing">
        <div class="waitingText">{{getWaitingText}}</div>
    </div>
</template>

<script>
import { mapState } from 'vuex'
import countDownTimings from "@/consts/countdown.const";
import {waitingText} from "../../consts/waitingTexts.consts";

export default {
  name: 'RaceWaiting',
  components: {},
  props: {},
  computed: {
    ...mapState('data', {
      raceWinningTeam: (state) => state.raceWinningTeam
    }),
    getRaceLoadGif () {
        return require('@/assets/images/general/race-load-icon.gif');
    },
    getWaitingText () {
        return waitingText;
    }
  },
  data: () => {
    return {
      timerCount: countDownTimings.countDownRunTime,
    }
  }
}
</script>

<style lang="scss" scoped>
    @import "src/styles/fonts.scss";

    .raceWaiting {
        margin-top: 200px;
        display: flex;
        align-items: center;
        flex-flow: column;
        .raceLoadGif{
            width: 800px;
        }
        .waitingText {
            font-family: F1-Regular;
            color: white;
            font-size: 25px;
        }
    }

</style>
