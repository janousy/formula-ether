<template>
    <div class="raceEnding">
        <img class="raceLoadGif" :src="getRaceLoadGif" alt="Racing Car racing">
        <div v-if="raceIsRunning" class="winnersWrapper">
            <div class="winnerTitle">Winning Team: {{raceWinningTeam}}</div>
            <Winner
                class="winners"
                v-for="(winner, index) in winners"
                :key="index"
                :address="winner"
                :amount="amounts[index]"
            >
            </Winner>
        </div>
    </div>
</template>

<script>
import { mapState } from 'vuex'
import Winner from "../atoms/Winner";
import countDownTimings from "@/consts/countdown.const";

export default {
  name: 'RaceEnding',
  components: { Winner },
  props: {},
  computed: {
    ...mapState('data', {
      raceWinningTeam: (state) => state.raceWinningTeam
    }),
    getRaceLoadGif() {
        return require('@/assets/images/general/race-load-icon.gif');
    }
  },
  data: () => {
    return {
      winners: [],
      timerCount: countDownTimings.countDownRunTime,
      amounts: ['1', '2', '3'],
      ...mapState('data', {
        raceIsRunning: state => state.raceIsRunning,
        winners: state => state.winners
      }),
    }
  }
}
</script>

<style lang="scss" scoped>
    @import "src/styles/fonts.scss";

    .raceEnding {
        height: 100%;
        display: flex;
        align-items: center;
        flex-flow: column;
        .raceLoadGif{
            width: 800px;
            margin-top: 50px;
        }
        .winnersWrapper {
            width: 100%;
            color: white;
            display: inherit;
            flex-flow: inherit;
            align-items: inherit;
            .winnerTitle {
                font-family: F1-Bold;
                font-size: 50px;
                margin-bottom: 30px;
            }
            .winners {
                font-family: F1-Regular;
                font-size: 30px;
                width: 1200px;
                display: flex;
                justify-content: space-between;
            }
        }
    }

</style>
