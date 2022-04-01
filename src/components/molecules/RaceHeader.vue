<template>
    <div class="raceHeader">
        <div class="trackInfoWrapper">
            <div class="trackImageWrapper">
                <img class="trackImage" :src="getRaceImage" alt="Track Image">
            </div>
            <div class="textWrapper">
                <span>{{getRaceName}}</span>
                <span>Total Bets: {{getTotalBetAmount}} Ether</span>
            </div>

        </div>
        <Timer class="timer" @resetCounter="updateRaceLocation()"/>
    </div>
</template>

<script>
import raceLocations from "../../consts/raceLocations.const";
import Timer from "../atoms/Timer";
import { mapState } from "vuex";

export default {
  name: 'RaceHeader',
  props: {
    totalBetSum: {
        type: Number,
        required: true,
    }
  },
  components: { Timer },
  computed: {
    ...mapState('data', {
      signer: (state) => state.signer,
    }),
    getRaceImage () {
      return require(`@/assets/images/raceTracks/${raceLocations.locations[this.raceCounter]}.png`);
    },
    getRaceName () {
      return raceLocations.raceName[this.raceCounter];
    },
    getTotalBetAmount () {
        return this.totalBetSum;
    }
  },
  data: () => {
    return {
      raceCounter: 0,
    }
  },
  methods: {
    updateRaceLocation () {
      console.log('race location is updated');
      this.raceCounter = (this.raceCounter + 1) % raceLocations.raceName.length;
    },
  }
}
</script>

<style lang="scss" scoped>
    @import "src/styles/fonts.scss";

    .raceHeader {
        width: 100%;
        height: 150px;
        background-color: black;
        display: flex;
        align-items: center;
        justify-content: space-between;
        .trackInfoWrapper {
            padding-top: 15px;
            padding-left: 15px;
            display: flex;
            align-items: center;
            .trackImageWrapper {
                width: 120px;
                margin-right: 20px;
                .trackImage {
                    width: 120px;
                }
            }
            .textWrapper{
                padding-left: 10px;
                display: flex;
                flex-flow: column;
                font-family: F1-Bold;
                color: white;
                font-size: 30px;
            }

        }
        .timer {
            margin-right: 40px;
        }

    }

</style>
