<template>
    <div class="raceHeader">
        <div class="trackInfoWrapper">
            <div class="trackImageWrapper">
                <img class="trackImage" :src="getRaceImage" alt="Track Image">
            </div>
            <div class="raceName">{{getRaceName}}</div>
        </div>
        <Timer class="timer" @countDownIsZero="callContractStartRace" @resetCounter="updateRaceLocation()"/>
    </div>
</template>

<script>
// TODO fix errors, use state instead of data
import raceLocations from '@/consts/raceLocations.const.js'
import Timer from '@/components/atoms/Timer.vue'

export default {
  /* eslint-disable semi */

  name: 'RaceHeader',
  components: { Timer },
  computed: {
    getRaceImage () {
      return `/src/assets/images/raceTracks/${raceLocations.locations[this.raceCounter]}.png`;
    },
    getRaceName () {
      return raceLocations.raceName[this.raceCounter];
    }
  },
  data: () => {
    return {
      raceCounter: 0
    }
  },
  mounted () {
  },
  methods: {
    callContractStartRace () {
      console.log('contract starts race');
        this.$store.commit('data/setRaceIsRunning', true)
    },
    updateRaceLocation () {
      console.log('race location is updated');
      this.raceCounter = (this.raceCounter + 1) % raceLocations.raceName.length;
      this.$store.commit('data/setRaceIsRunning', false);
    }

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
            .raceName {
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
