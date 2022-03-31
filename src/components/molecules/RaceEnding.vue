<template>
    <div class="raceEnding">
        <img class="raceLoadGif" :src="getRaceLoadGif" alt="Racing Car racing">
        <div class="winnersWrapper">
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
      winners: ['0x0430B96F84978320546cdEbe3BBF4C82AF90A7C1', '0x4C39f414EE0cba4Ae8c9731e5f7e55A5b58C6165', '0xA4653C5a2c085499D5c13D881074f488d12c3926'],
      amounts: ['1', '2', '3']
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
